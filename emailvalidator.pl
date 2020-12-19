#!/usr/bin/perl
use warnings;
use strict;
####regex for validating emails


for(@ARGV){

	if ( $_ =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/ ) {	
		print "Valid!\n";
	} else {
	
		print "Not valid!\n";
	}
}
