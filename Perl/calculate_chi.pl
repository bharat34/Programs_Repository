
$prmtop=$ARGV[0];
$mdcrd=$ARGV[1];
$start=$ARGV[2];
$end=$ARGV[3];
$dir=$ARGV[4];

chomp($dir);

if(scalar(@ARGV) != 6) { print "\t\t\t perl calculate_chi.pl prmtop mdcrd start end dir\n\n"; }

		system("~/stride/stride ".$dir."/1NNE-dna-atp-mg_min1.pdb -q > ".$dir."/fasta.seq");
open(F1,"fasta.seq");
$_=<F1>;
$sequence=undef;
while(<F1>) {
		chomp;
		$sequence .= $_;
	    }
close(F1);


open(F1,">".$start."_".$end."-ALL-Sidechain-Angle.in");
system("mkdir Side-Chain");
print F1 "trajin ".$dir."/".$mdcrd." 1 last 1\n\n";
for($i=$start; $i <= $end; $i++) {
					#print substr($sequence,$i-1,1)," $i\n"; 
					print F1 "\n";
					if(substr($sequence,$i-1,1) eq 'C') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@SG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@SG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
									       }
					elsif(substr($sequence,$i-1,1) eq 'D') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@OD1 out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'E') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@CD out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
								print F1 "dihedral ".$i."chi3 :$i\@CB :$i\@CG :$i\@CD :$i\@OE1 out $dir\/Side-Chain\/".$i."_ALL_chi3.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'F') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@CD1 out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'H') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@ND1 out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'I') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@CD out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'K') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@CD out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
								print F1 "dihedral ".$i."chi3 :$i\@CB :$i\@CG :$i\@CD :$i\@CE out $dir\/Side-Chain\/".$i."_ALL_chi3.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'L') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@CD1 out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'M') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@SD out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
								print F1 "dihedral ".$i."chi3 :$i\@CB :$i\@CG :$i\@SD :$i\@CE out $dir\/Side-Chain\/".$i."_ALL_chi3.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'N') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@OD1 out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'P') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@CD out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'Q') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@CD out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
								print F1 "dihedral ".$i."chi3 :$i\@CB :$i\@CG :$i\@CD :$i\@OE1 out $dir\/Side-Chain\/".$i."_ALL_chi3.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'R') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@CD out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
								print F1 "dihedral ".$i."chi3 :$i\@CB :$i\@CG :$i\@CD :$i\@NE out $dir\/Side-Chain\/".$i."_ALL_chi3.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'S') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@OG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'T') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@OG1 out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'V') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG1 out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'W') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@CD1 out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
										}
					elsif(substr($sequence,$i-1,1) eq 'Y') { 
								print F1 "dihedral ".$i."chi1 :$i\@N :$i\@CA :$i\@CB :$i\@CG out $dir\/Side-Chain\/".$i."_ALL_chi1.dat\n"; 
								print F1 "dihedral ".$i."chi2 :$i\@CA :$i\@CB :$i\@CG :$i\@CD1 out $dir\/Side-Chain\/".$i."_ALL_chi2.dat\n"; 
										}
				 }

close(F1);

system("ptraj $prmtop < ".$start."_".$end."-ALL-Sidechain-Angle.in");
