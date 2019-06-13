#!/usr/local/bin/perl
use strict;
use warnings;
use Net::FTP;

my $ftp = Net::FTP->new("ftp.cpan.org")  or die "Couldn't connect $@\n";
$ftp->login("anonymous");
$ftp->cwd("/pub/CPAN");
$ftp->get("README.html");
$ftp->close; 

