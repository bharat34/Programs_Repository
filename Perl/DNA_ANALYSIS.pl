
open(F1,$ARGV[0]);
$filename=$ARGV[1];
chomp($filename);

@FREQ=();
		$a=0; $b=0; $index=0; 
		for($i=0; $i<=180; $i+=0.10) {
						 $FREQ[$b][$a] = $i;
						 $b++; $index++;
					     }
		
	for ($c=0; $c <= $index; $c++) {
for ($d=1; $d <= 23; $d++) {
					$FREQ[$c][$d]=0.0;
				  }
			  }


		



@TOTAL=();
open(F1,$ARGV[0]);
while(<F1>) {
                chomp;
		$a++;
		@index=split(/\//,$_);

		if(-s $_."/DNA/".$filename)	{
		
		$Mutation .= "Angle ".@index[scalar(@index)-1]." ";
                $Mutation .= @index[scalar(@index)-1]." ";

			
			open(F2,$_."/DNA/".$filename);
				$total=undef;
			while($line=<F2>) {
				@DATA=split(/\s+/,$line);
				for($i=0; $i<$index; $i++) {
						if($FREQ[$i][0] < $DATA[1] and $FREQ[$i+1][0] > $DATA[1]) {
										$FREQ[$i][$a] = $DATA[14];
										$total+=$DATA[14];
												          }
								  }
					  }
										push(@total,$total);

			close(F2);
						}
	}
close(F1);


open(F2,">ALL-".$ARGV[0]);
print F2 $Mutation,"\n";
	for ($c=0; $c <= $i; $c++) {
for ($d=2; $d <=$a; $d++) {
					print F2 $FREQ[$c][0]," ",$FREQ[$c][1]/$total[0]," ",$FREQ[$c][$d]/$total[$d-1]," ";
			  }
				print F2 "\n";	
			  }
close(F2);
