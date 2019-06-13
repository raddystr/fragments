#!/uss/local/bin/perl
use lib 'path/to/Employee.pm';
use Employee; 
use strict;
use warnings;

my $first_employee = Employee->new(
	surname=>"Alderson",
	forename=>"Elliot",
	adress=>"New York",
	occupation=>"hacker"
);

my $fox = new Employee(
	sunrname=>"Fox",
	employer=>"Gecko",
	salary=>"10_000"
);

my $snow = new Employee(
	surname=>"snow",
	salary=>"0"
); 

$first_employee->employer("The Dark Army");
$first_employee->phone_number('0101011010101');
$first_employee->position("Hack Architect");
my $boss = $fox->employer;
print"This is boss adress: ",$boss->adress("666 Wall Street"),"\n";

 $first_employee->print_letter("Please hack our enemie's system.");

$first_employee->salary(200);

print "We are ", $first_employee->employer ," the new salary of our dear $first_employee->{forename} is ", $first_employee->raise->salary, "\n"; 

print"\n_____________________________________________________________________\n\n\n\n"; 
$first_employee->print_card("We're all living in each other's paranoia.");
print"\n_____________________________________________________________________\n"; 

