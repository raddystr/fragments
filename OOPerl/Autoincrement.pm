package Autoincrement;
use strict;
use warnings;

sub TIESCALAR{
	my $class = shift;
	my $real_data = 0;
	return bless \$real_data, $class;
}

sub FETCH {
	my $self = shift;
	return $$self++;
}
1;
