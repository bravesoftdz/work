#!/usr/bin/env perl

=head1 NAME

001-Discounts.t - Automated testing code for the discount system.

=head1 SETUP

Currently uses hard-coded SQL-Server instance and database name. See the
documentation in Custom::TestHelper.

 perl tests/001-Discounts.t
 prove tests/001-Discounts.t
 prove tests/

=head1 TODO

Eventual testing strategy will be this:

 * Call library to setup Models, Tags, PreInventoryMov rows, etc.
 * Pass in custom data to library for this particular test, or update manually,
   (and it will probably call routines that are part of other tests in order
   to build up the environment first).
 * Perform all the tests.
 * Rollback completely and start over for next test.

=head1 NOTES

The following error will occur if you use functional indexes, because
MainRetails sets ARITHABORT OFF.

INSERT failed because the following SET options have incorrect settings:
'ARITHABORT'. Verify that SET options are correct for use with indexed
views and/or indexes on computed columns and/or filtered indexes and/or
query notifications and/or XML data type methods and/or spatial index
operations. (SQL-42000)

=cut
#package DiscountTester;
#use Test::More;
#use Mouse;
#has 'misc' => (is => 'rw');
#sub new { my ($class) = shift; bless {}, $class; }

package DiscountTests;
use Modern::Perl;
use Mouse;
use lib "../po_util/lib";
use lib "PO_lib";
use Custom::DB qw(generic_insert);
use Data::Dumper;
use PO::Logging;
use Carp;
use Test::More;
use DateTime;

#*rdump1 = \&PO::Logging::rdump1;

# Contains test data.
#has 't' => (
#    is => 'rw',
#    isa => 'DiscountTester',
#    default => sub { DiscountTester->new(); },
#);
has 'dbh' => (is => 'ro', isa => 'DBI::db', required => 1);

sub IDTipoPessoa_Customers {
    return $_[0]->dbh->selectrow_array(q{
        select IDTipoPessoa from TipoPessoa where TipoPessoa = 'Customers'
    });
}

# Pick the first active store as our test.
sub IDStore {
    return $_[0]->dbh->selectrow_array(q{
        select top 1 IDStore
        from Store
        where System = 0 and Desativado = 0 and Hidden = 0
        order by IDStore
    });
}

# For now, Pick the first customer as our test and then just alter his
# values as needed.
sub IDPessoa {
    my ($self, %opt) = @_;
    return $self->dbh->selectrow_array(qq{
        select top 1 IDPessoa
        from Pessoa
        where IDTipoPessoa = $opt{IDTipoPessoa}
        order by IDPessoa
    });
}

# Just pick whatever is the first non-hidden, active
# usertype, which is typically the "Administrator"
sub IDUser {
    return $_[0]->dbh->selectrow_array(q{
        select top 1 IDUser
        from SystemUser
        where
            System = 0 and Desativado = 0 and Hidden = 0
            and UserTypeID = (
                select top 1 IDUserType
                from UserType
                where Desativado = 0 and Hidden = 0
                order by IDUserType
            )
        order by IDUser
    });
}

#{
#    my $attribute = 'sp_PreSale_AddItem2';
#    *{ __PACKAGE__ . '::' . $attribute } = sub {
#        my $self = shift;
#        #$self->{$attribute} = shift if @_;
#        #return $self->{$attribute};
#        return 'foo';
#    };
#}

sub get_sp_info {
    my ($t, %opt) = @_;
    my $sp_name = $opt{sp_name};
    my $sp_info = [
        {
            sp_name => 'sp_Discounts_Upsert',
            defaults => [
                IDDiscount => "\@NewIDDiscount OUTPUT",
                DiscountName => 'Test discount.',
                StartOn => '2013-01-01 01:01:01',
                EndOn => '2038-01-18 03:14:07',
                BeginTimeOfDay => undef,
                EndTimeOfDay => undef,
                DiscType => 'promo',
                MinSubtotal => undef,
                IDStore => undef,
                MaxUsesPerCustomer => undef,
                MaxUsesInTotal => undef,
                FirstTimeCustomerOnly => 0,
                CustomerCardRequired => 0,
                IsStackable => 0,
                RewardAmount => 0.85,
                AmountType => 'Percent Off Item',
                RewardQuantity => undef,
                MinQuantity => undef,
                MinDollarAmount => undef,
            ]
        },
        {
            sp_name => 'sp_PreSale_AddItem',
            defaults => [
                PreSaleID           => $t->{DocumentID},
                IDCliente           => $t->{IDCliente},
                ModelID             => $t->{IDModel},
                StoreID             => $t->{IDStore},
                UserID              => $t->{IDUser},
                IDComission         => undef,
                Qty                 => $t->{Qty},
                SalePrice           => $t->{SellingPrice},
                CostPrice           => ($t->{SellingPrice} / 2),
                Discount            => undef,
                MovDate             => '2014-01-01 12:00:00',
                ResetDiscount       => 0,
                Manager             => 0,
                Date                => '2014-01-01 12:00:00',
                IDPreInvMovExchange => undef,
                PreInvMovParentID   => undef,
                IDDepartment        => 0,
                Promo               => 0,
                IDDescriptionPrice  => 0,
                IDVendorPrice       => 0,
                SuggPrice           => 0,
                DocumentNumber      => '',
                IDDocumentType      => undef,
                SequencyNum         => 0,
                TotParcial          => '',
                DiscountPromo       => 0,
                UnitDiscount        => undef,
                PreInventMovID      => $t->{IDPreInventoryMov},
                ManualDiscount      => undef,
                IDSpecialPrice      => undef,
                ManualPrice         => undef,
            ],
        },
        {
            sp_name => 'sp_PreSale_SetDiscount',
            defaults => [
                DocumentID          => $t->{DocumentID},
            ],
        },
        {
            sp_name => 'sp_PreSale_CalcPrice',
            defaults => [
                IDModel => $t->{IDModel},
                StoreID => $t->{IDStore},
                Qty => $t->{Qty},
                IDPreInventoryMov => $t->{IDPreInventoryMov},
                #SpecialPriceID int = null,
                #ManualPrice money = null
            ],
        },
        {
            sp_name => 'sp_PreSale_Coupon_Upsert',
            defaults => [
                DocumentID          => $t->{DocumentID},
                CouponCode          => $t->{CouponCode},
            ],
        },
    ];

    my ($sp_data) = grep {$_->{sp_name} eq $sp_name} @$sp_info;
    croak "Could not find information (e.g. defaults) for sproc '$sp_name'"
        unless $sp_data;

    return $sp_data;
}

sub sp_PreSale_CalcPrice {
    my ($t, %opt) = @_;
    return $t->exec_sp(
        sp_name => 'sp_PreSale_CalcPrice',
        return_results => 1,
        %opt,
    );
}
sub sp_PreSale_SetDiscount {
    return $_[0]->exec_sp(
        sp_name => 'sp_PreSale_SetDiscount',
    );
}

sub sp_PreSale_AddItem {
    my ($t, %opt) = @_;
    return $t->exec_sp(
        sp_name => 'sp_PreSale_AddItem',
        %opt,
    );
}

sub set_discount {
    my ($t) = @_;
    croak "Current set_discount method is undefined"
        unless defined $::SET_DISCOUNT_METHOD;

    if ($::SET_DISCOUNT_METHOD eq 'sp_PreSale_SetDiscount') {
        $t->sp_PreSale_SetDiscount;
    }
    elsif ($::SET_DISCOUNT_METHOD eq 'sp_PreSale_AddItem') {
        $t->sp_PreSale_AddItem;
    }
    else {
        croak "Unknown set_discount method '$::SET_DISCOUNT_METHOD'";
    }

    return;
}

sub exec_sp {
    my ($t, %opt) = @_;

    my $sp_name = $opt{sp_name} || croak "sp_name requried";
    #my $defaults = $opt{defaults} || croak "defaults required.";
    my $sp_info = $t->get_sp_info(%opt);
    my $defaults = $sp_info->{defaults};
    my ($cols, $cols_vals) = override_defaults($defaults, \%opt);
    #croak "stuff: " . Dumper({cols => $cols, cols_vals => $cols_vals,
    #    defaults => $defaults});
    my $identity_col = $opt{identity_col} || '';
    my $identity_col_var = "\@New_${identity_col}";
    my $identity_col_defn = "$identity_col_var int";
    my $identity_declare_clause = "declare $identity_col_defn";

    my @params;
    for my $col (@$cols) {
        my $val = $cols_vals->{$col};
        if ($col eq $identity_col) {
            $val = "$identity_col_var OUTPUT";
        }
        $val = $t->dbh->quote($val)
            unless defined $val
                and (substr($val, 0, 1) eq '@' or $val =~ /^-?[.0-9]+$/);
        #$val = 'null' if not defined $val;
        push @params, "\@${col} = $val";
    }
    my $all_params = join(",\n    ", @params);
    my @lines;
    if ($identity_col) {
        @lines = (
            "$identity_declare_clause;",
            "exec $sp_name",
            "    $all_params;",
            "select $identity_col_var;",
        );
    }
    else {
        @lines = (
            "exec $sp_name",
            "    $all_params;",
        );
    }
    my $sql = join("\n", @lines);
    say "sql:\n\n$sql\n" if $opt{print_sql};

    my $key_value;
    $opt{return_results} = 1 if $identity_col;

    if ($opt{return_results}) {
        my $key_value = $t->dbh->selectrow_array($sql);
        return $key_value;
    }
    else {
        $t->dbh->do($sql);
    }
    #say "Got value $key_value";
    return $key_value;
}

