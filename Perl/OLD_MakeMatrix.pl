#!/usr/bin/perl

@array = ();
open(F1,$ARGV[0]);
$_=<F1>;
while(<F1>) { 
		chomp;
		$_=~s/\(//g;
		$_=~s/\)//g;
		($a,$b)=split(/=/,$_);
		($c,$d)=split(/,/,$a);
		$c=~s/\s+//g;
		$d=~s/\s+//g;
		#print $c,"\t",$d,"\n";
		($e,$f)=split(/,/,$b);
		#print $e,"\t",$f,"\n";
		$array[$c-1][$d-1] = $e;
	  }
close(F1);

for($i = 0; $i <= $#array; $i++){
	   for($j = 0; $j <= $#{$array[0]} ; $j++){
	      print "$array[$i][$j] \t";
	   }
	   print "\n";
	}
