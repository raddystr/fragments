#!/usr/local/bin/perl
use strict;
use warnings;
#Choose starting parameter 
#if you want to encrypt something chose encode
#if you want to decrypt chose decode 
#example: perl encode_decode.pl encode

my $param = shift;

die "Please start the program with parameter 'encode' or 'decode'\n" unless($param); 

chomp($param);

if($param eq 'encode' ){
	print"Enter the message for encryption:\n";
	my $input =<>;
	chomp($input); 
	
	print"Choose the cipher number:\n";
	my $offset=<>;
	if($offset !~ /^-?\d+$/){
		die "The cipher number must be integer!\n";
	}

	my $result = "";

	print"This is the encrypted message: "; 
	
		my @array_input =split('',$input);
	
	foreach(@array_input){
		if((ord( $_ )< 65 || ord( $_ )>90 ) && (ord($_)<97 || ord($_)>122 ) ){
			$result .=$_;
		
			}
		if(ord( $_ )>=65 && ord($_)<=90) {
		
			$result .= chr((ord($_)+$offset-65)%26+65); 
			}
		if(ord($_)>=97 && ord($_)<=122){
			$result .= chr((ord($_)+$offset-97)%26+97); 

			}
		}	
	print "$result\n";
	 
 

}elsif($param eq 'decode'){
	print"Enter the message for decryption:\n";
	my $input =<>;
	chomp($input); 
	
	print"Choose the cipher number:\n";
	my $offset=<>;
	
	if($offset !~ /^-?\d+$/){
		die "The cipher number must be integer!\n";
	}

	my $result = "";

	print"This is the encrypted message: "; 
	
	my @array_input =split('',$input);
	
	foreach(@array_input){
		if((ord( $_ )< 65 || ord( $_ )>90 ) && (ord($_)<97 || ord($_)>122 ) ){
			$result .=$_;
		}
		if(ord( $_ )>=65 && ord($_)<=90) {
		
			$result .= chr((ord($_)-$offset-65)%26+65); 
			}
		if(ord($_)>=97 && ord($_)<=122){
			$result .= chr((ord($_)-$offset-97)%26+97); 

			}
	
	}	
	print "$result\n";
	 
 }elsif($param ne 'encode' or $param ne 'decode' or $param eq undef){
	
	print"Please start the program with parameter 'encrypt' or 'decode'\n"; 

}
