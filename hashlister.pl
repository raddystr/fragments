#!/usr/local/bin/perl 
use strict;
use warnings;
use diagnostics;

my %hash; 

while(1){
	print"What would you like to do? (press 'o' for options):\n";

	my $input=<STDIN>;
	chomp($input); 


	if($input eq "o"){
		options();
		next;  
	}elsif($input eq "r"){
		read_();
		next;
	}elsif($input eq "l"){
		list();
		next;
	}elsif($input eq "w"){
		write_();
		next;
	}elsif($input eq "d"){
		delete_();
		next;
	}elsif($input eq "x"){
		clear();
		next;
	}elsif($input eq "q"){
		last; 
	}
	sub options{
		print<<EOF

		Options available:

		o - view options
		r - read entry
		l - list all entries
		w - write entry
		d - delete entry
		x - delete all entries
EOF

	}

	sub read_{
		my $key_name = get_key();
		if(exists $hash{$key_name}){
		print'nElement $key_name has value', "$hash{$key_name}.\n";
		}else{
			print"Sorry, this element does not exists.\n";
		}
	}

	sub write_{
		my $key_name = get_key();
		my $key_val = get_val();

		if(exists $hash{$key_name}){
			print"Sorry this element already exists.\n"
		}else{
			$hash{$key_name} = $key_val;
		}
	}	
	sub delete_{
		my $key_name = get_key();
		if(exists $hash{$key_name}){
			print "This will delete entry $key_name.\n"; 
			delete $hash{$key_name}; 
		}else{
			print"The file does not exists.\n"; 
		}
	
	}
	sub clear{
		%hash = undef;
	}sub get_key{
		print"Enter key name of element: \n";
		chomp (my $key_name = <STDIN>);
		return $key_name;
	}
	sub get_val{
		print"Enter value of element:\n";
		chomp(my $val_name=<STDIN>);
		return $val_name;	
	}	
}
