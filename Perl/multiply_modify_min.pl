#!/usr/bin/perl
use PDL;
use PDL::Matrix;
use PDL::MatrixOps; 

if ( scalar @ARGV != 8) {
			print "Incomplete arguments\n";
		print "perl multiply_modify.pl noOfaminoacids MeanMatrix EigenMatrix InverseMatrix FindtheAmioacidFile MaximmumNumbersOftillSearchto Howmanytopcorrelated\n";
			exit;
			}

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
%FindTheRes= ();
while(<F4>) {
		chomp;
		push(@sector,$_-1);
		FindTheRes->{$_-1} = 0;
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
%multi_hashes = ();
%Get_actual_res= ();
	
for ($i = 1; $i <= $ARGV[0]; $i++) {
					Get_actual_res->{$i} = $resInfo[$i-1];
					$rec = {};
					$multi_hashes{$i} = $rec;
					$value = $resInfo[$i-1];
					$rec->{$value} = 0;
					$rec->{$i} = 0;
				    }

foreach $key ((keys(%Get_actual_res))) {
   #print "\t$Get_actual_res{$key} \t\t $key\n";
					$my_inverse  = PDL::Matrix->pdl([@inverse]);
							}
		#exit;

for $g ( 0 .. $#AoA ) {
					$k=0;
					@combination = ();
					$combi=undef;
					$combi .= "The combination here is: ";
					$comb=undef;
for $h ( 0 .. $#{$AoA[$g]} ) {
					$combi .= "$AoA[$g][$h]  ";
					$comb .= $AoA[$g][$h];
                			for ($i =0; $i < $cutoff; $i++) {
								$index = $AoA[$g][$h];
                                				$combination[$i][$k] = $eigen[$i][$index-1];
                                                			}
                				$k++;
        		      }

					 $combi .= "\n";
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
					$bck_transformation = $transformed x $my_inverse;
					$back_transformation = transpose($bck_transformation);
					$back_transformation->set(0,0,0); 
					$back_transformation->set(0,1,0); 
		$o=0;$t=1;$th=2;
		for ( $in = 1; $in < $cutoff-1; $in++) {
							$back_transformation->set($in,$o,0);
							$back_transformation->set($in,$t,0);
							$back_transformation->set($in,$th,0);;
							$o++; $t++; $th++;
						       }
					$back_transformation->set($cutoff-1,$cutoff-2,0); 
					$back_transformation->set($cutoff-1,$cutoff-1,0); 
	
		 
		$j=0; @store= ();

		foreach $i (@sector) {
					push (@store,min($back_transformation->index($i)));
				     }
					@srt =sort @store;
					$max = $srt[scalar(@srt)-1];
					$min = $srt [scalar @store/2  ];

#if((nelem(which($back_transformation > $min))) <= $ARGV[5]) {
					
					print "$combi";
					print "Low peak  \t$min \t", nelem(which($back_transformation > $min)),"\n";
					print "High peak  \t $max\t",nelem(which($back_transformation > $max)),"\n";
					print "maximum value in this combination is:\t",sprintf("%0.4f",min($back_transformation)),"\n";
							   
							 

				
					$SortIndex = $back_transformation->flat->qsorti;
					$GettheCutoff=0;
					$residue=undef;
					@residueArray=(); @uniqueRes = ();
					
					for ( $get = $cutoff*$cutoff-1; $get >= 0; $get--) {
						$aa = int ($SortIndex->at($get,0) / $cutoff);
						$bb = int ($SortIndex->at($get,0) % $cutoff);
						#print $aa,"	",$bb,"\n";
						$multi_hashes{$bb}{$bb} += 1 if exists $multi_hashes{$bb}{$bb};
						$multi_hashes{$aa}{$aa} += 1 if exists $multi_hashes{$aa}{$aa};
						push (@residueArray,$bb);
						push (@residueArray,$aa);
						last if($GettheCutoff==$ARGV[6]);
						$GettheCutoff++;
										           }
					sub uniq {
    							return keys %{{ map { $_ => 1 } @_ }};
						 }
						
					@uniqueRes = uniq(@residueArray);

					for $line (@uniqueRes) {
						$value = $Get_actual_res{$line};
						$multi_hashes{$line}{$value} += 1 if exists $multi_hashes{$line}{$value};
					}
#							   }
}

				open(FW,">SectorNetwork");
				open(FK,">SelectedSectorNetwork");
for $family ( keys %multi_hashes ) {
				$value = $Get_actual_res{$family};	
if($multi_hashes{$family}{$value} != 0 or $multi_hashes{$family}{$family} != 0) {
				#print $value," ",$multi_hashes{$family}{$value}," ",$multi_hashes{$family}{$family},"\n";		
				print FW "Residue: => ",$family," Contacts => ",$multi_hashes{$family}{$value}," No of times => ",$multi_hashes{$family}{$family},"\n";		
if ( exists $FindTheRes{$family}) {	

				print FK "Pdbid: => ",$value+1," Residue: => ",$family+1," Contacts => ",$multi_hashes{$family}{$value}," No of times => ",$multi_hashes{$family}{$family},"\n";		
				 }
				}
		     	      	   }
				close(FW);
				close(FK);

			 print " \nFinal output file is: SectorNetwork \n";
			 print "Final output file is: SectorNetwork_Contacts_Sorted \n";
			 print "Final output file is: SectorNetwork_Max_Score\n";
			 system ("sort -n -r +5 -6 SectorNetwork > SectorNetwork_Contacts_Sorted");
			 system ("sort -n -r +10 -11 SectorNetwork > SectorNetwork_Max_Score");
