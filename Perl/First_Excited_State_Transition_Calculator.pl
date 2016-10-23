#!/usr/bin/perl


open(F1,$ARGV[0])|| die("Can't open file:".$ARGV[0]);
$flag=0; $flag2=0; $first_zero = 0; $count = 0; @ElectronPop1; @ElectronPop2; $MO_count=0; @atomtype;

while($line = <F1>){
			if($line=~/MO number/) { 
						 $line = <F1>;
						 $flag=1;
						 $MO_count++;
					       }
			last if($MO_count>1);
			last if($line=~/Population Tables/);
			next if($flag!=1);


			if($flag2==0) { 
					@col = split(/\s+/,$line);
					for ($i = 0; $i < scalar(@col); $i++){
										$first_zero = $i if($col[$i]=~/(0)/);
										last if($first_zero!=0);
							    		     }
					$flag2=1;
					$line = <F1>;
					$line = <F1>;
					$line = <F1>;
					$first_zero += 3;
					$flag2=1;	
				     }
				
			 
			@col = split(/\s+/,$line);
				
					for ($i = 3; $i < scalar(@col); $i++){
										last if ($i==$first_zero);
										$ElectronPop1[$count] += ( 2 * ( $col[$i] * $col[$i])) if($i != $first_zero-1);
										$ElectronPop2[$count] += ( 2 * ( $col[$i] * $col[$i])) if($i < $first_zero-2);
										$ElectronPop2[$count] += ( 1 * ( $col[$i] * $col[$i])) if($i==$first_zero-2 or $i==$first_zero-1);
									     }
				$atomtype[$count] = $col[2];
				$count++;
		   }
close(F1);
				print "Population Tables\n";
				print "~~~~~~~~~~~~~~~~~\n";
				print "Atoms\n";
				print " #  Symbol\tElectronPop.\tNetCharge\tFirst_Excited_ElectronPop.\tFirst_Excited_NetCharge\n";
				for ($i = 0; $i < scalar(@ElectronPop1); $i++){

						printf "%-6s%5s %12.5f%17.7f%18.5f%30.5f\n",$i+1,$atomtype[$i],$ElectronPop1[$i],($atomtype[$i] eq "N3") ? 2 - $ElectronPop1[$i] : 1 - $ElectronPop1[$i],$ElectronPop2[$i],($atomtype[$i] eq "N3") ? 2 - $ElectronPop2[$i] : 1 - $ElectronPop2[$i];

					      			              }
