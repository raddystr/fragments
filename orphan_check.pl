#!/usr/bin/perl

use strict;
use warnings;

my @pid = qx/ps -ef | awk '\$3 == 1 { print \$2 }'/; 

my @time = qx/ps -ef | awk '\$3 == 1 { print \$5 }'/;

my @proc_name = qx/ps -ef | awk '\$3 == 1 { print \$8 }'/;

my $wc_l = scalar @pid - 1; 

my $python3_usage = 0;

my $total_swap = 0; 

for my $i (1 .. $wc_l ){

	chop($pid[$i]);
	chop($time[$i]);
	chop($proc_name[$i]); 		
	
	my $memory_usage = `cat /proc/$pid[$i]/status | grep -i swap | awk '{ print \$2 } '` ;

	my $user_name = `ps -o user= -p $pid[$i]`;	
	chop($user_name); 	

	$total_swap += ( ($memory_usage) * 1 );
	
	if ($proc_name[$i] eq 'python3'){
	
		$python3_usage += ( ($memory_usage) * 1 );
	
	}
	
	print"PID: $pid[$i]\n";
	print"USER: $user_name\n"; 
	print"START: $time[$i]\n";
	print"NAME\/PATH: $proc_name[$i]\n";
	
	chop($memory_usage);
	
	print "SWAP USED: $memory_usage Kb \n\n";

	
}

print"-------------------------------------------------------------------------------------------\n";
print"PPID1 PROCESSES TOTAL:$wc_l\n"; 
print"-------------------------------------------------------------------------------------------\n";
print "PPID1 PROCESSES TOTAL SWAP USED: $total_swap Kb\n";
print"-------------------------------------------------------------------------------------------\n";
print "PYTHON3 PROCESSES TOTAL SWAP USED: $python3_usage Kb \n";
print"-------------------------------------------------------------------------------------------\n";
