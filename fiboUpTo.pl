#!/usr/bin/perl
use warnings;
use strict;

print "Fibonacci serie to: ";

my $z=<STDIN>;
my $y=0;
my $x=1;
my $s=$y+$x;

while(1){

$y=$x;
$x=$s;
$s=$y+$x;

if($s>$z){
	last;
}
	print("\t$s\n");
}