sub override_defaults {
    my ($defaults, $overrides) = @_;

    my %cols_vals;
    my @cols;
    for my $c (0 .. ((@$defaults - 1)/2)) {
        my $col = shift @$defaults;
        my $val = shift @$defaults;
        if (exists $overrides->{$col}) {
            $val = $overrides->{$col};
        }
        $cols_vals{$col} = $val;
        push @cols, $col;

    }

    #my %values = %$defaults;
    #while (my ($key, $val) = each %$defaults) {
    #    $values{$key} = $overrides->{$key}
    #        if exists $overrides->{$key};
    #}

    return (\@cols, \%cols_vals);
}

sub typical_data {
    my ($t) = @_;

    my $dbh = $t->dbh;

    # sizeof(int) = 2,147,483,647, so let's go with something around there
    # to avoid the risk of collisions with existing data.
    $t->{dbh} = $dbh;
    $t->{IDCliente} = 1;        # Todo: select top client
    $t->{IDModel} = 1100000001;
    $t->{ModelID} = $t->{IDModel};
    $t->{Model} = "Test Model $t->{ModelID}";
    $t->{DocumentID} = 1200000001;
    $t->{IDPreInventoryMov} = $t->{DocumentID} + 1001;
    $t->{IDGroup} = 1300000001;
    $t->{IDDepartment} = 1300000001;
    # Keep both names in case end up needed alternate IDTipoPessoa values.
    $t->{IDTipoPessoa_Customers} = $t->IDTipoPessoa_Customers;
    $t->{IDTipoPessoa} = $t->{IDTipoPessoa_Customers};
    $t->{IDStore} = $t->IDStore;
    $t->{StoreID} = $t->{IDStore};
    $t->{IDPessoa} = $t->IDPessoa(IDTipoPessoa => $t->{IDTipoPessoa_Customers});
    $t->{IDUser} = $t->IDUser;

    $t->{Qty} = 3;
    $t->{SellingPrice} = 100.00;

    generic_insert($dbh, 'Inv_Department', {
        IDDepartment => $t->{IDDepartment},
        Department => 'Test Department',
        System => 0,
        Desativado => 0,
    });

    generic_insert($dbh, 'TabGroup', {
        IDGroup => $t->{IDGroup},
        Name => 'Test Group',
        UseSalePricePercent => 0,
        UseMSRPPercent => 0,
        IDDepartment => 0,
    });

    generic_insert($dbh, 'Model', {
        IDModel => $t->{IDModel},
        GroupID => $t->{IDGroup},
        Model => 'Test Model',
        Description => 'Test Description',
        Verify => 0,
        Desativado => 0,
        Hidden => 0,
        SendToTrash => 0,
        ScaleValidDay => 1,
        SellingPrice => $t->{SellingPrice},
    });

    generic_insert($dbh, 'Invoice', {
        IDPreSale => $t->{DocumentID},
        PreSaleDate => '2014-01-01',
        Canceled => 0,
        IDCustomer => $t->{IDPessoa},
    });

    #my $debug_row = $dbh->selectrow_arrayref(
    #    "select * from Model where IDModel = ?",
    #    {}, $t->{IDModel}
    #);

    # Create a PreInventoryMov row, skipping a lot of nullable columns.
    my $sql = qq{
        insert into PreInventoryMov (
            IDPreInventoryMov,
            InventMovTypeID,
            StoreID,
            ModelID,
            IDPessoa,
            UserID,
            DocumentID,
            SalePrice,
            IDDepartment,
            Qty,
            Discount
        )
        select
            $t->{IDPreInventoryMov},
            -- Alternate examples are 'Bought' and 'N/A'.
            (select IDInventMovType from InventoryMovType where Name = 'Sold'),
            $t->{IDStore},
            $t->{IDModel},
            $t->{IDPessoa},
            $t->{IDUser},
            $t->{DocumentID},
            (select SellingPrice from Model where IDModel = $t->{IDModel}),
            $t->{IDDepartment},
            $t->{Qty},
            0.00;
    };
    #print $sql;
    $dbh->do($sql);

    return $t;
}

sub insert_Model {
    my ($t, %opt) = @_;
    my $t2 = generic_override($t, \%opt);


    my $Model = ($t2->{Model} || 'Test Model');
    #say "Going to insert with Model => $Model, t->{Model} = $t->{Model}, \$opt{Model} = $opt{Model}";

    generic_insert($t->dbh, 'Model', {
        IDModel => $t2->{IDModel},
        GroupID => $t2->{IDGroup},
        Model => $Model,
        Description => $t2->{Description} || 'Test Description',
        Verify => 0,
        Desativado => 0,
        Hidden => 0,
        SendToTrash => 0,
        ScaleValidDay => 1,
        SellingPrice => $t2->{SellingPrice},
    });

    return;
}

sub generic_override {
    my ($t, $opt) = @_;

    my %t2 = %$t;
    my $t2 = \%t2;
    while (my ($key, $val) = each %$opt) {
        $t2->{$key} = $val if exists $t2->{$key};
    }

    return $t2;
}

sub insert_PreInventoryMov {
    my ($t, %opt) = @_;

    my $t2 = generic_override($t, \%opt);
    my $sql = qq{
        insert into PreInventoryMov (
            IDPreInventoryMov,
            InventMovTypeID,
            StoreID,
            ModelID,
            IDPessoa,
            UserID,
            DocumentID,
            SalePrice,
            IDDepartment,
            Qty,
            Discount
        )
        select
            $t2->{IDPreInventoryMov},
            -- Alternate examples are 'Bought' and 'N/A'.
            (select IDInventMovType from InventoryMovType where Name = 'Sold'),
            $t2->{IDStore},
            $t2->{IDModel},
            $t2->{IDPessoa},
            $t2->{IDUser},
            $t2->{DocumentID},
            (select SellingPrice from Model where IDModel = $t2->{IDModel}),
            $t2->{IDDepartment},
            $t2->{Qty},
            0.00;
    };
    $t->dbh->do($sql);

    return;
}
sub has_discount {
    my ($t, %opt) = @_;

    my $pim_rows = $t->dbh->selectall_arrayref(
        'select * from PreInventoryMov where DocumentID = ?',
        {Slice => {}}, $t->{DocumentID}
    );

    ok($pim_rows, "Got one or more PIM rows");
    my $UnitDiscount = $pim_rows->[0]->{UnitDiscount} || 0;
    ok($UnitDiscount > 0,
        "UnitDiscount on the first row is more than zero ($UnitDiscount)");

    if (my $expected_UnitDiscount = $opt{UnitDiscount}) {
        is($UnitDiscount + 0, $expected_UnitDiscount + 0,
            "UnitDiscount is the expected \$$expected_UnitDiscount");
    }

    #my $invoice_row = $t->dbh->selectrow_arrayref(
    #    'select * from Invoice where IDPreSale = ?',
    #    {}, $t->{DocumentID}
    #);

    return;
}

sub TotalInvoiceDiscount {
    my ($t) = @_;

    my ($total_discount) = $t->dbh->selectrow_array(
        "select ItemDiscount from Invoice where IDPreSale = ?",
        {}, $t->{DocumentID}
    );

    return $total_discount;
}

sub has_no_discount {
    my ($t) = @_;
    my $total = $t->TotalInvoiceDiscount || 0;
    is($total + 0, 0, "No discount, as expected.");
}

sub test_view_parts {
    my ($t) = @_;

    my @views = qw(
        vw_All_Discounts
        vw_Potential_Discounts
        vw_SelectFinalDiscounts
    );

    for my $view (@views) {
        my $sql = "select * from $view where DocumentID = $t->{DocumentID}";
        my $rows = $t->dbh->selectall_arrayref($sql, {Slice => {}});
        my $row_count = scalar @$rows;
        ok($row_count, "Got more than one ($row_count) rows for view $view");
    }

    return;
}

sub test_restriction_views {
    my ($t, %opt) = @_;

    croak "expected_to_fail is a required argument"
        unless $opt{expected_to_fail};

    my @restriction_views = qw(
        vw_DiscTimeRestrictions
        vw_DiscDayRestrictions
        vw_DiscSubTotalRestriction
        vw_ValidDiscStores
        vw_ValidMinQuantityDiscounts
        vw_ValidCustGroupsDiscounts
        vw_ValidCustRestrDiscounts
        vw_ValidFirstTimeRestrictionDiscounts
    );

    my $etf = $opt{expected_to_fail};
    for my $IDPIM ($t->{IDPreInventoryMov}) {
        for my $view (@restriction_views) {
            my $row = $t->dbh->selectall_arrayref(
                "select * from $view where DocumentID = ? and IDDiscount = ? and IDPreInventoryMov = ?",
                {Slice => {}},
                $t->{DocumentID}, $t->{IDDiscount}, $IDPIM
            );
            my $expected;
            if ($view eq $etf or $etf eq 'all') {
                $expected = 0;
            }
            else {
                $expected = 1;
            }
            is(@$row, $expected, "$IDPIM had $expected rows for $view, as expected");
        }
    }

    return;
}


