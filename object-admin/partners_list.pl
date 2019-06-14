#!/usr/local/bin/perl
use DBI;
use CGI;
use HTML::Template::Pro;
use strict;

my $rows;
my $dbh=DBI->connect(
	('dbi:mysql:partners_stats','partners_dbadmin','P@ssword1'), 
	{RaiseError=>1}
);

my $cgi = CGI->new();

my $sth = $dbh->prepare('
	select recno, name, adress, status 
	from partners');

$sth->execute();

push @{$rows}, $_ while $_ = $sth->fetchrow_hashref();
$dbh->disconnect();

if($rows){
	my $template = HTML::Template::Pro->new(filename=>'partners_list.tmpl');
	$template->param(ROWS=>$rows);

	print $cgi->header();
	print $template->output();

}else{
	print"Content-type:text/html\n\n";
	print"No data available\n";
print<<END;
<form action="partners_form.pl">
<input type="submit" value="Register a new partner"/>
</form>
END
}

