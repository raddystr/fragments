#!/usr/local/bin/perl
use strict;
use warnings;

print"Hello, enter the full path to the targeted directory:\n";

my $dir = <STDIN>;
chomp($dir);

print"Thanks, now enter the thing that you want to find:\n";
my $thing = <STDIN>;
chomp($thing);

foreach my $file(glob("$dir/*.*")){
	printf "%s\n", $file;
	open FH, "<$file" or die "I can't read it!\n";

	while(<FH>){
		if($_ =~ m/$thing/){
		printf" %s",$_;
		}
	}
	close FH or die "I can't do this\n"; 
}





