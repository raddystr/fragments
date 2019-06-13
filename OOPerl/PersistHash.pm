package PesristHash;
use strict;
use warnings;
use Tie::Hash;
our @ISA=qw(Tie::StdHash);

sub TIEHASH{
	my $class = shift;
	my %real_hash;
	my $file = shift;

	if(-e $file){

	open FH, $file or die $!;
	while(<FH>){
		chomp;
		my ($k, $v) = split /:/, $_,2;
		$real_hash{$k} =$v;
		}
	}
	$real_hash{___secret___} = $file;
	return bless \%real_hash, $class;

}

sub DESTROY{
	my $self = shift;
	my %real_hash = %$self;	
	my $file = $real_hash{___secret___};
	delete $real_hash{___secret___};

	open FH, ">file" or die $!;

	for(keys %real_hash){
		print FH $_, ":" ,$real_hash{$_}, "\n"; 
	}
	close FH; 
}
