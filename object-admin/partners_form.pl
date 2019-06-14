#!/usr/local/bin/perl
use strict;
use warnings;
use CGI qw(:all);
use DBI;
use HTML::Template::Pro;


my $template = HTML::Template::Pro->new(filename=>'partners_form.tmpl');
my $cgi=CGI->new();

print"Content-type:text/html\n\n";
if($cgi->param('name') and $cgi->param('adress')and $cgi->param('status')){
my $name = $cgi->param('name');
my $adress = $cgi->param('adress');
my $status = $cgi->param('status');

my $query = "insert into partners(name, adress, status)values('$name', '$adress', '$status')";

my $dbh=DBI->connect(
	('dbi:mysql:db','admin','pass'), 
	{RaiseError=>1}
	);

my $sth=$dbh->prepare($query);

$sth->execute();
$dbh->disconnect();
print h1 ("Congrats!Our new partner is $name!");
print<<END;

<form action="partners_list.pl">
<input type="submit" value="List partners"/>
</form>
END

}else{
	print $template->output(); 
}