sub test_with_conditions {
    my ($t, $test) = @_;

    #pass "Test conditions: " . rdump1($test);
    if ($test->{broken}) {
        pass "# skip this test because it's already known to be broken <<>>>";
        return;
    }
    my $discount_opt = $test->{discount_opt} || {};
    $t->add_typical_discount(%$discount_opt);
    if (exists $test->{InsertDiscUses}) {
        $t->add_random_DiscUses(count => $test->{InsertDiscUses});
    }
    $t->set_discount;
    my %expect;
    if (exists $test->{expect}) {
        my $expect = $test->{expect};
        %expect = %$expect;
        #%expect = %{$test->{expect}};
    }
    $t->test_restriction_views(%expect);
    if ($expect{expected_to_fail} eq 'none') {
        $t->has_discount;
    }
    else {
        $t->has_no_discount;
    }

    return;
}


sub add_typical_discount {
    my ($t, %opt) = @_;

    # %opt is used to override defaults.
    $t->{IDDiscount} = $t->exec_sp(
        sp_name => 'sp_Discounts_Upsert',
        identity_col => 'IDDiscount',
        %opt
    );

    return;
}

sub add_random_DiscUses {
    my ($t, %opt) = @_;

    my $count = $opt{count} || 1;

    my $random_IDInventoryMov_values = $t->dbh->selectcol_arrayref(qq{
        select top $count IDInventoryMov from InventoryMov
    });

    for my $random_IDInventoryMov (@$random_IDInventoryMov_values) {
        generic_insert($t->dbh, 'DiscUses', [
            {IDDiscount => $t->{IDDiscount}},
            {IDInventoryMov => $random_IDInventoryMov},
        ]);
    }

    return;
}

sub test_typical_data {
    my ($t) = @_;

    my @required = qw(
        IDTipoPessoa_Customers
        IDStore
        IDPessoa
        IDUser
    );
    for my $required (@required) {
        croak "Could not get value for '$required'"
            unless defined $t->{$required};
    }

    return;
}

# This type of testing is pretty common, but a better name is needed.
sub test_a {
    my ($t, %opt) = @_;

    $t->set_discount;
    $t->test_restriction_views(%opt);
    if ($opt{expected_to_fail} eq 'none') {
        $t->has_discount;
    }
    else {
        $t->has_no_discount;
    }

    return;
}

sub test_b {
    my ($t) = @_;
    $t->set_discount;
    $t->has_discount;
    return;
}

package main;
use Modern::Perl;
use Test::More qw(no_plan);
use Data::Dumper;
use DBI;
use English;
use File::Basename;
use lib "../po_util/lib";
use lib "PO_lib";
use Custom::DB qw(generic_insert);
use Custom::TestHelper qw(mssql_dbh);
use Carp;
use Test::Most;
use Benchmark ':hireswallclock';
use PO::Logging;

my $opt;
my $dbh = mssql_dbh('test_db_2014');
$dbh->{RaiseError} = 1;
$dbh->{PrintError} = 0;

# Enable these two and redirect stdout to > $null in order to get the raw sql.
# Unfortunately it doesn't seem to include SP calls?
#$dbh->{odbc_exec_direct} = 1;
#$dbh->trace('SQL');
#bail_on_fail;

# Sometimes I want to run tests on a database that nick gives me with discounts
# already in it.

$::SET_DISCOUNT_METHOD = 'sp_PreSale_SetDiscount';
start_of_tests:
$dbh->begin_work();

$opt->{current_test} = 1 if $ARGV[0] and $ARGV[0] eq 'current_test';
goto current_test if $opt->{current_test};

$dbh->do("delete from Discounts");
#add_recalc_param($dbh);

# TODO: Allow override of specific parts of the default test scenario.
sub setup_typical_test {
    #pass('Rollback transaction and setup new test  <=======================>');
    $dbh->rollback;
    $dbh->begin_work;
    my $t = DiscountTests->new(dbh => $dbh)->typical_data();
    $t->dbh->do("delete from Discounts");
    $t->test_typical_data();
    return $t;
}

sub test_query {
    my (%opt) = @_;
    my $dbh = $opt{dbh};
    my $sql = $opt{sql};
    my $params = $opt{params} || [];
    my $results = $dbh->selectall_arrayref($sql, {Slice => {}}, @$params);
    pass Dumper($results);

    return;
}

sub add_recalc_param {
    my ($this_dbh) = @_;

    $this_dbh->do(q{
        insert into Param (
            IDParam, SrvParameter, SrvValue, SrvType, DefaultValue, Desativado, IDMenu,
            Description
        )
        values (
            118, 'Recalculate discounts on each item', 'Item', 'Boolean', 'Item', 0, 1,
            'If this option is Item, then discounts will recalculate as each item is '
            + 'added to the cart.  Set to Sale to have discounts recalcualte only when '
            + 'Process is pressed.'
        );
    });

    return;
}

# Test bare minimum database functionality first, then add complexity.
{
    ok($dbh->ping(), 'Got database connection OK.');
    my @row = $dbh->selectrow_array("select top 1 IDModel from Model");
    ok($row[0], 'Confirmed that Model table has at least one row');
}

{

    # If this option is Item, then discounts will recalculate as each item is
    # added to the cart.  Set to Sale to have discounts recalcualte only when
    # Process is pressed.
    my ($ParamValue) = $dbh->selectrow_array(
        "select SrvValue from Param where IDParam = 118"
    );
    is($ParamValue, 'Item',
        "Param 118 ('Recalculate discounts on each item') is set correctly");
}

#current_test:
{
    my $t = setup_typical_test();
    my $ManualUnitDiscount = 2.50;
    #my $Qty = 3;
    my $ExpectedDiscount = $ManualUnitDiscount * $t->{Qty};
    my $pim;

    $pim->{before} = $dbh->selectrow_hashref(
        "select * from PreInventoryMov where DocumentID = $t->{DocumentID}"
    );
    #
    is($pim->{before}{UnitDiscount}, undef, "No manual discount at start.");
    generic_insert(
        $dbh, 'ManualDiscount',
        [
            {IDPreInventoryMov => $t->{IDPreInventoryMov}},
            {ManualDiscount => $ManualUnitDiscount},
        ]
    );
    $t->set_discount;

    $pim->{after} = $dbh->selectrow_hashref(
        "select * from PreInventoryMov where DocumentID = $t->{DocumentID}"
    );
    # Remove trailing zeroes:
    $pim->{after}{Discount} += 0;
    is($pim->{after}{Discount}, $ExpectedDiscount,
        "Manual discount amount is \$$ExpectedDiscount as expected.");

    is($pim->{after}{UnitDiscount} + 0, 2.50, "Expected UnitDiscount value.");
}

{
    my $t = setup_typical_test();
    pass "Going to test simple global 10% off discount.";
    $t->{IDDiscount} = $t->exec_sp(
        sp_name => 'sp_Discounts_Upsert',
        identity_col => 'IDDiscount',
        RewardAmount => 0.90,
    );
    $t->test_view_parts();
    $t->test_restriction_views(expected_to_fail => 'none');
}

pass "Ent_CustomerDiscount tests:";
{
    my $t = setup_typical_test();
    #pass("Discount typical data: " . Dumper($t));

    # 6% is the highest discount that's done in that table, we'll go 5%:
    my $test_percent = 5;
    my $pim;

    pass("Test $test_percent\% customer discount (no other discount)");
    generic_insert($dbh, 'Ent_CustomerDiscount', {
        IDTipoPessoa => $t->{IDTipoPessoa_Customers},
        IDGroup => $t->{IDGroup},
        Discount => $test_percent,
    });

    pass("Going to confirm that sp_PreSale_SetDiscount after a Ent_CustomerDiscount updates PreInventoryMov");
    $pim->{before} = $dbh->selectrow_hashref(
        "select * from PreInventoryMov where DocumentID = $t->{DocumentID}"
    );

    $t->set_discount;

    $pim->{after} = $dbh->selectrow_hashref(
        "select * from PreInventoryMov where DocumentID = $t->{DocumentID}"
    );
    ok($pim->{after}{UnitDiscount}, 'Got UnitDiscount.');
    ok($pim->{after}{UnitDiscount} > ($pim->{before}{UnitDiscount} || 0),
        "UnitDiscount after ($pim->{after}{UnitDiscount}) > before "
        . ". Should be $test_percent\%"
    );
    is($pim->{after}{UnitDiscount} + 0, $test_percent, "Discount is the expected $test_percent\%");

    my $expected_Discount = $pim->{after}{Qty} * $pim->{after}{UnitDiscount};

    is($pim->{after}{Discount} + 0, $expected_Discount + 0, "Discount is expected value (qty * UnitDiscount).");

    pass("Going to confirm that deleting row from Ent_CustomerDiscount is reflected.");
    $pim->{before} = $dbh->selectrow_hashref(
        "select * from vw_SelectFinalDiscounts where DocumentID = $t->{DocumentID}"
    );
    ok($pim->{before}{UnitDiscount}, "Has discount before deletion.");
    $dbh->do(
        q{
            delete from Ent_CustomerDiscount
            where IDTipoPessoa = ? and IDGroup = ? and Discount = ?
        },
        {},
        $t->{IDTipoPessoa_Customers}, $t->{IDGroup}, $test_percent
    );
    $pim->{after} = $dbh->selectrow_hashref(
        "select * from vw_SelectFinalDiscounts where DocumentID = $t->{DocumentID}"
    );
    #ok(keys $pim->{after}, "Got some results from vw_SelectFinalDiscounts");
    is($pim->{after}{UnitDiscount}, undef, "Discount amount is zero as expected after discount deleted.");
    #ok($pim->{after}{UnitDiscount} < $pim->{before}{UnitDiscount},
    #    "Discount after ($pim->{after}{UnitDiscount}) < before "
    #    . "($pim->{before}{UnitDiscount}). Should be $test_percent\%"
    #);

}

