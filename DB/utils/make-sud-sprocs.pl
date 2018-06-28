#!/usr/bin/env perl

=head1 DESCRIPTION

Create CRUD (Create Read Update Delete) Stored Procedures for any given table.

We use one Upsert SP for both Create and Update.

=cut

use Modern::Perl;
use lib 'PO_Lib';
use Carp;
use Custom::TestHelper qw(mssql_dbh);
use Data::Dumper;

our $db_name = $ARGV[0] || croak "db_name required";
our $table = $ARGV[1] || croak "table required";
our $comment = $ARGV[2] || '';
our $dbh = mssql_dbh($db_name);
$dbh->begin_work();

my @tables;
if ($table eq 'all') {
    #@tables = qw(
    #    Discounts DiscCoupons DiscStores
    #    DiscQualifyingTags DiscRewardTags DiscUses
    #    Tag TagModel TagQtyDiscountBreak TagQtyPriceBreak
    #);
    @tables = qw(
        Discounts DiscCoupons DiscStores
        DiscQualifyingTags DiscRewardTags
        DiscUses DiscValidOnDays DiscAllowedCustGroups
        PIMAppliedCoupons
    );
}
else {
    @tables = ($table);
}
if (not $comment) {
    $comment = 'Create sprocs for ' . join(', ', @tables);
}
say "-- $comment";

start_tran();
for my $table (@tables) {
    for my $action ('Select', 'Upsert', 'Delete') {
        my $sp_name = "[sp_${table}_${action}]";
        say qq{if object_id('$sp_name') is not null};
        say qq{    drop procedure $sp_name;};
    }
}
say "go";

for my $table (@tables) {
     process_table($table);
}
commit_tran();

sub start_tran {
    print qq{
set xact_abort on;
go
begin tran;
go
};
}

sub commit_tran {
    print "\n";
    say q{commit tran;}
};

=pod

# sp_columns doesn't give primary key information.
#my $meta_sql = "exec sp_columns $table";

# Old verison:
my $meta_sql = qq{
select
    c.name as col_name,
    t.name as col_type,
    c.max_length,
    c.precision,
    c.scale,
    c.is_nullable,
    coalesce(is_primary_key, 0) as is_primary_key
from sys.columns c
inner join sys.types t on c.system_type_id = t.system_type_id
left outer join sys.index_columns ic on
    ic.object_id = c.object_id and ic.column_id = c.column_id
left outer join sys.indexes i
    on ic.object_id = i.object_id and ic.index_id = i.index_id
where c.object_id = object_id('$table')
};

=cut

