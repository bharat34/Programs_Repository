open(F1,$ARGV[0]);
@array1=();
$j=0;
while(<F1>) { 
		@data=split(/\s+/,$_);
		for ($i=0; $i < scalar(@data); $i++) { $array1[$i][$j]=$data[$i]; }
		$j++;
	    }
close(F1);

open(F1,$ARGV[1]);
@array2=();
$j=0;
while(<F1>) { 
		@data=split(/\s+/,$_);
		for ($i=0; $i < scalar(@data); $i++) { $array2[$i][$j]=$data[$i]; }
		$j++;
	    }
close(F1);


for ($a=0; $a<$j; $a++) {
	for ($b=0; $b<$i; $b++) { 
		#		print $array1[$a][$b]," ";
				}
		#		print "\n";
			}

#print "MD\n";
for ($a=0; $a<$j; $a++) {
	for ($b=0; $b<$i; $b++) { 
		#		print $array2[$a][$b]," ";
				}
		#		print "\n";
			}

for ($a=0; $a<$j; $a++) {
	for ($b=0; $b<$i; $b++) { 
				if($array1[$a][$b]==1 and $array2[$a][$b] ==1) { print "1 "; }
				else { print "0 ";}
				}
				print "\n";
			}