{
    my $t = setup_typical_test();

    #my $test_results = $dbh->selectall_arrayref(
    #    $test_sql, {Slice => {}}
    #);
    #Dumper($test_results);

    # TODO: Set sequence counters to a certain level to give the test data
    # uniformity and distance from real data.

    # Can't say I'm impressed with the *four* levels of duplication
    # required by Microsoft just to get output values from an SP.
    # (Once in the SP itself, once to declare a var, once to call SP
    # with the declared var, and the fourth and final time to select it.
    # Zero duplication in Postgres. :/
    ($t->{IDDiscount}) = $dbh->selectrow_array(q{
        declare @NewIDDiscount int;
        exec sp_Discounts_Upsert
            @IDDiscount = @NewIDDiscount OUTPUT,
            @DiscountName = '10% off test discount.',
            @StartOn = '2013-01-01 01:01:01',
            @EndOn = '2038-01-18 03:14:07',
            @BeginTimeOfDay = null,
            @EndTimeOfDay = null,
            @DiscType = 'promo',
            @MinSubtotal = null,
            @IDStore = null,
            @MaxUsesPerCustomer = null,
            @MaxUsesInTotal = null,
            @FirstTimeCustomerOnly = 0,
            @CustomerCardRequired = 0,
            @IsStackable = 0,
            @RewardAmount = 0.85, -- 15%
            @AmountType = 'Percent Off Item',
            @RewardQuantity = null,
            @MinQuantity = null,
            @MinDollarAmount = null;
        select @NewIDDiscount;
    });
    ok($t->{IDDiscount}, "Got IDDiscount '$t->{IDDiscount}' back from sp_Discounts_Upsert");

    $t->test_restriction_views(expected_to_fail => 'none');

    $t->{IDTag} = $dbh->selectrow_array(q{
        declare @NewIDTag int;
        exec sp_Tag_Upsert
            @IDTag = @NewIDTag Output,
            @TagName = 'Test Tag XYZ';
        select @NewIDTag;
    });
    ok($t->{IDTag}, "Got IDTag '$t->{IDTag}' back from sp_Tag_Upsert");

    pass "Going to call sp_DiscQualifyingTags_Upsert";
    $dbh->do(
        q{
        exec sp_DiscQualifyingTags_Upsert
            @IDDiscount = ?,
            @IDTag = ?;
        },
        {}, $t->{IDDiscount}, $t->{IDTag}
    );
    pass "Done";

    if (0) {
        print Dumper(
            $dbh->selectall_arrayref(
                "select * from DiscQualifyingTags where IDDiscount = ?",
                {Slice => {}},
                $t->{IDDiscount}
            )
        );
    }

    if (0) {
        my $results = $dbh->selectall_arrayref(
            q{select * from vw_PreInventoryMovWithDiscounts where DocumentID = ?},
            {Slice => {}}, $t->{DocumentID}
        );
        ok(@$results >= 1, "Got a row from vw_PreInventoryMovWithDiscounts");
        if (0) {
            pass "vw_PreInventoryMovWithDiscounts for $t->{DocumentID}:\n" . Dumper($results);
        }
    }

    pass "Check results from vw_SelectFinalDiscounts";
    {
        my $rows = $dbh->selectall_arrayref(
            "select * from vw_SelectFinalDiscounts where DocumentID = ?",
            {Slice => {}},
            $t->{DocumentID}
        );
        #print Dumper($rows);
        ok(@$rows >= 1, "Got at least one row from vw_SelectFinalDiscounts");
        my $disc_amt = $rows->[0]{UnitDiscount};
        isnt($disc_amt, undef, "Discount was defined.");
        is($rows->[0]{UnitDiscount}, '15.0000', "Got the expected discount amount.");
    }
}

{
    my $t = setup_typical_test();

    # example values:""
    #1 188530,1,49935,1,1,2,1,7.9900,2.6300,1.2300,'2014-09-12 17:50:00',0,1,'2014-09-12 18:06:30',NULL,NULL,0,0,0,0,0,'',0,NULL,NULL,0.0000,1.2300,386788,1.23,NULL,NULL
    #NULL,NULL,0,0,0,0,0,'',0,NULL,NULL,0.0000,1.2300,386788,1.23,NULL,NULL
    my $add_item_sql = qq{
        exec sp_PreSale_AddItem
            \@PreSaleID           = $t->{DocumentID},
            \@IDCliente           = $t->{IDCliente},
            \@ModelID             = $t->{IDModel},
            \@StoreID             = $t->{IDStore},
            \@UserID              = $t->{IDUser},
            \@IDComission         = null,
            \@Qty                 = 2,
            \@SalePrice           = 1.99,
            \@CostPrice           = 1.49,
            \@Discount            = null,
            \@MovDate             = '2014-01-01 12:00:00',
            \@ResetDiscount       = 0,
            \@Manager             = 0,
            \@Date                = '2014-01-01 12:00:00',
            \@IDPreInvMovExchange = null,
            \@PreInvMovParentID   = null,
            \@IDDepartment        = 0,
            \@Promo               = 0,
            \@IDDescriptionPrice  = 0,
            \@IDVendorPrice       = 0,
            \@SuggPrice           = 0,
            \@DocumentNumber      = '',
            \@IDDocumentType      = null,
            \@SequencyNum         = 0,
            \@TotParcial          = '',
            \@DiscountPromo       = 0,
            \@UnitDiscount        = null,
            \@PreInventMovID      = $t->{IDPreInventoryMov},
            \@ManualDiscount      = null,
            \@IDSpecialPrice      = null,
            \@ManualPrice         = null;
    };
    my ($pim_qty_before) = $dbh->selectrow_array(
        "select Qty from PreInventoryMov where DocumentID = ?",
        {}, $t->{DocumentID}
    );

    #say "Going to execute the following AddItem (once): $add_item_sql";
    #local $dbh->{TraceLevel} = 4;

    #local $dbh->{PrintError} = 1;
    pass 'Going to test sp_PreSale_AddItem';
    $dbh->do($add_item_sql);
    #say "error = " . $dbh->errstr;
    #$dbh->do($add_item_sql);
    my ($pim_qty_after) = $dbh->selectrow_array(
        "select Qty from PreInventoryMov where DocumentID = ?",
        {}, $t->{DocumentID}
    );
    #pass("Skipping pim check for now (need to isolate in its own transaction)");
    is($pim_qty_after + 0, 2 + 0, "pim_qty_after ($pim_qty_after) is two (pim_qty_before = $pim_qty_before)");
}

pass "Going to ensure that SetDiscount and AddItem both work:";
for my $method (qw(SetDiscount AddItem)) {
    pass "Going to test using method $method";
    my $t = setup_typical_test(method => $method);

    $t->exec_sp(
        sp_name => 'sp_Discounts_Upsert',
        identity_col => 'IDDiscount',
        RewardAmount => 0.85,
    );

    if ($method eq 'AddItem') {
        pass "Calling AddItem";
        $t->exec_sp(
            sp_name => 'sp_PreSale_AddItem',
            SalePrice => 2.99,
        );
    }
    else {
        pass "Calling SetDiscount";
        $t->exec_sp(
            sp_name => 'sp_PreSale_SetDiscount',
            DocumentID => $t->{DocumentID},
        );
    }

    $t->has_discount();
}


{
    my $t = setup_typical_test();
    my $IDDiscount = $t->exec_sp(
        sp_name => 'sp_Discounts_Upsert',
        identity_col => 'IDDiscount',
        RewardAmount => 0.85,
    );
    ok($IDDiscount, "Got IDDsicount $IDDiscount. Going to test performance:");

    my $dbh = $t->dbh;
    #timethis(10, sub {
    #    $dbh->selectall_arrayref(
    #        "select * from vw_SelectFinalDiscounts where DocumentID = ?",
    #        {Slice => {}}, $t->{DocumentID},
    #    );
    #});
    #$dbh->commit();
}


