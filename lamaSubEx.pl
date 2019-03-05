#!/usr/local/bin/perl
use strict;
use warnings;

sub sum{
	my $sum;
	my $number;
	my @numbers = @_;
	my $count = $#numbers+1;
	foreach $number(@numbers){
		$sum +=$number;
}
	my $average = $sum/$count;
		
	foreach $number(@numbers){
		if($number>$average){
			print"$number\n";
		}
	}
			#print"$sum\n";
			#print"$count\n";
			#print"$average\n"; 
			
		
}		
sum(1...1000)
