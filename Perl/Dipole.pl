#!/usr/bin/perl

#################################################################################################################
#				Thymine.pdb (Input file format)							#	
#	ATOM      1  N1  T       1       0.214   0.668   1.296  0.354						#
#	ATOM      2  C6  T       1       0.171  -0.052   2.470 -0.080						#
#	ATOM      3  C2  T       1       0.374   2.035   1.303  0.290						#
#	ATOM      4  O2  T       1       0.416   2.705   0.284 -0.654						#
#	ATOM      5  N3  T       1       0.483   2.592   2.553  0.313						#
#	ATOM      6  C4  T       1       0.449   1.933   3.767 -0.052						#
#	ATOM      7  O4  T       1       0.560   2.568   4.812 -0.616						#
#	ATOM      8  C5  T       1       0.279   0.500   3.685  0.141						#
#	ATOM      9  C5A T       1       0.231  -0.299   4.949  0.304						#
#														#
#														#
#################################################################################################################


$mypositivecharge=0; $mynegativecharge=0; $mynoofpositivecharge =0; $mynoofnegativecharge=0;

open(F1,$ARGV[0])|| die("Can't open file:".$ARGV[0]);
open(F2,">COM_".$ARGV[0])|| die("Can't open file:".$ARGV[0]);

while($line = <F1>){
		next if($line!=/^ATOM/);
    		($atom,$numbers,$atomtype,$notation,$one,$x,$y,$z,$charge) = split(/\s+/,$line);

if($charge > 0) {
                        $xcom1 += $charge * $x;
                        $ycom1 += $charge * $y;
                        $zcom1 += $charge * $z;
                        $div1 += $charge;
			$mynoofpositivecharge++;
			$mypositivecharge += $charge;
		}
else {
                        $xcom2 += $charge * $x;
                        $ycom2 += $charge * $y;
                        $zcom2 += $charge * $z;
                        $div2 += $charge;
			$mynoofnegativecharge++;
			$mynegativecharge += $charge;
			
     }
	}
close(F1);
	print "Total +ve charge =",$mypositivecharge,"\n";
	print "Total -ve charge =",$mynegativecharge,"\n";

	$xcom1 = $xcom1 / $div1;
        $ycom1 = $ycom1 / $div1;
        $zcom1 = $zcom1 / $div1;

	$xcom2 = $xcom2 / $div2;
        $ycom2 = $ycom2 / $div2;
        $zcom2 = $zcom2 / $div2;

	printf  "+ ve CO %-6s%5s %-5s%-5s %3d%12.3f%8.3f%8.3f\n",ATOM,1,"+ve",COM,1,$xcom1,$ycom1,$zcom1;
	printf  "- ve CO %-6s%5s %-5s%-5s %3d%12.3f%8.3f%8.3f\n",ATOM,2,"-ve",COM,1,$xcom2,$ycom2,$zcom2;

	$distance=(($xcom1 - $xcom2)**2) + (($ycom1- $ycom2)**2) + (($zcom1 - $zcom2)**2);
	$distance = sqrt($distance);

	$total_remaining_charge = $mypositivecharge - $mynegativecharge;

	print "charges susbtraction (r(+)-r(-)) = ",$total_remaining_charge ,"\n";
	print "Distance = ",$distance,"\n";
	$diploe_movement = $distance * $total_remaining_charge,"\n";
	print "Dipole movement = ",$diploe_movement,"\n";
