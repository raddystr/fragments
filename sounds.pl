#!/usr/local/bin/perl

 use warnings;
 use strict;
 
 my @array = qw(duck pig horse rooster cow);
 my %hash = ( duck => "quack",
 		pig => "oink",
 		horse => "neigh",
 		rooster => "doodle-doo",
 		cow => "mow" );
 
 my $arrayRef = \@array;
 my $hashRef = \%hash;
 
 print("@$arrayRef\n");
 print("\$\$arrayRef[1] = $$arrayRef[1]\n");
 print("\$arrayRef->[1] = $arrayRef->[1]\n");
 print("\${returnReference()}[1] = ${returnReference()}[1]\n\n");
 print("\$\$hashRef{duck} = $$hashRef{duck}\n");
 print("\$hashRef->{duck} = $hashRef->{duck}\n\n");
 
 foreach (keys(%$hashRef)) {
 	print("The $_ makes $hashRef->{$_}.\n");
 }
 
 #########
 sub returnReference { 
 	return \@array;
 }
