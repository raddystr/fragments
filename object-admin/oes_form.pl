#!/usr/local/bin/perl
use strict;
use warnings;
use CGI qw(:all);
use DBI;
use HTML::Template::Pro;


my $template = HTML::Template::Pro->new(filename=>'oes_form.tmpl');
my $cgi=CGI->new();

print"Content-type:text/html\n\n";
if($cgi->param('obj_recno') and $cgi->param('empl_recno') and  $cgi->param('sell_type') and $cgi->param('sum') and $cgi->param('status')){
	my $obj_recno = $cgi->param('obj_recno');
	my $empl_recno = $cgi->param('empl_recno');
	my $sell_type = $cgi->param('sell_type');
	my $sum = $cgi->param('sum');
	my $status = $cgi->param('status');

	my $query = "insert into objects_employees_sells(obj_recno, empl_recno, sell_type, sum, status)values('$obj_recno', '$empl_recno', '$sell_type', '$sum', '$status')";

	my $dbh=DBI->connect(
		('dbi:mysql:db','name','pass'), 
		{RaiseError=>1}
		);

	my $sth=$dbh->prepare($query);

	$sth->execute();
	$dbh->disconnect();

print h1 ("Congrats! You register a new sell!");
print<<END;

<form action="oes_list.pl">
<input type="submit" value="Back to sells list"/>
</form>
END
}else{
	print $template->output(); 
}
