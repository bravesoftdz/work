#!/usr/bin/env perl

=head1 NOTES

Automated testing code for the podb sync system.

=cut


use Modern::Perl;
use Test::More qw(no_plan);
use Data::Dumper;
use DBI;
use English;
use File::Basename;
use lib "./Tests/";
use Custom::TestHelper qw(mssql_dbh);
use Custom::DB qw(generic_insert);
use Carp;
my $DB_NAME = 'fairless_hills';
my $dbh = TestHelper::mssql_dbh($DB_NAME);
$dbh->begin_work();

{
	my ($level) = $dbh->selectrow_array(qq{
		select compatibility_level from sys.databases where name = '$DB_NAME';
	});
	is($level, 80, "Got expected database compatibility level of $level");

	my ($before_count) = $dbh->selectrow_array('select count(*) from SyncChanges');

	$dbh->do('update Model set SellingPrice = SellingPrice where IDModel in (select top 2 IDModel from Model order by IDModel)');
	#$dbh->do('update Inventory set StoreID = StoreID where StoreID=1 and ModelID = 2');
	$dbh->do('insert into SyncBatches (SynchronizedOn) values (current_timestamp)');
	#select * from SyncBatches;
	$dbh->do('update Model set SellingPrice = SellingPrice where IDModel in (select top 4 IDModel from Model order by IDModel)');
	my $results = $dbh->selectall_arrayref('select * from SyncChanges', {Slice => {}});
	#print Dumper($results);

	my $num_changes = 4;
	my ($after_count) = $dbh->selectrow_array('select count(*) from SyncChanges');
	is($before_count + $num_changes, $after_count,
		"The before ($before_count) and after ($after_count) counts differ by exactly $num_changes, which is "
		. "how many it should be after changing two, then four."
	);

}

$dbh->rollback();
