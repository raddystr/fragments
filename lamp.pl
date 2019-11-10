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
