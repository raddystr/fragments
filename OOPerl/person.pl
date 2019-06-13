#!/usr/local/bin/perl
use strict;
use warnings;
use lib 'path/to/Person.pm';
use Person;

my $first_person =Person->new(
	surname => "Tyson",
	forename => "Mike",
	adress => "California",
	occupation=>"entrepreneur"
); 

print"This citizen is number: ", Person->citizen_counter, "\n";

my $second_person  = new Person(
	surname =>"Durden",
	forename=>"Tyler",
	adress =>"Soap factory street",
	occupation=>"leader of project Mayhem"
);

print"This citizen is number: ", Person->citizen_counter, "\n";

$first_person->adress("New York");
$second_person->adress("Down Town");
$first_person->age('50');
$second_person->age('35'); 

print $first_person->presentation(), ".\n";  
print $second_person->presentation(), ".\n";

for my $person(Person->everyone){
	print $person->forename, " ",  $person->surname, "\n"; 
}

$first_person->print_letter("Please send Evender's ear back.");

$second_person->print_letter("I create a fight club in Konyovitza!"); 
