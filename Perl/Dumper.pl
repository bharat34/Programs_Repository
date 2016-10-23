
#!/usr/bin/env perl

use PDL;
use PDL::Matrix;
use PDL::MatrixOps;


#my @array_of_truth(5)(5) = (0) x 5 x 5;
#my @array_of_truth[5][5];
#print Dumper(\@array_of_truth);
#print @array_of_truth;

my @array_of_truth = ();
my @rray_of_truth = ();
  @rray_of_truth = (0) x 5;

		for ($i =0; $i < 5; $i++) {
				for ($j =0; $j < 5; $j++) {
							print $rray_of_truth[$i][$j]," ";
								}
				#			print "\n";
					}
#print @rray_of_truth;


@k[1..5] =0;
print @k;


sub array {
    my ($x, $y) = @_;
    map {[ (0) x $x ]} 1 .. $y
}
 
my @square1 = array 5, 5;
my @square2 = array 5, 5;

		for ($i =0; $i < 5; $i++) {
				for ($j =0; $j < 5; $j++) {
								$square1[$i][$j] = $i/10; 
								$square2[$i][$j] = $j/10;
							  }
					   }


#$A = PDL::Matrix->pdl([@square1]);
$A = pdl[@square1];
#$B = PDL::Matrix->pdl([@square2]);
$B = pdl[@square2];



print $A,"\n";
print $B,"\n";

$C = $A x $B;

print $C;
print "\n";

print $C->flat->qsort,"\n";
print $C->flat->qsorti,"\n";
$Sort = $C->flat->qsorti;
for ( $get = 5*5-1; $get >= 0; $get--) {
		$aa = int ($Sort->at($get,0) / 5);
                $bb =  ($Sort->at($get,0) % 5);
		print $Sort->at($get,0),"	",$C->at($aa,$bb),"\n";
	}

$xx = qsorti $C;
print $xx;
print $C->index($xx);

exit;
print $C->index(1),"\n";
print max($C->index(1)),"\n";
exit;

print "C\t",$C,"\n";
print qsort($C),"\n";
 $ix = qsorti ($C);
	print $C->index($ix);

print list $C;
exit;


$CC=$C->clump(2);
($row,$col)=one2nd($C, maximum_ind($CC));
print $C->at($row,$col);
$C->set($row,$col,0);
print $C->at($row,$col),"\n";
print $C->at(2,1);
