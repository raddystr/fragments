#!/usr/bin/perl
use strict;
use warnings;

sub factorial {
    my($num)=@_;
     if($num==1){
        return 1;
    }else{
        return $num*factorial($num-1);
        }
    }

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $n = <>;
$n =~ s/\s+$//;

my $result = factorial($n);

print $fptr "$result\n";

close $fptr;
