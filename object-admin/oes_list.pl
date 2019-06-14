#!/usr/local/bin/perl
use DBI;
use CGI;
use HTML::Template::Pro;
use strict;

my $rows;
my $dbh=DBI->connect(
	('dbi:mysql:db','name','pass'), 
	{RaiseError=>1}
);

my $cgi = CGI->new();

my $sth = $dbh->prepare('
	select recno, obj_recno, empl_recno, date, sell_type, sum, status 
	from objects_employees_sells');

$sth->execute();

push @{$rows}, $_ while $_ = $sth->fetchrow_hashref();
$dbh->disconnect();

if($rows){	
	my $template = HTML::Template::Pro->new(filename=>'oes_list.tmpl');
	$template->param(ROWS=>$rows);

	print $cgi->header();
	print $template->output();
}
else{
	print"Content-type:text/html\n\n";
	print"No data available\n";
print<<END;
<form action="oes_form.pl">
<input type="submit" value="Register a new sell "/>
</form>
END
}


