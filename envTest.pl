#!/usr/bin/perl

$userName =$ENV{'LOGNAME'};

print "Hello, $userName!\n";

foreach(sort keys %ENV){

	print "$_=$ENV{$_}\n"; 
	
}