pass "Test with no restrictions:";
{
    my $t = setup_typical_test();
    $t->add_typical_discount();
    $t->test_a(expected_to_fail => 'none');
}

pass "Test StartOn/EndOn that does not contain the current date:";
{
    my $t = setup_typical_test();
    $t->add_typical_discount(
        StartOn => '2013-01-01 01:01:01',
        EndOn => '2013-02-02 02:02:02',
    );
    $t->test_a(expected_to_fail => 'vw_DiscTimeRestrictions');
}


pass "Test StartOn/EndOn that contains the current date:";
{
    my $t = setup_typical_test();
    $t->add_typical_discount(
        StartOn => '2013-01-01 01:01:01',
        EndOn => '2029-02-02 02:02:02',
    );
    $t->test_a(expected_to_fail => 'none');
}

pass "Test BeginTimeOfDay/EndTimeOfDay that should fail:";
{
    my $t = setup_typical_test();
    $t->add_typical_discount(
        BeginTimeOfDay => '01:01:01',
        EndTimeOfDay => '01:01:02',
    );
    $t->test_a(expected_to_fail => 'vw_DiscTimeRestrictions');
}

pass "Test BeginTimeOfDay/EndTimeOfDay that should pass:";
{
    my $t = setup_typical_test();
    $t->add_typical_discount(
        BeginTimeOfDay => '00:00:01',
        EndTimeOfDay => '23:59:59',
    );
    $t->test_a(expected_to_fail => 'none');
}

pass "Test DiscValidOnDays:";
{
    my $t = setup_typical_test();
    $t->add_typical_discount();

    my $tomorrow_dow = DateTime->today->add(days => 1)->day_of_week_0;
    ok($tomorrow_dow, "tomorrow's day of week: $tomorrow_dow");
    generic_insert($t->dbh, 'DiscValidOnDays', [
        {IDDiscount => $t->{IDDiscount}},
        {DayOfWeek => $tomorrow_dow},
    ]);
    $t->test_a(expected_to_fail => 'vw_DiscDayRestrictions');
}

pass "Test MinSubtotal:";
SKIP: {
    skip "MinSubtotal not currently working";

    my $t = setup_typical_test();
    $t->add_typical_discount(
        MinSubtotal => 9999.99
    );
    $t->test_a(expected_to_fail => 'vw_DiscSubTotalRestriction');
}

pass "Test DiscStores:";
{
    my $t = setup_typical_test();
    $t->add_typical_discount();
    my $IDStore_that_does_not_match = 999999;
    generic_insert($t->dbh, 'DiscStores', [
        {IDDiscount => $t->{IDDiscount}},
        {IDStore => $t->{IDStore}},
        {IsInclude => 0},
    ]);
    $t->test_a(expected_to_fail => 'vw_ValidDiscStores');
}

pass "Test vw_ValidMinQuantityDiscounts:";
SKIP: {
    skip "Need to build infrastructure for populating related tables first.";

    my $t = setup_typical_test();
    $t->add_typical_discount();
    $t->test_a(expected_to_fail => 'vw_ValidMinQuantityDiscounts');
}

pass "Test vw_ValidCustGroupsDiscounts with a different TipoPessoa:";
{
    my $t = setup_typical_test();
    $t->add_typical_discount();

    ok($t->{IDTipoPessoa_Customers}, "IDTipoPessoa_Customers: $t->{IDTipoPessoa_Customers}");
    # This assumes that there is at least one other tipopessoa. It would be
    # better to create our own.
    my ($any_other_cust_group) = $t->dbh->selectrow_array(qq{
        select max(IDTipoPessoa)
        from TipoPessoa
        where IDTipoPessoa <> $t->{IDTipoPessoa_Customers}
    });

    ok(defined $any_other_cust_group, "Got an alternate (non-customer) TipoPessoa ($any_other_cust_group)");
    generic_insert($t->dbh, 'DiscAllowedCustGroups', [
        {IDDiscount => $t->{IDDiscount}},
        {IDTipoPessoa => $any_other_cust_group},
    ]);

    $t->test_a(expected_to_fail => 'vw_ValidCustGroupsDiscounts');
}

pass "Test vw_ValidCustGroupsDiscounts with the same TipoPessoa:";
{
    my $t = setup_typical_test();
    $t->add_typical_discount();
    generic_insert($t->dbh, 'DiscAllowedCustGroups', [
        {IDDiscount => $t->{IDDiscount}},
        {IDTipoPessoa => $t->{IDTipoPessoa}},
    ]);
    $t->test_a(expected_to_fail => 'none');
}


pass "Test numer of uses equal to MaxUsesPerCustomer";
{
    my $all_test_conditions = [
        {
            InsertDiscUses => 1,
            discount_opt => {MaxUsesPerCustomer => 1},
            expect => {expected_to_fail => 'vw_ValidCustRestrDiscounts'},
        },
        {
            InsertDiscUses => 2,
            discount_opt => {MaxUsesPerCustomer => 1},
            expect => {expected_to_fail => 'vw_ValidCustRestrDiscounts'},
        },
        {
            broken => 1,
            InsertDiscUses => 1,
            discount_opt => {MaxUsesPerCustomer => 2},
            expect => {expected_to_fail => 'none'},
        },
    ];

    for my $test_conditions (@$all_test_conditions) {
        my $t = setup_typical_test();
        $t->test_with_conditions($test_conditions);
    }
}

pass "Test MaxUsesInTotal";
{

    my $all_test_conditions = [
        {
            InsertDiscUses => 1,
            discount_opt => {MaxUsesInTotal => 1},
            expect => {expected_to_fail => 'vw_ValidCustRestrDiscounts'},
        },
        {
            InsertDiscUses => 2,
            discount_opt => {MaxUsesInTotal => 1},
            expect => {expected_to_fail => 'vw_ValidCustRestrDiscounts'},
        },
        {
            broken => 1,
            InsertDiscUses => 1,
            discount_opt => {MaxUsesInTotal => 2},
            expect => {expected_to_fail => 'none'},
        },
    ];

    for my $test_conditions (@$all_test_conditions) {
        my $t = setup_typical_test();
        $t->test_with_conditions($test_conditions);
    }
}


pass "Test CustomerCardRequired and does not have card";
{
    my $t = setup_typical_test();
    $t->add_typical_discount(CustomerCardRequired => 1);
    $t->test_a(expected_to_fail => 'vw_ValidCustRestrDiscounts');
}

pass "Test CustomerCardRequired and does have card";
{
    my $t = setup_typical_test();
    $t->add_typical_discount(CustomerCardRequired => 1);
    $t->dbh->do(
        "update Pessoa set CustomerCard = 'test123' where IDPessoa = ?",
        {}, $t->{IDPessoa}
    );
    $t->test_a(expected_to_fail => 'none');
}

pass "Test FirstTimeCustomerOnly after deleting all InventoryMov rows";
SKIP: {
    skip "Need to build testing infrastructure first.";
    my $t = setup_typical_test();

    $t->dbh->do(
        "delete from InventoryMov where IDPessoa = ?",
        {}, $t->{IDPessoa}
    );
    $t->add_typical_discount(FirstTimeCustomerOnly => 1);
    $t->test_a(expected_to_fail => 'none');
}

pass "Test FirstTimeCustomerOnly after confirming they have some InventoryMov rows";
SKIP: {
    skip "Need to build testing infrastructure first.";
    my $t = setup_typical_test();
    $t->add_typical_discount(FirstTimeCustomerOnly => 1);
    $t->test_a(expected_to_fail => 'vw_ValidFirstTimeRestrictionDiscounts');
}

if ($ENV{RUN_BENCHMARK_TESTS}) {
    pass "Run benchmark tests:";
}
else {
    pass "Skipping benchmark tests.";
    goto after_benchmark_tests;
}

pass "Going to test performance.";
{
    $dbh->do(q{
        create table test (
            test_id int
        );
    });

    $dbh->do(q{
        insert into test (test_id) values
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
    (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);
    });

    my $t0 = Benchmark->new;
    my $results = $dbh->selectall_arrayref(
        "select * from test", {Slice => {}}
    );
    my $t1 = Benchmark->new;
    my $td = timediff($t1, $t0);
    my $baseline_ms = $td->[0] * 1000;
    pass "Baseline performance (milliseconds): " . $baseline_ms;
}

our @Times = ();

{
    my $t = setup_typical_test();
    $t->add_typical_discount();
    my $before = Benchmark->new;
    $t->set_discount;
    my $after = Benchmark->new;
    my $time_ms = benchmark_in_ms($after, $before);
    pass "Time: $time_ms ms";
    push @Times, {name => 'sp_PreSale_SetDiscount', time_ms => $time_ms};
}


sub setup_typical_test_and_discount {
    my $t = setup_typical_test();
    $t->add_typical_discount();
    return $t;
}

