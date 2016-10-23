
# 1st input
$A[0] = 1;  $B[0] = 4;
$A[1] = 3;  $B[1] = 2;
$A[2] = 2;  $B[2] = 5;
$A[3] = 1;  $B[3] = 3; 
            $B[4] = 2;

# 2nd input
#$A[0] = 2; $B[0] = 3;
#$A[1] = 1; $B[1] = 3;


my %in_array2 = map { $_ => 1 } @A;

my @array3 = grep { $in_array2{$_} } @B;

@array4 = sort @array3;


if(scalar(@array4) > 1) { print $array4[0]; }
else { print "-1"; } 
