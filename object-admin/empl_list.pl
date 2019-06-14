#!/usr/local/bin/perl
use DBI;
use CGI;
use HTML::Template;
use strict;


my $dbh=DBI->connect(
	('dbi:mysql:db','name','pass'), 
	{RaiseError=>1}
);

my $cgi = CGI->new();

my $sth = $dbh->prepare('
	select recno, user_name, name, personal_no, status 
	from employees');

$sth->execute();

my $rows;

push @{$rows}, $_ while $_ = $sth->fetchrow_hashref();
$dbh->disconnect();
if($rows){
	my $template = HTML::Template->new(filename=>'empl_list.tmpl');
	$template->param(ROWS=>$rows);

	print $cgi->header();
	print $template->output();
}else{
	print"Content-type:text/html\n\n";
	print"No data available\n";
print<<END;
<form action="empl_form.pl">
<input type="submit" value="Register a new employee!"/>
</form>
END

}