pass 'Many simple timings.';
{
    my @simple_timings = (
        'vw_All_Discounts',
        'vw_Potential_Discounts',
        'vw_CalcCustomerDiscounts',
        'vw_CalcStandardDiscounts',
        'vw_SelectFinalDiscounts',
    );

    # These are the restriction views:
    push @simple_timings, qw(
        vw_DiscTimeRestrictions
        vw_DiscDayRestrictions
        vw_DiscSubTotalRestriction
        vw_ValidDiscStores
        vw_ValidMinQuantityDiscounts
        vw_ValidCustGroupsDiscounts
        vw_ValidCustRestrDiscounts
        vw_ValidFirstTimeRestrictionDiscounts
    );
    for my $simple_timing (@simple_timings) {
        custom_timer(
            name => $simple_timing,
            sql => qq{
                select * from $simple_timing where DocumentID = ?
            }
        );
    }
}

pass 'vw_Potential_Discounts with various join timings';
{
    my @parts = (
        'select AD.* from vw_All_Discounts AD',
        'join vw_DiscTimeRestrictions DTR on (DTR.IDPreInventoryMov = AD.IDPreInventoryMov and DTR.IDDiscount = AD.IDDiscount)',
        'join vw_DiscDayRestrictions DDR on (DDR.IDPreInventoryMov = DTR.IDPreInventoryMov and DDR.IDDiscount = DTR.IDDiscount)',
        'join vw_DiscSubTotalRestriction DST on (DST.IDPreInventoryMov = DDR.IDPreInventoryMov and DST.IDDiscount = DDR.IDDiscount)',
        'join vw_ValidDiscStores VDS on (VDS.IDPreInventoryMov = DST.IDPreInventoryMov and VDS.IDDiscount = DST.IDDiscount)',
        'join vw_ValidMinQuantityDiscounts VMQ on (VMQ.IDPreInventoryMov = VDS.IDPreInventoryMov and VMQ.IDDiscount = VDS.IDDiscount)',
        'join vw_ValidCustGroupsDiscounts VCG on (VCG.IDPreInventoryMov = VMQ.IDPreInventoryMov and VCG.IDDiscount = VMQ.IDDiscount)',
        'join vw_ValidCustRestrDiscounts VCR on (VCR.IDPreInventoryMov = VCG.IDPreInventoryMov and VCR.IDDiscount = VCG.IDDiscount)',
        'join vw_ValidFirstTimeRestrictionDiscounts FTR on (FTR.IDPreInventoryMov = VCR.IDPreInventoryMov and FTR.IDDiscount = VCR.IDDiscount)',
    );

    # Test it two ways:
    # 1. With just vw_All_Discounts and one join individually (requires different join clause).
    # 2. With all preceeding joins

    for my $num_parts_to_use (1 .. @parts) {
        my $num_joins = $num_parts_to_use - 1;
        my @used_parts = @parts[0 .. $num_joins];
        my $sql = join("\n", @used_parts) . " where AD.DocumentID = ?";
        pass "Going to use these parts: $sql";
        custom_timer(
            name => "vw_Potential_Discounts with $num_joins joins",
            sql => $sql,
        );
    }

}



{

    custom_timer(
        name => 'vw_SelectFinalDiscounts.PotentialDiscounts CTE',
        sql => q{
            with PotentialDiscounts as (
                select * from vw_CalcCustomerDiscounts
                union all
                select * from vw_CalcStandardDiscounts
            )
            select * from PotentialDiscounts where DocumentID = ?
        }
    );

    custom_timer(
        name => 'vw_SelectFinalDiscounts.GreatestNonStackableDiscounts CTE',
        sql => q{
            with PotentialDiscounts as (
                select * from vw_CalcCustomerDiscounts
                union all
                select * from vw_CalcStandardDiscounts
            ),
            GreatestNonStackableDiscounts as (
                select DocumentID, IDPreInventoryMov,
                    max(DiscountAmount) as DiscountAmount
                from PotentialDiscounts
                where IsStackable = 0
                group by DocumentID, IDPreInventoryMov
            )
            select * from GreatestNonStackableDiscounts where DocumentID = ?
        }
    );

    custom_timer(
        name => 'vw_SelectFinalDiscounts.BothDiscounts CTE',
        sql => q{
            with PotentialDiscounts as (
                select * from vw_CalcCustomerDiscounts
                union all
                select * from vw_CalcStandardDiscounts
            ),
            GreatestNonStackableDiscounts as (
                select DocumentID, IDPreInventoryMov,
                    max(DiscountAmount) as DiscountAmount
                from PotentialDiscounts
                where IsStackable = 0
                group by DocumentID, IDPreInventoryMov
            ),
            BothDiscounts as (
                select DocumentID, IDPreInventoryMov, DiscountAmount
                from GreatestNonStackableDiscounts
                union all
                select DocumentID, IDPreInventoryMov, DiscountAmount
                from PotentialDiscounts
                where IsStackable = 1
            )
            select * from BothDiscounts where DocumentID = ?
        }
    );

    custom_timer(
        name => 'vw_SelectFinalDiscounts.SummedDiscounts CTE',
        sql => q{
            with PotentialDiscounts as (
                select * from vw_CalcCustomerDiscounts
                union all
                select * from vw_CalcStandardDiscounts
            ),
            GreatestNonStackableDiscounts as (
                select DocumentID, IDPreInventoryMov,
                    max(DiscountAmount) as DiscountAmount
                from PotentialDiscounts
                where IsStackable = 0
                group by DocumentID, IDPreInventoryMov
            ),
            BothDiscounts as (
                select DocumentID, IDPreInventoryMov, DiscountAmount
                from GreatestNonStackableDiscounts
                union all
                select DocumentID, IDPreInventoryMov, DiscountAmount
                from PotentialDiscounts
                where IsStackable = 1
            ),
            SummedDiscounts as (
                select DocumentID, IDPreInventoryMov, sum(DiscountAmount) as UnitDiscount
                from BothDiscounts
                group by DocumentID, IDPreInventoryMov
            )
            select * from SummedDiscounts where DocumentID = ?
        }
    );

    custom_timer(
        name => 'vw_SelectFinalDiscounts.FinalDiscounts CTE',
        sql => q{
            with PotentialDiscounts as (
                select * from vw_CalcCustomerDiscounts
                union all
                select * from vw_CalcStandardDiscounts
            ),
            GreatestNonStackableDiscounts as (
                select DocumentID, IDPreInventoryMov, Qty,
                    max(DiscountAmount) as DiscountAmount
                from PotentialDiscounts
                where IsStackable = 0
                group by DocumentID, IDPreInventoryMov, Qty
            ),
            BothDiscounts as (
                select DocumentID, IDPreInventoryMov, Qty, DiscountAmount
                from GreatestNonStackableDiscounts
                union all
                select DocumentID, IDPreInventoryMov, Qty, DiscountAmount
                from PotentialDiscounts
                where IsStackable = 1
            ),
            SummedDiscounts as (
                select DocumentID, IDPreInventoryMov, Qty, sum(DiscountAmount) as UnitDiscount
                from BothDiscounts
                group by DocumentID, IDPreInventoryMov, Qty
            ),
            ZeroedDiscounts as (
                select DM.DocumentID, DM.IDPreInventoryMov, DM.Qty,
                    coalesce(DM.UnitDiscount, 0) as UnitDiscount,
                    coalesce(DM.UnitDiscount * DM.Qty, 0) as Discount
                from SummedDiscounts DM
            ),
            FinalDiscounts as (
                select DocumentID, IDPreInventoryMov, Qty,
                    cast(round(UnitDiscount, 4) as money) as UnitDiscount,
                    cast(round(Discount, 4) as money) as Discount
                from ZeroedDiscounts
            )
            select * from FinalDiscounts where DocumentID = ?;
        }
    );


    custom_timer(
        name => 'vw_SelectFinalDiscounts (again)',
        sql => q{
            select * from vw_SelectFinalDiscounts where DocumentID = ?
        }
    );
}

sub benchmark_in_ms {
    my ($after, $before) = @_;

    my $ms = sprintf("%.0f", timediff($after, $before)->[0] * 1000);

    return $ms;
}

sub custom_timer {
    my (%opt) = @_;

    my $sql = $opt{sql} || croak "sql required";
    my $name = $opt{name} || "un-named benchmark";

    my $count = 5;
    my @these_times;
    for my $c (1 .. $count) {
        #my $t = $opt{t};
        my $t = setup_typical_test_and_discount();
        my $before = Benchmark->new;
        # Note that all queries will need DocumentID:
        my $results = $t->dbh->selectall_arrayref(
            $sql, {Slice => {}}, $t->{DocumentID}
        );
        my $after = Benchmark->new;
        my $time_ms = benchmark_in_ms($after, $before);
        push @these_times, $time_ms;
        pass "$time_ms ms:\t$name";
    }
    use List::Util qw(sum);
    my $avg_time = sprintf("%.1f", sum(@these_times) / $count);
    push @Times, {name => $name, time_ms => $avg_time};

    return;
}

#print Dumper(@Times);

say "Time (ms)\tDescription";
for my $time (@Times) {
    say "$time->{time_ms} ms\t$time->{name}";
}

after_benchmark_tests:

