package Employee;
use lib 'path/to/Peson.pm';
use Person;
use strict;
use warnings; 

our @ISA=qw(Person);

sub employer{
	my $self = shift;
	my $data = shift;
	$self->{employer}= $data if defined $data;
	return $self->{employer};
}
sub position{
	my $self = shift;
	my $data = shift;
	$self->{position} = $data if defined $data;
	return $self->{position}; 
}

sub salary{
	my $self = shift;
	my $data = shift;
	$self->{salary} = $data if defined $data;
	return $self->{salary}; 
}

sub phone_number{
	my $self = shift; 
	my $data = shift;
	$self->{phone_number} = $data if defined $data;
	return- $self->{phone_number};
}

sub raise{
	my $self = shift;
	my $new_salary = $self->salary + 2000;
	$self->salary($new_salary);
	return $self;
}


sub _init{
	my $self = shift;
	my $employer = $self->employer || "unknown";
	unless(ref $employer){
		my $new_o = Person->new(surname=> $employer);
		$self->employer($new_o);
	}
	$self->SUPER::_init();
}

sub print_card{
	my $self = shift;
	my $name = $self->full_name;
	my $phone_number=$self->phone_number;
	my $employer = $self->employer;
	my $position = $self->position;
	my $motto = shift;
	print<<EOF;
	$employer
	$name
	$position
	$phone_number
	$motto

EOF

	return $self;
}
1;
