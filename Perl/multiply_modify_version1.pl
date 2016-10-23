#!/usr/bin/perl
use PDL;
use PDL::Matrix;
use PDL::MatrixOps; 


$cutoff=$ARGV[0];
open(F1,$ARGV[1]);
$k=0;

while(<F1>) {
		split(/\s+/);
		for ($i =0; $i < $cutoff; $i++) {
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

open(F7,$ARGV[7]);
@resInfo= ();
while(<F7>) {
                chomp;
		push (@resInfo,$_);
            }
close(F7);


@AoA = (
	 [1,2,3,4,5,6,7,8],
	 [1,2,3,4,5,6,7],
	 [1,2,3,4,5,6],
	 [1,2,3,4,5],
	 [1,2,3,4],
	 [1,2,3],
	 [1,2],
	 [2,3,4,5,6,7,8],
	 [2,3,4,5,6,7],
	 [2,3,4,5,6],
	 [2,3,4,5],
	 [2,3,4],
	 [2,3],
	 [2,4],
	 [3,4,5,6,7,8],
	 [3,4,5,6,7],
	 [3,4,5,6],
	 [3,4,5],
	 [3,4],
	 [3,5],
	 [3,6],
	 [4,5,6,7,8],
	 [4,5,6,7],
	 [4,5,6],
	 [4,5],
	 [5,6,7,8],
	 [5,6,7],
	 [5,6],
	 [6,7,8],
	 [6,7],
	 [7,8],
    );
%res1 = ();
%res2 = ();
%multi_hashes = ();
%Get_actual_res= ();
	
for ($i = 1; $i <= $ARGV[0]; $i++) {
				res1->{$i} = 0;
				res2->{$i} = 0;
				Get_actual_res->{$i} = $resInfo[$i-1];
				$rec = {};
				$multi_hashes{$i} = $rec;
				$value = $resInfo[$i-1];
				$rec->{$value} = 0;
				$rec->{$i} = 0;
				}

					$my_inverse  = PDL::Matrix->pdl([@inverse]);

for $g ( 0 .. $#AoA ) {
					$k=0;
					@combination = ();
					print "The combination here is: ";
					$comb=undef;
for $h ( 0 .. $#{$AoA[$g]} ) {
					print "$AoA[$g][$h]  ";
					$comb .= $AoA[$g][$h];
                			for ($i =0; $i < $cutoff; $i++) {
								$index = $AoA[$g][$h];
                                				$combination[$i][$k] = $eigen[$i][$index-1];
                                                			}
                				$k++;
        		      }

					 print "\n";
	$j=0;  @transform = ();

		sub array {
   					 my ($x, $y) = @_;
  					 map {[ (0) x $x ]} 1 .. $y
			   }


					 @transform= array $cutoff, $cutoff;
			
	while($j!=$k) {

                for ($m =0; $m < $cutoff; $m++) {
							$val=undef;
                for ($i =0; $i < $cutoff; $i++) {
								
							$val += $mean[$m][$i] * $combination[$i][$j];
						}
							$transform[$m][$j] = $val;
						}
			$j++;
		      }
	$k=0;
				
					$transformed = PDL::Matrix->pdl([@transform]);
					$back_transformation = $transformed x $my_inverse;
	
		 
		$j=0; @store= ();

		foreach $i (@sector) {
					push (@store,max($back_transformation->index($i)));
				     }
					@srt =sort @store;
					$max = $srt[scalar(@srt)-1];
					$min = $srt [scalar @store/2  ];

if((nelem(which($back_transformation > $min))) <= $ARGV[5]) {

					print "Low peak  \t$min \t", nelem(which($back_transformation > $min)),"\n";
					print "High peak  \t $max\t",nelem(which($back_transformation > $max)),"\n";
					print "maximum value in this combination is:\t",sprintf("%0.4f",max($back_transformation)),"\n";
							   
							 }

				
					$SortIndex = $back_transformation->flat->qsorti;
					$GettheCutoff=0;
					$residue=undef;
					@residueArray=(); @uniqueRes = ();
					
					for ( $get = $cutoff*$cutoff-1; $get >= 0; $get--) {
						$residue = int ($SortIndex->at($get,0) / $cutoff) + 1;
						$res1{$residue} += 1 if exists $res1{$residue};
						$multi_hashes{$residue}{$residue} += 1 if exists $multi_hashes{$residue}{$residue};
						push (@residueArray,$residue);
						last if($GettheCutoff==$ARGV[6]);
						$GettheCutoff++;
										           }
					sub uniq {
    							return keys %{{ map { $_ => 1 } @_ }};
						 }
						
					@uniqueRes = uniq(@residueArray);
						

					for $line (@uniqueRes) {
						$res2{$line} += 1 if exists $res2{$line}; 
						$value = $Get_actual_res{$line};
						$multi_hashes{$line}{$value} += 1 if exists $multi_hashes{$line}{$value};
					}
						
}

	print "\nGRADES IN DESCENDING NUMERIC ORDER:\n";
foreach $key (sort hashValueDescendingNum (keys(%res2))){
	
   print "\t$res1{$key} \t $res2{$key} \t\t $key\n" if($res1{$key} != 0);
}

sub hashValueDescendingNum {
   $res2{$b} <=> $res2{$a};
}
for $family ( keys %multi_hashes ) {
    print "$family => { \n ";
    for $role ( keys %{ $multi_hashes{$family} } ) {
         print "\t$role	=>	$multi_hashes{$family}{$role},\n";
    }
	print "},\n";
    print "\n";
}
