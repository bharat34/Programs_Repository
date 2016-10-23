@DD_G=();

open(F1,$ARGV[0]);
				@DELTA1 = ();
				@SD1 = ();
				@DIR = ();

while(<F1>) {
		
		chomp;
		$dir=$_;	
		if ( -d $_) { 
			if ( -e $_."/FINAL_RESULTS_MMPBSA.dat" ) {
				@DELTA = ();
				@SD = ();
				open(F2,$_."/FINAL_RESULTS_MMPBSA.dat");
					while(<F2>) {
						
					if(/^DELTA TOTAL/) { split(/\s+/,$_); push(@DIR,$dir); push(@DELTA,$_[2]); push(@DELTA1,$_[2]);  push(@SD1,$_[3]); push(@SD,$_[3]);}
						    }
					close(F2);
					#print $dir," ",substr($mutant,0,1),substr($mutant,1,length($mutant)-2)+2,substr($mutant,length($mutant)-1,1)," ",$DELTA[0]," ",$SD[0]," ",$DELTA[1]," ",$SD[1],"\n";
				
				open(F3,"FINAL_DECOMP_MMPBSA.dat");
				open(F4,$dir."/FINAL_DECOMP_MMPBSA.dat");
				open(F5,">deltadeltaG_".substr($dir,46,length($dir)-4)."FINAL_DECOMP_MMPBSA.dat");
				open(F6,">deltadeltaG_".substr($dir,46,length($dir)-4)."-.5kcal-FINAL_DECOMP_MMPBSA.dat");
				push(@DD_G,"deltadeltaG_".substr($dir,46,length($dir)-4)."FINAL_DECOMP_MMPBSA.dat");
				$count=0;
				while($line1=<F3> and $line2=<F4>) {
									$count++;
									next if($count<9);
									last if($line1=~/Sidechain/);
									@line1=split(/\,/,$line1);
									@line2=split(/\,/,$line2);
									#printf F5 "%s,%s,%8.3f\n",$line1[0],$line1[1],$line2[17]-$line1[17];
									printf F5 "%s,%8.3f\n",substr($line1[0],3,4),$line2[17]-$line1[17];
						if(abs($line2[17]-$line1[17]) > 0.5) { printf F6 "%s,%s,%8.3f\n",substr($line2[0],3,10),substr($line2[0],0,10),$line2[17]-$line1[17]; }
						                    }
				close(F3); close(F4); close(F5); close(F6);
									}
				}
	   }
close(F1);


for ($i=0; $i <scalar(@DELTA1); $i+=2) { 
					#printf  "%-6s%5s %-5s%-5s %3d%12.3f%8.3f%8.3f\n",ATOM,1,"+ve",COM,1,$xcom1,$ycom1,$zcom1;
					#printf "%s%8.3f%8.3f%8.3f%8.3f\n",$DIR[$i],$DELTA1[scalar(@DATA1)-2]-$DELTA1[$i],abs($SD1[scalar(@SD1)-2]-$SD1[$i]),$DELTA1[scalar(@DATA1)-1]-$DELTA1[$i+1],abs($SD1[scalar(@SD1)-1]-$SD1[$i+1]);
					printf "%s%8.3f%8.3f%8.3f%8.3f\n",$DIR[$i],$DELTA1[$i]-$DELTA1[0],(abs($SD1[0]-$SD1[$i])),$DELTA1[$i+1]-$DELTA1[1],abs($SD1[1]-$SD1[$i+1]);
					}


foreach $line(@DD_G) {
			chomp($line);

			@ddg=();
			open(F2,$line);
			while($line1=<F2>) {
						split(/\s+/,$line1);
						push(@ddg,abs($_[2]));
					   }
			close(F2);

			open(F1,"MutS_deltaG-deltaG.pdb");
			open(F3,">".substr($line,0,length($line)-4).".pdb");
			while(<F1>) {
					split(/\s+/,$_);
					printf F3 "%-6s%5s %-3s%5s %5d%12.3f%8.3f%8.3f%7.2f\n",$_[0],$_[1],$_[2],$_[3],$_[4],$_[5],$_[6],$_[7],$ddg[$_[4]];
				    }
			close(F1);
			close(F3);
			}