{
    my $t = setup_typical_test();
    generic_insert($t->dbh, 'ManualPrice', [
        {IDPreInventoryMov => $t->{IDPreInventoryMov}},
        {ManualPrice => 44.44},
    ]);
    #pass Dumper $t->dbh->selectall_arrayref("select * from ManualPrice");

    $t->set_discount;
    my ($SalePrice) = $t->dbh->selectrow_array(
        "select SalePrice from PreInventoryMov where IDPreInventoryMov = ?",
        {}, $t->{IDPreInventoryMov}
    );

    if ($::SET_DISCOUNT_METHOD eq 'sp_PreSale_SetDiscount') {
        pass "Skipping SalePrice test because it doesn't work with sp_PreSale_SetDiscount";
    }
    else {
        is($SalePrice + 0, 44.44, "Got correct SalePrice");
    }
}

#
{
    pass "Try setting ManualDiscount through the additem routine:";
    my $t = setup_typical_test();
    my $expected = "33.3300";
    $t->sp_PreSale_AddItem(ManualDiscount => $expected);
    my ($ManualDiscount) = $t->dbh->selectrow_array(qq{
        select ManualDiscount
        from ManualDiscount
        where IDPreInventoryMov = $t->{IDPreInventoryMov}
    });
    is($ManualDiscount, $expected,
        "sp_PreSale_AddItem did insert row in  ManualDiscount table");
    $t->set_discount;
    my ($UnitDiscount) = $t->dbh->selectrow_array(qq{
        select UnitDiscount
        from PreInventoryMov
        where IDPreInventoryMov = $t->{IDPreInventoryMov}
    });
    is($UnitDiscount, $expected, "UnitDiscount correctly set to $expected");


}


if (0) {
    pass "Going to test a specific situation that Nick was testing.";

    $dbh->rollback;
    $dbh->begin_work;

    my $t = DiscountTests->new(dbh => $dbh);

    #my $t = setup_typical_test();

    # This test only has one item in the row.
    my $new = {
        IDCliente => 1,
        IDDiscount => 1,
        IDPreInventoryMov => 59010,
        PreInventoryMovID => 59010,
        DocumentID => 33881,
        PreSaleID => 33881,
        ModelID => 530,
        IDModel => 530,
        StoreID => 1,
        IDStore => 1,
        SalePrice => 8.4900,
        SellingPrice => 8.4900,
        ExpectedUnitDiscount => '4.2450',
        IDTag => 2,

    };
    while (my ($k, $v) = each %$new) {
        $t->{$k} = $v;
    }
    #print Dumper($t);

    # There can be only one! (Testing for multiple interacting discounts
    # is later.)
    #$dbh->do("delete from Discounts where IDDiscount <> $t->{IDDiscount}");

    #my $discount = $dbh->selectall_arrayref(
    #    "select * from Discounts where IDDiscount = $t->{IDDiscount}",
    #    {Slice => {}}
    #);
    #pass Dumper($discount);


    my $pim_row = $dbh->selectrow_hashref("select * from PreInventoryMov where IDPreInventoryMov = $t->{IDPreInventoryMov}");

    while (my ($k, $v) = each %$pim_row) {
        $t->{$k} = $v;
    }

    my $sql = qq{
        select DocumentID, IDPreInventoryMov, ModelID, Qty, SalePrice,
            UnitDiscount
        from PreInventoryMov
        where IDPreInventoryMov = $t->{IDPreInventoryMov}
    };

    my $before = $dbh->selectrow_hashref($sql);
    is($before->{UnitDiscount}, '.0000', "Discount is zero before");

    # This was somehow missed for this particular database:
    #add_recalc_param($dbh);

    #$::SET_DISCOUNT_METHOD = 'sp_PreSale_AddItem';
    #$t->set_discount;
    $dbh->do("exec sp_PreSale_AddItem;1 33881,1,530,1,1,704,1,0.0000,0.0000,0.0000,'2015-01-16 18:33:00',0,0,'2015-01-16 18:33:15',NULL,NULL,0,0,0,0,0,'',0,NULL,NULL,0.0000,0.0000,59010,NULL,NULL,NULL");

    #print Dumper($dbh->selectrow_hashref("select * from PreInventoryMov where IDPreInventoryMov = $t->{IDPreInventoryMov}"));
    my $after = $dbh->selectrow_hashref($sql);
    is($after->{UnitDiscount}, $t->{ExpectedUnitDiscount},
        "UnitDiscount is the exepcted amount of $t->{ExpectedUnitDiscount}.");

    #$t->test_view_parts();
    #$t->test_restriction_views(expected_to_fail => 'none');

    #print Dumper($dbh->selectall_arrayref("select * from PreInventoryMov where DocumentID = $nick->{DocumentID};"));
    #print Dumper($dbh->selectall_arrayref("select * from TagModel where IDModel = 530;", {Slice => {}}));
    #print Dumper($dbh->selectall_arrayref("select * from Tag where IDTag = 2;", {Slice => {}}));

    #$dbh->do("exec sp_PreSale_AddItem;1 33881,1,530,1,1,704,1,0.0000,0.0000,0.0000,'2015-01-16 18:33:00',0,0,'2015-01-16 18:33:15',NULL,NULL,0,0,0,0,0,'',0,NULL,NULL,0.0000,0.0000,59010,NULL,NULL,NULL");


}

pass "*** Begin a series of coupon-related tests ***";
{
    # Applied coupons do not result in the correct dollar amount.
    my $t = setup_typical_test();

    $t->{CouponCode} = 'ABC123';
    $t->add_typical_discount(
        DiscType => 'Coupon'
    );
    generic_insert($t->dbh, 'DiscCoupons', [
        {IDDiscount => $t->{IDDiscount}},
        {Code => $t->{CouponCode}},
    ]);

    pass "Test that there is no discount until Coupon is added:";
    $t->set_discount;
    $t->has_no_discount;

    $t->exec_sp(
        sp_name => 'sp_PreSale_Coupon_Upsert',
        return_results => 0,
        DocumentID => $t->{DocumentID},
        CouponCode => $t->{CouponCode},
    );
    $t->set_discount;
    $t->has_discount(UnitDiscount => 15);

    #pass Dumper($dbh->selectall_arrayref("select * from Discounts"));
    #pass Dumper($dbh->selectall_arrayref("select * from DiscCoupons"));
    #pass Dumper($dbh->selectall_arrayref("select * from Sal_Coupon"));


}
#say "exit early" && exit;

{
    pass "Test that new discount with coupon type has no discount";
    #add_recalc_param($dbh);
    #$::SET_DISCOUNT_METHOD = 'sp_PreSale_AddItem';

    #say Dumper($dbh->selectall_arrayref("select * from Discounts"));
    my $t = setup_typical_test();

    $t->{CouponCode} = 'ABC123';
    pass "Setup coupon discount";
    $t->add_typical_discount(
        DiscType => 'Coupon'
    );
    $t->has_no_discount;
}

{
    pass "Test that new discount with coupon type and DiscCoupons row has no discount";
    my $t = setup_typical_test();

    $t->{CouponCode} = 'ABC123';
    pass "Setup coupon discount";
    $t->add_typical_discount(
        DiscType => 'Coupon'
    );
    generic_insert($t->dbh, 'DiscCoupons', [
        {IDDiscount => $t->{IDDiscount}},
        {Code => $t->{CouponCode}},
    ]);

    $t->set_discount;
    $t->has_no_discount;
}

{
    pass "Test that coupon discount with all values works normally.";

    my $t = setup_typical_test();

    $t->{CouponCode} = 'ABC123';
    $t->add_typical_discount(
        DiscType => 'Coupon'
    );
    generic_insert($t->dbh, 'DiscCoupons', [
        {IDDiscount => $t->{IDDiscount}},
        {Code => $t->{CouponCode}},
    ]);
    $t->exec_sp(
        sp_name => 'sp_PreSale_Coupon_Upsert',
        return_results => 0,
        DocumentID => $t->{DocumentID},
        CouponCode => $t->{CouponCode},
    );
    $t->test_b;
    $t->has_discount(UnitDiscount => 15);
    $t->test_view_parts();
    $t->test_restriction_views(expected_to_fail => 'none');
}

pass "TODO: Test if you can add multiple coupons to one sale (and have them both take effect.)";

current_test:

