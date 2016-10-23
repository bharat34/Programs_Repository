
#!/usr/bin/perl
use strict;
use warnings;
use PDL; # perl data language enables matrix multiplication
use Inline::Files; #multiple virtual files inside code

my @AoA_A = make_matrix("ARRAY_A"); #read in 2D array
my @AoA_B = make_matrix("ARRAY_B");

my $a = pdl [ @AoA_A ]; #Construct new pdl object
my $b = pdl [ @AoA_B ];
my $c = $a x $b;  # x overload
print "matrix a", $a;
print "matrix b", $b;
print "matrix c",$c;

sub make_matrix {
    my $source = shift;
    my @AoA;
    while (<$source>){
        my @tmp = split;
        push @AoA, [ @tmp ];
    }
    return @AoA;  
}


__ARRAY_A__
1 2 2 4
4 5 6 6
__ARRAY_B__
1 2
2 3
1 2
2 3
