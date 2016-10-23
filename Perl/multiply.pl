#!/usr/bin/perl
use PDL::LiteF;
use PDL;
use PDL::Matrix;


$cutoff=$ARGV[0];
open(F1,$ARGV[1]);
$k=0;

while(<F1>) {
		split(/\s+/);
		for ($i =0; $i < $cutoff; $i++) 
		{
			$mean[$k][$i] = $_[$i];
		}
		$k++;
	}
close(F1);

$k=0;
open(F2,$ARGV[2]);
while(<F2>) {
                split(/\s+/);
                for ($i =0; $i < $cutoff; $i++)	{
                   	 	$eigen[$k][$i] = $_[$i];
             		}
                $k++;
        }
close(F2);


$k=0;
open(F3,$ARGV[3]);
while(<F3>) {
                split(/\s+/);
                for ($i =0; $i < $cutoff; $i++) {
                    		$inverse[$k][$i] = $_[$i];
                				}
                $k++;
        }
close(F3);


	
open(F4,$ARGV[4]);
@sector = ();
while(<F4>) {
		chomp;
		push(@sector,$_-1);
	    }
close(F4);

@AoA = (
	 [1],
	 [2],
	 [3],
	 [4],
	 [5],
	 [6],
	 [1,2,3,4,5,6],
	 [1,2,3,4,5],
	 [1,2,3,4],
	 [1,2,3],
	 [1,2],
	 [2,3,4,5,6],
	 [2,3,4,5],
	 [2,3,4],
	 [2,3],
	 [3,4,5,6],
	 [3,4,5],
	 [3,4],
	 [3,4,5],
	 [3,5],
	 [4,5],
    );

for $g ( 0 .. $#AoA ) {
					$k=0;
					@combination = ();
					print "The combination here is: ";
        for $h ( 0 .. $#{$AoA[$g]} ) {
					print "$AoA[$g][$h]  ";
                			for ($i =0; $i < $cutoff; $i++) {
								$index = $AoA[$g][$h];
                                				$combination[$i][$k] = $eigen[$i][$index-1];
                                                			}
                				$k++;
        			      }

	print "\n";
	$j=0;  @transform = ();
	while($j!=$k) {
                for ($m =0; $m < $cutoff; $m++) {
							$val=undef;
                for ($i =0; $i < $cutoff; $i++) {
								
							$val += $mean[$m][$i] * $combination[$i][$j];
						}
							$transform[$m][$j] = $val,"\n";
						}
			$j++;
		      }
	$k=0;
	
for ($i = 0; $i < $cutoff; $i++) {
		for ($k = $j; $k < $cutoff; $k++) {
							$transform[$i][$k] = 0;		
						  }
				  }
$j=0;
@back_transform = ();
while($j!=$cutoff) {
                for ($m =0; $m < $cutoff; $m++) {
                                                        $val=undef;
							
                for ($i =0; $i < $cutoff; $i++) {
                                                        $val += $transform[$m][$i] * $inverse[$i][$j];
                                                }
							$back_transform[$m][$j] = $val;
                                                }
                        $j++;
                   }

$max=0;
$max2=undef;
$min=100;
$countH=0;
$countL=0;
@store= ();
		#for ($i =0; $i < $cutoff; $i++) {
		foreach $i (@sector) {
							$max1=undef;
			for ($j =0; $j < $cutoff; $j++) {
					#$max=$back_transform[$i][$j] if($max < $back_transform[$i][$j]);
					#$max=$back_transform[$i][$j] if($max < $back_transform[$i][$j]);
					#$max = $back_transform[$j][$i];
					$max1 = $back_transform[$j][$i] if($max1 < $back_transform[$j][$i]);
					$max2 = $back_transform[$j][$i] if($max2 < $back_transform[$j][$i]);
					#print "$back_transform[$j][$i]\t";
							}
					push(@store,$max1);
					#print "$max1\n";
					}
					@srt =sort @store;
					$min = $srt [scalar @store/2 - 2 ];
			#		print @store;
		for ($i =0; $i < $cutoff; $i++) {
			for ($j =0; $j < $cutoff; $j++) {
						$max=$back_transform[$i][$j] if($max < $back_transform[$i][$j]);
						 $countH++ if($max2 < $back_transform[$i][$j]);
						 $countL++ if($min < $back_transform[$i][$j]);
							}
						}

		print "maximum value in this combination is: $max\n";
		print "High peak  $max2 $countH\n";
		print "Low peak $min $countL\n";
}
