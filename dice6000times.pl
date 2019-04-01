#!/usr/bin/perl

use warnings;
use strict;

foreach(1..6000){
random();
}
sub random{
my $ran = int(rand(6));
if($ran>0){
print  $ran . "\n";
	}
}

