#!/usr/bin/perl
use strict;
use warnings;

my $ref1= [
	{
	 	'22'=>['John Smith', 33, 'Cincinati'],
		'27'=>['Laxmi Narayan', 24, 'Cochin'],
		'34'=>['Lars Jensen', 42, 'Stockholm']
	},
	{
		'CA'=>{
			'San Diego' =>[32.4, 117.1, 'Coronado Bay Bridge'],
			'Los Angeles'=>[33.4, 118.1, 'Vincent Thomas Bridge'],
			'San Francisco'=>[37.4, 112.2, 'Goldem Gate Bridge'],
		},
		'NH'=>{
			'Concord'=>[43.3, 71.2, 'I93'],
			'Manchester'=>[42.5, 71.8, 'Queen Street Bridge'],
			'Cornish' =>[43.3, 72.2, 'Cornish Windsor Covered Bridge']
		},
	},
	{
		'scalar_key'=>"I'm a string!"
		
	} 
];

sub ref_iterate{
	my($ref1, $top_flag, $tabcount) = @_;
	my $tabchar = '    ';

	if(ref($ref1) eq 'HASH'){
		$tabcount++; 
		for(keys %$ref1){
			print $tabchar x $tabcount . "$_=> ";
			print "\n" unless $top_flag;

			print "\n" if ref($ref1->{$_});
			ref_iterate($ref1->{$_},0,$tabcount );
		}
	}
	elsif(ref($ref1) eq 'ARRAY'){
		$tabcount++;
		print $tabchar x $tabcount;
		print "[ " unless $top_flag;
		for my $i (0 .. $#{$ref1}){
			ref_iterate($ref1->[$i], 0 ,$tabcount);
			print ', ', unless $i == $#{$ref1};
		}
		print " ] ,\n" unless $top_flag;
	}else{
		print "\"$ref1\"";
	}
	return; 
}
ref_iterate($ref1); 
