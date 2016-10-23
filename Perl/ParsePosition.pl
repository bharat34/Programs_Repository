#!/usr/bin/perl
# This program takes the pfam msa as input remove position in MSA if there is one of the following e.q. .,-,small caps letter
#
#
open(F1,$ARGV[0])|| die("Can't open file:".$ARGV[0]);
@MSA=();
$i=0;
$j=0;

while(<F1>) {
		$j=0;
		($header,$fasta) = split(/\s+/,$_);
		 $MSA[$i][$j] = $header;
	for($j=1; $j <length($fasta); $j++) { $MSA[$i][$j]=substr($fasta,$j,1); }
		$i++;
	    }
close(F1);
@pos=();

for($c=0; $c < $j;$c++) { push(@pos,"no"); }

for ($a = 1; $a < $j; $a++) {
				$flag=0;
	for ($b = 1; $b < $i; $b++) {
		$flag=1 if($MSA[$b][$a]=~/[A-Z]/);
			#print $MSA[$b][$a],"\n";
				    }
		$pos[$a]="yes" if($flag==1);
		#print $a,"\n" if($flag==1);
			   }

open(F2,">new".$ARGV[0])|| die("Can't open file:".$ARGV[0]);

for ($a = 0; $a < $i; $a++) {
			print F2 $MSA[$a][0],"     ";
	for ($b = 1; $b < $j; $b++) {
			next if($pos[$b]=~/no/);
			print F2 $MSA[$a][$b];
				    }
			print F2 "\n";
			  }
close(F2);
