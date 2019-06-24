#!/usr/local/bin/perl
use strict;
use warnings;


die "Usage: scnamedata<data file><site name>\n" unless @ARGV==2;

my $megalith_file = $ARGV[0];
my $site_name = $ARGV[1]; 


open MEGAFILE, "<$megalith_file" or die "Can't open $megalith_file: $!\n"; 

my ($name, $location, $mapref, $type, $description);

my $found;

while(<MEGAFILE>){
	chop;	
	($name, $location, $mapref, $type, $description)=split(/:/, $_);
       	if($name eq $site_name){
       		$found = $.;

		last;
       	}	
}
if($found){
	print "Located site: $name on line $found\n";
	print "Information on $name($type)\n";
	print "===============",
		("="x(length($name)+length($type)+5)), "\n";
	print"Location: $location\n";
	print"Map Reference: $mapref\n";
	print"Description: $description\n"; 
}
close MEGAFILE;

exit; 