sub process_table {
    my ($table) = @_;

    print qq{
/*****************************************************************************
 * Stored procedures for the "$table" table.
 ****************************************************************************/
};
    # This appears to return columns in their ordinal position, but
    # it would be better if I found an ordinal column in the
    # information_schema somewhere and added an explicit order by
    # clause.
    my $meta_sql = qq{
    select c.column_name as col_name, c.data_type as col_type,
        c.character_maximum_length as max_length,
        c.numeric_precision as precision, c.numeric_scale as scale,
        c.is_nullable,
        case when z.constraint_name is null then 0 else 1 end
        as is_primary_key,
        columnproperty(object_id(table_name), column_name, 'IsIdentity')
            as is_identity
    from information_schema.columns as c
    outer apply (
        select ccu.constraint_name
        from information_schema.table_constraints as tc
            join information_schema.constraint_column_usage as ccu
                on ccu.constraint_name = tc.constraint_name
        where tc.table_schema = c.table_schema
            and tc.table_name = c.table_name
            and tc.constraint_type = 'primary key'
            and ccu.column_name = c.column_name
    ) as z
    where c.table_name = '$table'
    };

    my $metadata = $dbh->selectall_arrayref($meta_sql, {Slice => {}});

    #die Dumper($metadata);
    #say Dumper($metadata);
    #my $row_count = scalar @$metadata;
    #say "Got $row_count metadata rows.";
    #say "Columns: " . join(", ", map { $_->{col_name} } @$metadata );

    my @cols = map {"[$_->{col_name}]"} @$metadata;
    my @pk_meta = grep { $_->{is_primary_key} } @$metadata;
    my @non_pk_meta = grep { not $_->{is_primary_key} } @$metadata;
    my @pk_vars_with_types = map {col_with_type($_)} @pk_meta;
    my @col_vars_with_types = map {
        col_with_type($_) . ($_->{is_identity} ? " = null output" : '')
    } @$metadata;
    my @pks_eq_vals = map {"[$_->{col_name}] = \@$_->{col_name}"} @pk_meta;

    #say "All columns with types:\n" . join("\n", @col_vars_with_types) . "\n\n";

    my $format = ",\n    ";
    my $pk_vars_with_types = join($format, @pk_vars_with_types);
    my $pks_eq_vals = join("\n    and ", @pks_eq_vals);
    my $cols = join($format, @cols);
    # SET NOCOUNT ON at start of each SP, and turn it off at the end of each sp.
    my $template = qq!
create proc [sp_${table}_Select]
    $pk_vars_with_types
as
set nocount on
select
    $cols
from $table
where
    $pks_eq_vals
set nocount off
go
    !;

    my $col_vars_with_types = join($format, @col_vars_with_types);

    my @cols_as_vars = map {"\@$_->{col_name}"} @$metadata;
    my $cols_as_vars = join($format, @cols_as_vars);

    my @merge_join_clauses
        = map {"Target.$_ = Source.$_"} map {$_->{col_name}} @pk_meta;
    my $merge_join_clauses = join("\n    and ", @merge_join_clauses);

    my @cols_eq_src = map {"$_ = Source.$_"} map {$_->{col_name}} @$metadata;
    my $cols_eq_src = join(",\n        ", @cols_eq_src);

    my @non_pk_cols_eq_src
        = map {"$_ = Source.$_"} map {$_->{col_name}} @non_pk_meta;
    my $non_pk_cols_eq_src = join(",\n        ", @non_pk_cols_eq_src);
    # If all of the columns are part of the primary key, then @non_pk_meta
    # will be empty, and we don't need to do anything for the update.
    # To change keys, the caller would need to delete the old record
    # and upsert a new record. The matched clause will be empty otherwise.
    my $matched_clause = '';
    if ($non_pk_cols_eq_src) {
        $matched_clause = qq!
when matched then
    update set
        $non_pk_cols_eq_src
!;
    }

    # If it's an Identity, change the insert part of the merge statement
    # so that it excludes the primary key column and variable.
    # In other words, if ($has_identity) { $insert = $non_pk_cols )
    # else {$insert = $all_cols}
    my @insert_cols;
    my @insert_value_variables;
    my $select_identity_if_applicable;
    if (scalar @pk_meta == 1 and $pk_meta[0]->{is_identity}) {
        @insert_cols =  map {"[$_->{col_name}]"} @non_pk_meta;
        @insert_value_variables
            = map {"Source.$_"} map {$_->{col_name}} @non_pk_meta;
        $select_identity_if_applicable
            = "select \@$pk_meta[0]->{col_name} = \@\@Identity;"
    }
    else {
        @insert_cols = @cols;
        @insert_value_variables
            = map {"Source.$_"} map {$_->{col_name}} @$metadata;
        $select_identity_if_applicable = '';

    }

    # Format for 8 spaces to make it clearer to read.
    my $insert_cols_8 = join(",\n        ", @insert_cols);
    my $insert_value_variables_8
        = join(",\n" . ' ' x 8, @insert_value_variables);


    $template .= qq!
create proc [sp_${table}_Upsert]
    $col_vars_with_types
as
merge $table as Target
using (
    select
    $cols_as_vars
)
as Source (
    $cols
)
on (
    $merge_join_clauses
)$matched_clause
when not matched then
    insert (
        $insert_cols_8
    )
    values (
        $insert_value_variables_8
    );
$select_identity_if_applicable
go
    !;

    # Delete
    $template .= qq{
create proc [sp_${table}_Delete]
    $pk_vars_with_types
as
set nocount on

delete from $table where
    $pks_eq_vals

set nocount off
go
    };

    print $template;

    return;
}


sub col_with_type {
    my ($meta) = @_;
    my $type = $meta->{col_type};
    my $out = "\@$meta->{col_name} $type";

    if ($type =~ /^decimal$/i and $meta->{precision}) {
        $out .= "($meta->{precision}, $meta->{scale})";
    }
    elsif ($type =~ /^char|n?varchar$/i) {
        my $length = $meta->{max_length} || 'max';
        $length = 'max' if $length == -1;
        $out .= "($length)";
    }

    return $out;
}
