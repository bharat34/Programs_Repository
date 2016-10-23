#!/usr/bin/perl

$mypositivecharge=0; $mynegativecharge=0; $mynoofpositivecharge =0; $mynoofnegativecharge=0;

open(F1,$ARGV[0])|| die("Can't open file:".$ARGV[0]);
open(F2,">COM_".$ARGV[0])|| die("Can't open file:".$ARGV[0]);

while($line = <F1>){
		next if($line!=/^ATOM/);
    		($atom,$numbers,$atomtype,$notation,$one,$x,$y,$z,$charge) = split(/\s+/,$line);

if($charge > 0) {

if($atomtype  =~/C/g)
                        {
                        $xcom1 += 12 * $x;
                        $ycom1 += 12 * $y;
                        $zcom1 += 12 * $z;
                        $div1 += 12;
                        }
if($atomtype =~/N/g)
                        {
                        $xcom1 += 14 * $x;
                        $ycom1 += 14 * $y;
                        $zcom1 += 14 * $z;
                        $div1 += 14;
                        }
			$mynoofpositivecharge++;
			$mypositivecharge += $charge;
		}
else {
	if($atomtype  =~/C/g)
                        {
                        $xcom2 += 12 * $x;
                        $ycom2 += 12 * $y;
                        $zcom2 += 12 * $z;
                        $div2 += 12;
                        }
	if($atomtype =~/N/g)
                        {
                        $xcom2 += 14 * $x;
                        $ycom2 += 14 * $y;
                        $zcom2 += 14 * $z;
                        $div2 += 14;
                        }
	if($atomtype =~/O/g)
                                   {
                        $xcom2 += 16 * $x;
                        $ycom2 += 16 * $y;
                        $zcom2 += 16 * $z;
                        $div2 += 16;
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
