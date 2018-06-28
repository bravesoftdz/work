package Custom::TestHelper;

=head1 NOTES

To get this working on a new Windows install, simply ensure
that the "$db_instance" variable below correctly points at the
correct SQL Server. In my installations, a value of "(local)"
works great. For others, it might be ".\\MSSQLSERVER" or
".\\SQLExpress".

If you're not using Windows Authentication ("Trusted_Connection=Yes"),
then it would be necessary to setup and enter usernames and passwords.

SQL Server Configuration Manager should have TCP/IP and Named Pipes
already enabled for SQL Native Client 10.0 Configuration, so nothing
should be required to change there.

It is *not* necessary to create an ODBC DSN; however, if you want to
to do it anyway for som reason, it's important to know the odbc
libraries are different for 64-bit apps and 32-bit apps, and the
paths they are in and names they have do not make much sense:

64-bit:

 C:\Windows\system32\odbcad32.exe

32-bit:

 C:\Windows\SysWOW64\odbcad32.exe

=head1 REQUIRED MODULES

 Modern::Perl DBI DBD::ODBC Mouse Test::Most Log::Log4perl

 mkdir logs/

=cut

use Modern::Perl;
use Carp;
use DBI;
use base qw(Exporter);
use vars qw(@EXPORT_OK);
@EXPORT_OK = qw(mssql_dbh);

sub mssql_dbh {
	my ($db_name) = @_;
	croak "db_name required" unless $db_name;

	#my $ver = '10.0';   # 2008
	#my $db_instance = "(local)\\mssqlserver"; # 2008

	my $ver = '11.0';   # 2014
	my $db_instance = "(local)\\mssql2014"; # 2014


	my $conn_str = "DBI:ODBC:Driver={SQL Server Native Client $ver};"
		. "Server=$db_instance;Database=$db_name;Trusted_Connection=Yes";
	my $dbh = DBI->connect($conn_str) || croak "Could not get MSSQL db handle";

	# Simulate MainRetail:
	$dbh->do('set arithabort off');
	$dbh->do('set xact_abort on');
	#$dbh->do('SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, '
	#	. 'CONCAT_NULL_YIELDS_NULL, NUMERIC_ROUNDABORT, '
	#   . 'QUOTED_IDENTIFIER OFF');

	return $dbh;
}

1;