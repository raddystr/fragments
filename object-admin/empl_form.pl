#!/usr/local/bin/perl
use strict;
use warnings;
use CGI qw(:all);
use DBI;
use HTML::Template::Pro;


my $template = HTML::Template::Pro->new(filename=>'empl_form.tmpl');
my $cgi=CGI->new();

print"Content-type:text/html\n\n";
if($cgi->param('uname') and $cgi->param('name') and  $cgi->param('pass') and $cgi->param('personal_n') and $cgi->param('status')){
	my $uname = $cgi->param('uname');
	my $name = $cgi->param('name');
	my $pass = $cgi->param('pass');
	my $personal_n = $cgi->param('personal_n');
	my $status = $cgi->param('status');

	my $query = "insert into employees(user_name, name, password, personal_no, status)values('$uname', '$name', '$pass', '$personal_n', '$status')";

	my $dbh=DBI->connect(
		('dbi:mysql:db','Name','Pass'), 
		{RaiseError=>1}
		);

	my $sth=$dbh->prepare($query);

	$sth->execute();
	$dbh->disconnect();

print h1 ("Congrats!You register a new employe!");
print<<END;

<form action="empl_list.pl">
<input type="submit" value="All employees"/>
</form>
END
}else{
	print $template->output(); 
}
