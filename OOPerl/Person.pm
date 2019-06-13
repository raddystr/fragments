#!/usr/local/bin/perl 
package Person;
use strict;
use warnings;

my @Everyone; 

###Constructor 
sub new  {
	my $class = shift;
	my $self = {@_};
	bless($self, $class);
	$self->_init; 
	return $self;
}

#COUNT OF OBJECTS
sub citizen_counter{
	scalar @Everyone; 
}




###Method
sub presentation{
	my $self = shift;
	return "This person name is ", $self->{forename}," ",$self->{surname},", he lives in ", $self->{adress}, " and he is ",$self->{occupation}, ". He is ", $self->{age}, " years old";
}
 
###Get-Set method 
sub adress{
	my $self=shift;
	my $data = shift;
	$self->{adress} = $data if defined $data;
	return $self->{adress}; 

}

####add class atribute
sub age{
	my $self = shift;
	my $data = shift;
	$self->{age} = $data if defined $data;
	return $self->{age}; 
}

sub forename{
	my $self = shift;
	my $data = shift;
	$self->{forename} = $data if defined $data;
	return $self->{forename}; 
}

sub surname{
	my $self = shift;
	my $data = shift;
	$self->{surname} = $data if defined $data; 
	return $self->{surname}; 
}

##################

####_INIT ARRAY WITH OBJECTS
sub everyone{
	@Everyone; 
}



###CONCATINAITING METHOD FORENAME + SURNAME
sub full_name{
	my $self = shift;
	return $self->forename." ".$self->surname;
}


#####PRIVATE METHOD

sub _init{
	my $self=shift;
	push @Everyone, $self;
}



###Work method

sub print_letter{
 	my $self = shift;
	my $name  =$self->full_name;
 	my $adress = $self->adress;
	my $forename = $self->forename;
	my $body = shift;
	
	my @date = (localtime)[3, 4,5];
	$date[1]++;
	$date[2] +=1900;
	my $date=join "/", @date;

	print<<EOF;
	
	$name

	$adress

	$date

	Dear $forename,

	$body

	Yours faithfully,
	

EOF
	return $self;
}

1; 
