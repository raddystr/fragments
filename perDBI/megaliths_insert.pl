#!/usr/local/bin/perl
use strict;
use warnings;

die"Usage:insertmegadata".
"<data file> <site name> <location> <map references> <type> <description> \n" 
unless @ARGV==6;

my $megalithFile = $ARGV[0];
my $siteName = $ARGV[1];
my $siteLoacation=$ARGV[2];
my $siteMapRef = $ARGV[3];
my $siteType = $ARGV[4];
my $siteDescription=$ARGV[5]; 

open MEGAFILE,">>$megalithFile" 
	or die "Can't open $megalithFile for appending: $!\n";

my $record = join(":", $siteName, $siteLoacation, $siteMapRef,
			$siteType, $siteDescription );

	print MEGAFILE "$record\n"
		or die "Error writting to $megalithFile: $!\n";

	close MEGAFILE or die "Error closing $megalithFile: $!\n";

	print "Inserted record for $siteName\n";

exit; 	
