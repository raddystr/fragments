!/usr/bin/perl -wT

use strict; 

#The basic data types in perl are scalars, arrays, hashes, file handles, type globs, and subroutines.

my $long_string_scalar = <<EOT;
Thi string 
can be on multiple 
liens
EOT

print"$long_string_scalar\n";


#Using subroutine with reference ;)

sub print_msg  {
        my ($msg) = @_; 
        print "MSG:$msg\n"; 
        return();
}
my $ref = \&print_msg;

print $ref->("Hello world!");

print $ref->("Ops I use it again :)))"); 

#Perlish switch-case alsol known as a dispatch table

$ref = { 
        'add'           =>sub{my ($val1, $val2 )=@_; return $val1 + $val2},
        'subtract'      =>sub{my ($val1, $val2 )=@_; return $val1 - $val2},
        'multiply'      =>sub{my ($val1, $val2 )=@_; return $val1 * $val2}
};

for my $op (qw(multiply add subtract)){
        my $val = $ref->{$op}->(4,3);
        print "Equals to: $val\n"; 
}

#with "ref" we see the type of refeference 


my @arr =qw (1 2 3 4);

print map{"current value doubled: $_*2\n"} @arr;

my @src  =qw(a b c);

my @scrap = splice(@arr, 4,3,@src);

print "@scrap\n";

#perlish hash printing

my %myhash = (
        radi=>'programmer',
        ivan=>'doctor',
        john=>'musician'
);

print map {"His name is $_ and he's $myhash{$_}.\n"} keys %myhash; #alsol can be make with values :)))

#making hash from two arrays 

my %hash;

my @array1 = ('a','b','c');

my @array2 = (1,2,3);

@hash{@array1} = @array2;

print "key of new hash is $_ and the corresponding value is $hash{$_}.\n" for sort keys %hash;

print map {"The key of new hash is $_ and the corresponding value is $hash{$_}.\n"} sort keys %hash;
my @array = sort keys %hash, sort values %hash;

print "@array\n";


