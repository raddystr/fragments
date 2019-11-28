#!/usr/local/bin/perl

use strict;
use warnings;
use LWP::Simple qw/get/; 

my $URL = 'https://www.emag.bg/smartfon-xiaomi-mi-a3-dual-sim-64gb-4g-kind-of-grey-mi-a3-64-4-grey/pd/D7B936BBM/?X-Search-Id=783e2ce46fe0cd147089&X-Product-Id=53331467&X-Search-Page=1&X-Search-Position=0&X-Section=search&X-MB=0&X-Search-Action=view';

my $headers  = {	
	'user-agent'=>'Mozilla/5.0 (X11; FreeBSD amd64; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36'}; 

my $page = get $URL; 

#my $file  = '/usr/home/projects/lampBook/prices.txt';

#open(FH,'>:utf8',$file) or die $!;

my ($price, $product); 

if($page=~ /(EM.productFullPrice = \d+.\d+)/){
	$price =$1; 
	$price =~ s/EM.productFullPrice =//;	
}

if($page=~/(EM.sef_name = "(.+?)")/){
	$product  = $1;
	$product =~ s/EM.sef_name = "//;
	$product =~ s/"//;
}

print "The price of $product on ".scalar localtime." is $price lv.\n";
#close(FH); 
