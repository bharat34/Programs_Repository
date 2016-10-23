open(F1,$ARGV[0]);
@DATA1=();
$i=0;
$j=0;
while(<F1>) {
		chomp;
		@index=split(/\//,$_);
		@lines=();
		if(-s $_."/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns-1D-Backbone-rmsd-ref.dat") {
		$Mutation .= "Time ".@index[scalar(@index)-1]." ";
		#$Mutation .= @index[scalar(@index)-1]." ";
			open(F2,$_."/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns-1D-Backbone-rmsd-ref.dat");
			$line=<F2>;
			while($line=<F2>) {	
						chomp;
						(undef,$c,$d)=split(/\s+/,$line);
						$DATA1[$j][$i]=$c;
						$DATA1[$j][$i+1]=$d;
						$j++;
						$k=$j;
					  }
						$j=0;
						$i+=2;
		close(F2);

													 }
		}

close(F1);

open(F3,">ALL-Combine-combi_1_15ns-1D-Backbone-rmsd-ref.dat");
#print F3 substr($Mutation,34,length($Mutation)),"\n";
print F3 $Mutation,"\n";
for($b=0; $b <=$k; $b++) {
			#		print F3 $DATA1[$b][0]," ",$DATA1[$b][1]," ";
	for($a=3; $a <=$i; $a+=2) {
					printf F3 "%-8.3f%8.3f\t",$DATA1[$b][0]/500,abs($DATA1[$b][1]-$DATA1[$b][$a]);
					#print F3 $DATA1[$b][0]/500," ",$DATA1[$b][1]," ";
					#print F3 $DATA1[$b][$a]," ";
					#print $DATA1[$b][$a]," ";
				}
					print F3 "\n";
#print $Mutation,"\n";
for($b=0; $b <=$k; $b++) {
			#		print F3 $DATA1[$b][0]," ",$DATA1[$b][1]," ";
	for($a=3; $a <=$i; $a+=2) {
					printf F3 "%-8.3f%8.3f\t",$DATA1[$b][0]/500,abs($DATA1[$b][1]-$DATA1[$b][$a]);
					#print F3 $DATA1[$b][0]/500," ",$DATA1[$b][1]," ";
					#print F3 $DATA1[$b][$a]," ";
					#print $DATA1[$b][$a]," ";
				}
					print F3 "\n";
					#print "\n";
				}
close(F3);


open(F1,$ARGV[0]);
@DATA1=();
$i=0; $a=0; $Mutation=undef;
$j=0; $b=0; $c=undef; $d=undef; $k=undef;
while(<F1>) {
		chomp;
		@index=split(/\//,$_);
		@lines=();
		if(-s $_."/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns-1D-SideChain-rmsd.dat") {
		$Mutation .= "Time ".@index[scalar(@index)-1]." ";
		#$Mutation .= @index[scalar(@index)-1]." ";
			open(F2,$_."/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns-1D-SideChain-rmsd.dat");
			$line=<F2>;
			while($line=<F2>) {	
						chomp;
						(undef,$c,$d)=split(/\s+/,$line);
						$DATA1[$j][$i]=$c;
						$DATA1[$j][$i+1]=$d;
						$j++;
						$k=$j;
					  }
						$j=0;
						$i+=2;
		close(F2);

													 }
		}

close(F1);

open(F3,">ALL-Combine-combi_1_15ns-1D-SideChain-rmsd-ref.dat");
#print F3 substr($Mutation,34,length($Mutation)),"\n";
print F3 $Mutation,"\n";
for($b=0; $b <=$k; $b++) {
			#		print F3 $DATA1[$b][0]," ",$DATA1[$b][1]," ";
	for($a=3; $a <=$i; $a+=2) {
					printf F3 "%-8.3f%8.3f\t",$DATA1[$b][0]/500,abs($DATA1[$b][1]-$DATA1[$b][$a]);
				#	print F3 $DATA1[$b][0]/500," ",$DATA1[$b][1]," ";
				#	print F3 $DATA1[$b][$a]," ";
				}
					print F3 "\n";
				}
close(F3);
open(F1,$ARGV[0]);
@DATA1=();
$i=0; $a=0; $Mutation=undef;
$j=0; $b=0; $c=undef; $d=undef; $k=undef;
while(<F1>) {
		chomp;
		@index=split(/\//,$_);
		@lines=();
		if(-s $_."/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns-Bfactor.dat") {
		$Mutation .= "Time ".@index[scalar(@index)-1]." ";
		#$Mutation .= @index[scalar(@index)-1]." ";
			open(F2,$_."/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns-Bfactor.dat");
			$line=<F2>;
			while($line=<F2>) {	
						chomp($line);
						($c,$d)=split(/\s+/,$line);
						$DATA1[$j][$i]=substr($line,0,8);
						$DATA1[$j][$i+1]=substr($line,10,31);
						$j++;
						$k=$j;
					  }
						$j=0;
						$i+=2;
		close(F2);

													 }
		}

close(F1);

open(F3,">ALL-Combine-combi_1_15ns-1D-Bfactor.dat");
#print F3 substr($Mutation,34,length($Mutation)),"\n";
print F3 $Mutation,"\n";
for($b=0; $b <=$k; $b++) {
	for($a=3; $a <=$i; $a+=2) {
					#print F3 $DATA1[$b][$a]," ";
					#print F3 $DATA1[$b][0]/500," ",$DATA1[$b][1]," ";
					#print F3 $DATA1[$b][$a]," ";
					#print F3 $DATA1[$b][0]/500," ",abs($DATA1[$b][1]-$DATA1[$b][$a])," ";
					printf F3 "%-8.3f%8.3f\t",$DATA1[$b][0]/500,abs($DATA1[$b][1]-$DATA1[$b][$a]);
				}
					print F3 "\n";
				}
close(F3);

open(F1,$ARGV[0]);
@DATA1=();
$i=0; $a=0; $Mutation=undef;
$j=0; $b=0; $c=undef; $d=undef; $k=undef;
while(<F1>) {
		chomp;
		@index=split(/\//,$_);
		@lines=();
		if(-s $_."/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns-per-res-RMSD.dat") {
		$Mutation .= "Time ".@index[scalar(@index)-1]." ";
		#$Mutation .= @index[scalar(@index)-1]." ";
			open(F2,$_."/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns-per-res-RMSD.dat");
			$line=<F2>;
			while($line=<F2>) {	
						chomp($line);
						$DATA1[$j][$i]=substr($line,0,6);
						$DATA1[$j][$i+1]=substr($line,17,7);
						$j++;
						$k=$j;
					  }
						$j=0;
						$i+=2;
		close(F2);

													 }
		}

close(F1);

open(F3,">ALL-Combine-combi_1_15ns-per-res-RMSD.dat");
#print F3 substr($Mutation,34,length($Mutation)),"\n";
print F3 $Mutation,"\n";
for($b=0; $b <=$k; $b++) {
					#print F3 $DATA1[$b][0]," ",$DATA1[$b][1]," ";
	for($a=3; $a <=$i; $a+=2) {
					#print F3 $DATA1[$b][0]/500," ",$DATA1[$b][1]," ";
					#print F3 $DATA1[$b][$a]," ";
					#print F3 $DATA1[$b][$a]," ";
					#print F3 $DATA1[$b][0]," ",abs($DATA1[$b][1]-$DATA1[$b][$a])," ";
					printf F3 "%-8.3f%8.3f\t",$DATA1[$b][0],abs($DATA1[$b][1]-$DATA1[$b][$a]);
				}
					print F3 "\n";
				}
close(F3);
open(F1,$ARGV[0]);
@DATA1=();
$i=0; $a=0; $Mutation=undef;
$j=0; $b=0; $c=undef; $d=undef; $k=undef;
while(<F1>) {
		chomp;
		@index=split(/\//,$_);
		@lines=();
		if(-s $_."/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns-per-res-RMSF.dat") {
		$Mutation .= "Time ".@index[scalar(@index)-1]." ";
		#$Mutation .= @index[scalar(@index)-1]." ";
			open(F2,$_."/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns-per-res-RMSF.dat");
			$line=<F2>;
			while($line=<F2>) {	
						chomp($line);
						$DATA1[$j][$i]=substr($line,0,6);
						$DATA1[$j][$i+1]=substr($line,14,7);
						#print $line," ",substr($line,0,6)," ",substr($line,14,7),"\n";
						$j++;
						$k=$j;
					  }
						$j=0;
						$i+=2;
		close(F2);

													 }
		}

close(F1);

open(F3,">ALL-Combine-combi_1_15ns-per-res-RMSF.dat");
#print F3 substr($Mutation,34,length($Mutation)),"\n";
print F3 $Mutation,"\n";
for($b=0; $b <=$k; $b++) {
					#print F3 $DATA1[$b][0]," ",$DATA1[$b][1]," ";
	for($a=3; $a <=$i; $a+=2) {
					#print F3 $DATA1[$b][0]/500," ",$DATA1[$b][1]," ";
					#print F3 $DATA1[$b][$a]," ";
					#print F3 $DATA1[$b][$a]," ";
					#print F3 $DATA1[$b][0]," ",abs($DATA1[$b][1]-$DATA1[$b][$a])," ";
					#printf F3 "%-8.3f%8.3f\t",$DATA1[$b][0]/500,abs($DATA1[$b][1]-$DATA1[$b][$a]);
					printf F3 "%-8.3f%8.3f\t",$DATA1[$b][0],abs($DATA1[$b][1]-$DATA1[$b][$a]);
				}
					print F3 "\n";
				}
}
close(F3);
