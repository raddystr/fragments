#!/usr/local/bin/perl
use strict;
use warnings;
use CGI qw(:all);
use DBI;
use HTML::Template::Pro;


my $template = HTML::Template::Pro->new(filename=>'obj_form.tmpl');
my $cgi=CGI->new();

print"Content-type:text/html\n\n";
if($cgi->param('name') and $cgi->param('pos')and $cgi->param('adress')and $cgi->param('emp_count') and $cgi->param('status')){
my $name = $cgi->param('name');
my $pos = $cgi->param('pos');
my $adress = $cgi->param('adress');
my $emp_count = $cgi->param('emp_count');
my $status = $cgi->param('status');

my $query = "insert into objects(name, ext_pos_unique_id, adress, employees_count, status)values('$name', '$pos', '$adress', $emp_count, '$status')";

my $dbh=DBI->connect(
	('dbi:mysql:db','name','pass'), 
	{RaiseError=>1}
	);

my $sth=$dbh->prepare($query);

$sth->execute();
$dbh->disconnect();
print h1 ("Congrats!You register a new object!");
print<<END;

<form action="obj_list.pl">
<input type="submit" value="List objects"/>
</form>
END

}else{
	print $template->output(); 
}