pass "*** Begin a series of TagQtyPriceBreak-related tests ***";
{
    my $t = setup_typical_test();

    ($t->{IDTag}) = $dbh->selectrow_array(q{
        declare @NewIDTag int;
        exec sp_Tag_Upsert
            @IDTag = @NewIDTag Output,
            @TagName = 'Test Tag ABC';
        select @NewIDTag;
    });
    ok($t->{IDTag}, "Got IDTag '$t->{IDTag}' back from sp_Tag_Upsert");

    generic_insert($t->dbh, 'TagModel', [
        {IDTag => $t->{IDTag}},
        {IDModel => $t->{IDModel}},
    ]);

    my $price_before = $t->sp_PreSale_CalcPrice;
    ok($price_before, "Got price before ($price_before) adding PriceBreak");

    generic_insert($t->dbh, 'TagQtyPriceBreak', [
        {IDTag => $t->{IDTag}},
        {MinQuantity => 3},
        {Discount => 0.2},
    ]);

    my ($qty) = $t->dbh->selectrow_array(
        "select Qty from PreInventoryMov where IDPreInventoryMov = ?",
        {}, $t->{IDPreInventoryMov}
    );

    pass "qty = $qty";

    my $price_after = $t->sp_PreSale_CalcPrice(print_sql => 0);
    ok($price_after, "Got price after ($price_after) adding PriceBreak");
    ok($price_after < $price_before, "price after ($price_after) is less than price before ($price_before).");

    $t->{SpecialPriceID} = 'null';
    $t->{ManualPrice} = 'null';

    #my $results = $t->dbh->selectall_arrayref($full_sql);
    #ok($results, "Got results: " . Dumper($results));
}

# TODO: Test Qty Price Breaks with multiple line items, overlapping and non-overlapping tags, etc. (E.g. it doesn't add after first tiem, but a second item added that makes it go over quantity then allwos discount.)

# Idea for testing tags/price breaks:
# PIM row 1 has no tag.
# 2 has 1st tag
# 3 4 associate with 2nd tag
# 4 5 has 3rd tag
# (i.e. 4 has two tags)

{
    my $t = setup_typical_test();
    my $price_before = $t->sp_PreSale_CalcPrice;
    ok($price_before, "Got price before ($price_before) adding PriceBreak");
    #$t->

    my $pim_rows = [
        {
            IDModel => ($t->{ModelID} + 1),
            Model => "Test Model " . ($t->{ModelID} + 1),
            IDPreInventoryMov => ($t->{IDPreInventoryMov} + 1),
        },
    ];

    for my $pim_row (@$pim_rows) {
        $t->insert_Model(%$pim_row);
        $t->insert_PreInventoryMov(%$pim_row);
    }

    #$t->insert_PreInventoryMov();
    # Add ModelID, then PIM row to match.

    my $Tags = [
        {
            TagName => 'Test Tag Number 1',
            ModelIDs => [
                $t->{IDModel},
                ($t->{ModelID} + 1),
            ],
        }
    ];

    my $count = 0;
    for my $Tag (@$Tags) {
        $count++;
        my $ThisTagName = "Test Tag Number $count";
        generic_insert($t->dbh, 'Tag', [
            {TagName => $ThisTagName },
        ]);

        my ($IDTag) = $t->dbh->selectrow_array(
            "select IDTag from Tag where TagName = ?", {}, $ThisTagName
        );
        ok($IDTag, "Got IDTag $IDTag for TagName $ThisTagName");
        $Tag->{IDTag} = $IDTag;
        my $ModelIDs = $Tag->{ModelIDs};
        for my $ModelID (@$ModelIDs) {
            #say "Going to insert into TagModel with IDTag = $IDTag, IDModel = $ModelID";
            generic_insert($t->dbh, 'TagModel', [
                {IDTag => $IDTag},
                {IDModel => $ModelID},
            ]);
        }

    }
    ok($Tags->[0]{IDTag}, "Recorded IDTag in associated data structure.");
    #pass Dumper($t->dbh->selectall_arrayref("select * from TagModel where IDTag = $Tags->[0]{IDTag}", {Slice => {}}));

    generic_insert($t->dbh, 'TagQtyPriceBreak', [
        {IDTag => $Tags->[0]{IDTag}},
        {MinQuantity => 5},
        {Discount => 0.2},
    ]);

    my $price_after = $t->sp_PreSale_CalcPrice;
    ok($price_after, "Got price after ($price_after) adding PriceBreak");
    ok($price_after < $price_before, "Price after is less than price before.");
}

{
    pass "Test if TagQtyPriceBreak works for all rows with the DocumentID, or it only seems to sum one row at a time";


}

$dbh->rollback();
# Hack to redo tests with an alternate method.
my $redo = $::SET_DISCOUNT_METHOD eq 'sp_PreSale_SetDiscount' ? 1 : 0;
$redo = 0 if $opt->{current_test};

if ($redo) {
    print "\n\n\n";
    print "Repeat all tests with *_AddItem instead of *_SetDiscount\n";
    print "\n\n\n";
    $::SET_DISCOUNT_METHOD = 'sp_PreSale_AddItem';
    goto start_of_tests;
}


__END__


=pod performance tests
begin tran;

--select top 1 IDPreSale, ItemDiscount from Invoice order by IDPreSale desc;
declare @New_IDDiscount int;
exec sp_Discounts_Upsert
    @IDDiscount = @New_IDDiscount OUTPUT,
    @DiscountName = 'Test discount.',
    @StartOn = 2013-01-01 01:01:01,
    @EndOn = 2038-01-18 03:14:07,
    @BeginTimeOfDay = NULL,
    @EndTimeOfDay = NULL,
    @DiscType = 'promo',
    @MinSubtotal = NULL,
    @IDStore = NULL,
    @MaxUsesPerCustomer = NULL,
    @MaxUsesInTotal = NULL,
    @FirstTimeCustomerOnly = 0,
    @CustomerCardRequired = 0,
    @IsStackable = 0,
    @RewardAmount = 0.85,
    @AmountType = 'Percent Off Item',
    @RewardQuantity = NULL,
    @MinQuantity = NULL,
    @MinDollarAmount = NULL;
select @New_IDDiscount;


rollback;


The following SQL tests are no longer maintained now that we have a much
better testing system in perl. However, it is kept around in case we want
to resurrect a pure TSQL testing system as well.

-- 9417 is just a particular order I found on 828 with this query:
select top 3 DocumentID, count(*)
from PreInventoryMov
group by DocumentID
having count(*) between 3 and 8
order by DocumentID desc;

select DocumentID, IDPreInventoryMov, ModelID, Qty, SalePrice, UnitDiscount, Discount
from PreInventoryMov where DocumentID = 9417;

exec sp_PreSale_SetDiscount @DocumentID = 9417;

select DocumentID, IDPreInventoryMov, ModelID, Qty, SalePrice, UnitDiscount, Discount
from PreInventoryMov where DocumentID = 9417;
go

select * from vw_DiscInputs where DocumentID = 9417;
--
--select * from vw_CalcCustomerDiscounts where DocumentID = 13679;
--select * from vw_CalcCustomerDiscounts where DocumentID = 13679;


/*  generic_insert($dbh, 'Ent_CustomerDiscount', {
        IDTipoPessoa => 2,
        IDGroup => $idgroup_test1,
        Discount => 5,
    });
    */

--insert into Ent_CustomerDiscount (IDTipoPessoa
/*
select * from PreInventoryMov where DocumentID = 13679;
select * from PreInventoryMov where DocumentID = 9417;
select DocumentID, count(*) from PreInventoryMov group by DocumentID having count(*) between 4 and 15 order by DocumentID desc;
*/

--select * from fn_CalcCustomerDiscounts(9417);
--select * from vw_CalcStandardDiscounts where DocumentID = 9417;


=pod Old tests:

-- select 'Before SPs: ' as debug_msg, IDPreInventoryMov, Qty, SalePrice, Discount
-- from PreInventoryMov
-- where DocumentID = @TestDocumentID
-- order by 2;


delete from DiscountEntries;
insert into DiscountEntries
    (IDDiscountEntry, IDDiscount, RewardAmount, AmountType)
values (1, 1, 0.80, 'Amount Off Item');
exec sp_PreSale_SetDiscount @TestDocumentID, @write_to_PIM;
select * from vw_PreInventoryMovWithDiscounts where DocumentID = @TestDocumentID;

delete from DiscountEntries;
insert into DiscountEntries
    (IDDiscountEntry, IDDiscount, RewardAmount, AmountType)
values (1, 1, .25, 'Percent Off Item');
exec sp_PreSale_SetDiscount @TestDocumentID, @write_to_PIM;
select * from vw_PreInventoryMovWithDiscounts where DocumentID = @TestDocumentID;

delete from DiscountEntries;
insert into DiscountEntries
    (IDDiscountEntry, IDDiscount, RewardAmount, AmountType)
values (1, 1, 5.00, 'Sale Price');
exec sp_PreSale_SetDiscount @TestDocumentID, @write_to_PIM;
select * from vw_PreInventoryMovWithDiscounts where DocumentID = @TestDocumentID;

delete from Discounts;
delete from DiscountEntries;
insert into Discounts (
    IDDiscount, Start_Timestamp, End_Timestamp, DiscType,
    FirstTimeCustomerOnly, CustomerCardRequired, IsStackable
)
values (
    1, '2013-01-01 00:00:00', '2013-12-31 00:00:00', 'Coupon',
    0, 0, 0
);
insert into DiscountEntries
    (IDDiscountEntry, IDDiscount, RewardAmount, AmountType)
values (1, 1, 7.50, 'Amount Off Item');
exec sp_PreSale_SetDiscount @TestDocumentID, @write_to_PIM;
select * from vw_PreInventoryMovWithDiscounts where DocumentID = @TestDocumentID;

ROLLBACK TRAN @TransactionName;
go