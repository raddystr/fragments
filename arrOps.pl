#!/usr/bin/perl
use strict;
use warnings;


my @arr = qw(Petko Metko Zetko Detko);

my $shifty = shift @arr;
my $popy = pop @arr;

unshift (@arr, "Cvetko");
push (@arr, "Tetko");
print $shifty. "\n";
print $popy ."\n";

print "@arr\n"; 
