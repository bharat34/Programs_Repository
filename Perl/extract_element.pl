
#!/usr/bin/perl

open(F1,$ARGV[0]);
@val=<F1>;
chomp(@val);
close(F1);


open(F2,$ARGV[1]);
	while(<F2>)
	{
		@d=split(/\s+/,$_);
		shift(@d);
		push @data, [ @d ];
	}
	close(F2);


for ( $i = 0; $i < scalar(@val); $i++) 
{
#	print $val[$i]0,"\n";
	$m = $val[$i] - 1;
	for ( $j = 0; $j < scalar(@val); $j++) 
	{
		$n = $val[$j] - 2 ;
	if($val[$j]-20==38 and $val[$i]-20 == 13) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==48 and $val[$i]-20 == 13) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==26 and $val[$i]-20 == 14) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==34 and $val[$i]-20 == 14) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==38 and $val[$i]-20 == 14) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==54 and $val[$i]-20 == 14) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==48 and $val[$i]-20 == 15) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==54 and $val[$i]-20 == 15) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==17 and $val[$i]-20 == 16) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==26 and $val[$i]-20 == 16) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==72 and $val[$i]-20 == 16) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==82 and $val[$i]-20 == 16) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==16 and $val[$i]-20 == 17) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==68 and $val[$i]-20 == 17) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==55 and $val[$i]-20 == 17) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==48 and $val[$i]-20 == 21) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==14 and $val[$i]-20 == 26) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==34 and $val[$i]-20 == 26) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==16 and $val[$i]-20 == 26) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==14 and $val[$i]-20 == 34) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==26 and $val[$i]-20 == 34) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==68 and $val[$i]-20 == 34) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==14 and $val[$i]-20 == 38) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==68 and $val[$i]-20 == 38) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==13 and $val[$i]-20 == 38) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==48 and $val[$i]-20 == 38) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==48 and $val[$i]-20 == 44) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==48 and $val[$i]-20 == 45) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==54 and $val[$i]-20 == 52) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==56 and $val[$i]-20 == 52) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==53 and $val[$i]-20 == 52) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==52 and $val[$i]-20 == 53) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==14 and $val[$i]-20 == 54) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==52 and $val[$i]-20 == 54) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==15 and $val[$i]-20 == 54) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==68 and $val[$i]-20 == 55) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==17 and $val[$i]-20 == 55) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==52 and $val[$i]-20 == 56) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==68 and $val[$i]-20 == 57) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==17 and $val[$i]-20 == 68) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==55 and $val[$i]-20 == 68) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==57 and $val[$i]-20 == 68) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==38 and $val[$i]-20 == 68) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==34 and $val[$i]-20 == 68) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==74 and $val[$i]-20 == 72) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==72 and $val[$i]-20 == 74) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==14 and $val[$i]-20 == 79) { printf "%7.2f",$data[$m][$n]; }
	elsif($val[$j]-20==16 and $val[$i]-20 == 82) { printf "%7.2f",$data[$m][$n]; }
		#print $n,"\t";
	else {	 printf "%7.2f","";	 }
	#else {	 printf "%7.2f","$data[$m][$n]";	 }
	}
	print "\n";
}



