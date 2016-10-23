#!/usr/bin/perl
# This programs reads the pdb format file to calculate the center of the mass

$mypositivecharge=0; $mynegativecharge=0; $mynoofpositivecharge =0; $mynoofnegativecharge=0;

open(F1,$ARGV[0])|| die("Can't open file:".$ARGV[0]);
open(F2,">COM_".$ARGV[0])|| die("Can't open file:".$ARGV[0]);

while($line = <F1>){
		next if($line!=/^ATOM/);
    		($atom,$numbers,$atomtype,$notation,$one,$x,$y,$z,$charge) = split(/\s+/,$line);

if($charge > 0) {

if($atomtype  =~/C/g)
                        {
                        $xcom1 += $charge * $x;
                        $ycom1 += $charge * $y;
                        $zcom1 += $charge * $z;
                        $div1 += $charge;
                        }
if($atomtype =~/N/g)
                        {
                        $xcom1 += $charge * $x;
                        $ycom1 += $charge * $y;
                        $zcom1 += $charge * $z;
                        $div1 += $charge;
                        }
			$mynoofpositivecharge++;
			$mypositivecharge += $charge;
		}
else {
	if($atomtype  =~/C/g)
                        {
                        $xcom2 += $charge * $x;
                        $ycom2 += $charge * $y;
                        $zcom2 += $charge * $z;
                        $div2 += $charge;
                        }
	if($atomtype =~/N/g)
                        {
                        $xcom2 += $charge * $x;
                        $ycom2 += $charge * $y;
                        $zcom2 += $charge * $z;
                        $div2 += $charge;
                        }
	if($atomtype =~/O/g)
                                   {
                        $xcom2 += $charge * $x;
                        $ycom2 += $charge * $y;
                        $zcom2 += $charge * $z;
                        $div2 += $charge;
                        }
	
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
	print $xcom2,"\n";
	$xcom2 = $xcom2 / $div2;
        $ycom2 = $ycom2 / $div2;
        $zcom2 = $zcom2 / $div2;
	printf  "%-6s%5s %-5s%-5s %3d%12.3f%8.3f%8.3f\n",ATOM,1,"+ve",COM,1,$xcom1,$ycom1,$zcom1;
	printf  "%-6s%5s %-5s%-5s %3d%12.3f%8.3f%8.3f\n",ATOM,2,"-ve",COM,1,$xcom2,$ycom2,$zcom2;

	$distance=(($xcom1 - $xcom2)**2) + (($ycom1- $ycom2)**2) + (($zcom1 - $zcom2)**2);
	$distance = sqrt($distance);
	$total_remaining_charge = $mypositivecharge - $mynegativecharge;
	print "After susbtraction = ",$total_remaining_charge ,"\n";
	print "Distance = ",$distance,"\n";
	$diploe_movement = $distance * $total_remaining_charge,"\n";
	print "Dipole movement = ",$diploe_movement,"\n";
