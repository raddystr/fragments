#!/usr/local/bin/perl

use strict; 
use warnings;

##### Generating filename ##################################

my($sec, $min, $hour, $mday,$mon,$year,$wday,$yday,$idst)=localtime(); 
my $hostname = qx/hostname/;
$hostname =~ s/\n//;
my $filename = $hostname.$mday.$mon.$year.'.txt';

############### FILES #############

my @files=qx/ls/;
#######
open (FH, '>>', $filename) or die "I can't!";

print FH @files;

close FH;
