#!/usr/local/bin/perl
use strict;
use warnings;

chomp(my $input = input());
 
my ($hours, $minutes, $seconds) = secs2hms($input);

print"$input seconds are $hours hours, $minutes minutes and $seconds seconds\n";

sub secs2hms{
	my ($h, $m);
	my $seconds = shift;

	$h = int($seconds/(60*60));$seconds %=60*60;
	$m = int($seconds/60); 	$seconds %=60;

	($h,$m,$seconds); 
}

sub input{
print"Tell me the number of seconds that you want to translate in hours, minutes and seconds!\n";
my $input = <STDIN>;
return($input);

}
