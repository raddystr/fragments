#!/usr/local/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $idcounter=0;
#STATS VALUE
my $sumsOT = {}; 
my $sumsAT={};
my $operationsOT={};
my $operationsAT={};
my $user_idOT={};
my $user_idAT={};
my $moneyId={};
my $actionType = {};
my $bingoId={};
my $id_deposit_bingo={};

#TOTALS
my ($total_operations,  $total_amount);


#FILE OPENING
my $file = ( shift || 'data.csv' ); 

#ARRAY WITH LABALED COLUMNS

my @LABEL_NAMES = ();

open(my $data, '<', $file) or die "I can't open it!\n";

while (my $line = <$data>) {

	
	my $FIELDS_NAMES_VALUES = {} ;



	#BETTER CHOMP  
	$line =~ s/[\r\n]$//g;

	#COMMA SPLITING
	my @fields = split( /','/ , $line );
	
	# QUOTING REMOVE
	foreach my $f ( @fields ) {
	
		$f =~ s/'//g;
	}
	
	##LABELING AND REMOVES LINES WITH LABEL VALUES
	if ( $fields[0] eq 'user_id' and $fields[1] eq 'operation_type' and $fields[2]  eq 'action_type' and $fields[3] eq 'money_amount' ) {
	
		print "LABEL ROW :: $line \n";
		print"\n"; 
		@LABEL_NAMES = @fields ;
		next;
	}
	
	if ( scalar @fields <= 0 or scalar @fields != scalar @LABEL_NAMES ) { 
	
		print "Error split $line\n";
		exit;
	}

	foreach my $f_no ( 0..$#fields ) {
	
		$FIELDS_NAMES_VALUES->{$LABEL_NAMES[$f_no]} = $fields[$f_no] || undef ; 
		if ( !defined $FIELDS_NAMES_VALUES->{$LABEL_NAMES[$f_no]}  ) {
		
			print "Undef values after split/cleanup $line\n";
			exit;
		}
	}


	$total_operations++;
	$total_amount += $FIELDS_NAMES_VALUES->{money_amount};

	$operationsOT->{$FIELDS_NAMES_VALUES->{operation_type}} += 1;
	$operationsAT->{$FIELDS_NAMES_VALUES->{action_type}} += 1;  
		
	$sumsOT->{$FIELDS_NAMES_VALUES->{operation_type}} += $FIELDS_NAMES_VALUES->{money_amount};
	$sumsAT->{$FIELDS_NAMES_VALUES->{action_type}} += $FIELDS_NAMES_VALUES->{money_amount}; 
	
	$user_idOT->{$FIELDS_NAMES_VALUES->{operation_type}}->{$FIELDS_NAMES_VALUES->{user_id}} = 1 ;
	$user_idAT->{$FIELDS_NAMES_VALUES->{action_type}}->{$FIELDS_NAMES_VALUES->{user_id}} = 1 ;

	
	$moneyId->{$FIELDS_NAMES_VALUES->{user_id}} += $FIELDS_NAMES_VALUES->{money_amount};

	foreach my $action_type($FIELDS_NAMES_VALUES->{action_type}){
		if($action_type eq 'bingo_game'){
			$bingoId->{$FIELDS_NAMES_VALUES->{user_id}}+=1;
		}
	}

	foreach my $operation_type($FIELDS_NAMES_VALUES->{operation_type}){
		if($operation_type eq 'DEPOSIT'){
			$id_deposit_bingo->{$FIELDS_NAMES_VALUES->{user_id}}+=1;
		}
	}

}			

	
print "Total amount:$total_amount\n";
print"\n";
print "Total operations: $total_operations\n";
print"\n\n\n"; 

print "OPERATION_TYPE STATISTCS:\n";
print"\n"; 
print"Count OPS by operation_type:\n";
foreach my $op_op (keys %{$operationsOT}){
	print"$op_op - $operationsOT->{$op_op}\n";
	
}
print"\n";

print "Sums by operation_type:\n";
foreach my $opsum(keys %$sumsOT){
	print"$opsum - $sumsOT->{$opsum}\n"; 
}
print "\n";

print "Count users by operation_type:\n";
foreach my $op_type ( keys %{$user_idOT} ) {
	print "$op_type = ";
	print scalar keys %{$user_idOT->{$op_type}} ;
	print "\n";
}
print "\n\n\n";

print "ACTION_TYPE STATISTICS:\n";
print"\n"; 
print"Count of OPS by action_type:\n";
foreach my $ac_op(keys %$operationsAT){
	print"$ac_op - $operationsAT->{$ac_op}\n";
}
print"\n";
print"Sums by action_type:\n"; 
foreach my $ac_sum(keys %$sumsAT){
	print "$ac_sum - $sumsAT->{$ac_sum}\n";
}
print"\n"; 
print "Count users by action_type:\n";
foreach my $ac_type( keys %{$user_idAT} ) {

	print "$ac_type = ";
	print scalar keys %{$user_idAT->{$ac_type}} ;
	print "\n";
}
print "\n\n\n";

print"Users with operation_type - DEPOSIT and action_type - bingo_game:\n"; 
foreach my $id(keys %$id_deposit_bingo){
	if(exists $bingoId->{$id}){
	print"$id - $id_deposit_bingo->{$id}\n";
	}
}

print"\n\n\n";
my $counter_Top5; 
print "Top 5 users by sums are:\n";
foreach(sort{$moneyId->{$b} <=> $moneyId->{$a}} keys %$moneyId) 
{	
	$counter_Top5++; 
	if($counter_Top5 <=5){	
	print"$_ - $moneyId->{$_}\n";
	}
} 
print "\n\n\n"; 
print "TOP 5 users by bingo_games:\n"; 
my $counter_Bingo5;
foreach(sort{$bingoId->{$b} <=> $bingoId->{$a}} keys %$bingoId) 
{	
	$counter_Bingo5++; 
	if($counter_Bingo5 <=5){	
	print"$_ - $bingoId->{$_}\n";
	}
}




