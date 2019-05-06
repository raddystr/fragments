#!/usr/bin/perl
use strict;
use warnings;
use DBI;

my $dbh = DBI->connect('dbi:mysql:*','*','*') or die 'Problem with dbh!';
my $sth;
#my $sth =$dbh->prepare(q{INSERT INTO stat(id, operation_type, action_type, sums)VALUES(?,?,?,?)});

my $file = (shift || 'data.csv');

my @LABEL_NAMES=();

open(my $data, '<', $file ) or die 'I can`t open it!\n';

while(my $line = <$data>){
	$line=~ s/[\r\n]$//g;
	my @fields = split(/','/, $line);

	foreach my $f(@fields){
		$f =~ s/'//g;
	}

	if($fields[0] eq 'user_id' and $fields[1] eq 'operation_type' and $fields[2] eq 'action_type' and $fields[3] eq 'money_amount'){
		print"LABEL ROW::$line\n";
		print"\n";
		@LABEL_NAMES =@fields;
		next;
	}
	if(scalar @fields <=0 or scalar @fields != scalar @LABEL_NAMES){
		print"Error split $line\n";
		exit;
	}
	#	$sth->execute($fields[0],$fields[1],$fields[2],$fields[3]);
	
		


	}
print"ops by opeartion_type:\n";	
$sth =$dbh->prepare("SELECT DISTINCT operation_type, COUNT(operation_type) AS count FROM stat GROUP BY operation_type");
$sth->execute(); 	
while(my @row=$sth->fetchrow_array){
		print"@row\n"; 

	}
print"\n";	
print"sums by opeartion_type:\n";	
$sth =$dbh->prepare("SELECT DISTINCT operation_type, SUM(sums) AS amount FROM stat GROUP BY operation_type");
$sth->execute(); 	
while(my @row=$sth->fetchrow_array){
		print"@row\n"; 

	}
print"\n";	
print"unique ids by operation_type:\n";
$sth =$dbh->prepare("SELECT DISTINCT operation_type, COUNT(DISTINCT id) AS count FROM stat GROUP BY operation_type");
$sth->execute(); 	
while(my @row=$sth->fetchrow_array){
		print"@row\n"; 

	}
print"\n";
print"ops by action_type:\n";
$sth = $dbh->prepare("SELECT DISTINCT action_type, COUNT(action_type) AS count FROM stat GROUP BY action_type");
$sth->execute;
while(my @row=$sth->fetchrow_array){
	print"@row\n"; 
}
print"\n";
print"sums by action_type:\n";
$sth = $dbh->prepare("SELECT DISTINCT action_type,SUM(sums) AS amounts FROM stat GROUP BY action_type");
$sth->execute;
while(my @row=$sth->fetchrow_array){
	print"@row\n"; 
}
print"\n";
print"unique ids by action_type:\n";
$sth = $dbh->prepare("SELECT DISTINCT action_type,COUNT(DISTINCT id) AS count FROM stat GROUP BY action_type");
$sth->execute;
while(my @row=$sth->fetchrow_array){
	print"@row\n"; 
}
print"\n";
print"unique ids with DEPOSIT and bingo games:\n";
$sth = $dbh->prepare("SELECT id FROM idDepBing GROUP BY id HAVING COUNT(id)>1");
$sth->execute;
while(my @row = $sth->fetchrow_array){
	print"@row\n"; 
}
print"\n";
print"TOP 5 by money_amount:\n";
$sth=$dbh->prepare("SELECT id, sums FROM idSums ORDER BY SUMS DESC LIMIT 5");
$sth->execute; 
while(my @row=$sth->fetchrow_array){
	print"@row\n"; 
}
print"\n";
print"TOP 5 action_type = 'bingo_game':\n"; 
$sth=$dbh->prepare("SELECT * FROM idCountBingo ORDER BY countBingo DESC LIMIT 5");
$sth->execute;
while(my @row=$sth->fetchrow_array){
	print"@row\n";
}
$dbh->disconnect; 
