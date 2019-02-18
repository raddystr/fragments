#!/usr/bin/perl
use warnings;
use strict;

my $str = <STDIN>;

if ( $str =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/ ) {
	print "valid\n";
} else {
	print "not valid\n";
}
