#!/usr/bin/perl
use strict;
use warnings;

my $test = qx/pgrep -fl client.py/;

if($test){
	print("$test");
}else{
	print("there is no such process\n");
       	qx/python \/home\/raddy\/Project\/Nexo\/nexo_task\/client.py/;	
}
