open(F1,$ARGV[0]);

$DomainA[1]=1;  $DomainA[2]=120;
$DomainA[3]=121;  $DomainA[4]=266;
$DomainA[5]=267;  $DomainA[6]=398;
$DomainA[7]=399;  $DomainA[8]=514;
$DomainA[9]=515;  $DomainA[10]=765;

$DomainB[1]=765+1;  $DomainB[2]=765+120;
$DomainB[3]=765+121;  $DomainB[4]=765+266;
$DomainB[5]=765+267;  $DomainB[6]=765+398;
$DomainB[7]=765+399;  $DomainB[8]=765+514;
$DomainB[9]=765+515;  $DomainB[10]=765+765;

while(<F1>) {
				chomp;
				@D=split(/\//,$_);
	for($i=1; $i < scalar(@DomainA); $i+=2) {
		#		print $DomainA[$i], " ",$DomainA[$i+1],"\n";
				open(F2,">DomainA-Wise-RMSD.in");
				print F2 "parm ",$_,"/1NNE-dna-atp-mg-Complex.prmtop\n";
				print F2 "reference ",$_,"/1NNE-dna-atp-mg-Complex.inpcrd\n";
				print F2 "trajin ",$_,"/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns.mdcrd.gz 1 l 10\n";
				print F2 "center :",$DomainA[$i],"-",$DomainA[$i+1]," mass origin\n";
				print F2 "image origin center familiar\n";
				print F2 "rms reference :",$DomainA[$i],"-",$DomainA[$i+1],"\@C,CA,N,P,O5',C5',C4',C3',O3',O mass out \/home\/blakhani\/Manju\/MUTS-FILES\/MUTS-Mutation\/Domain-Wise-RMSD\/",$D[scalar(@D)-1],"-Domain-",$DomainA[$i],"-",$DomainA[$i+1],"-ref-rmsd.dat\n";
				print F2 "rms first :",$DomainA[$i],"-",$DomainA[$i+1],"\@C,CA,N,P,O5',C5',C4',C3',O3',O mass out \/home\/blakhani\/Manju\/MUTS-FILES\/MUTS-Mutation\/Domain-Wise-RMSD\/",$D[scalar(@D)-1],"-",$DomainA[$i],"-Domain-",$DomainA[$i+1],"-first-rmsd.dat\n";
				print F2 "rms reference :",$DomainA[$i],"-",$DomainA[$i+1],"\&\!\@C,CA,N,P,O5',C5',C4',C3',O3',O mass out \/home\/blakhani\/Manju\/MUTS-FILES\/MUTS-Mutation\/Domain-Wise-RMSD\/",$D[scalar(@D)-1],"-",$DomainA[$i],"-Domain-",$DomainA[$i+1],"-SideChain-rmsd.dat\n";
				#print F2 "rms reference mass :",$DomainA[$i],"-",$DomainA[$i+1]," perres perresout dump.dat perresavg \/home\/blakhani\/Manju\/MUTS-FILES\/MUTS-Mutation\/Domain-Wise-RMSD\/",$D[scalar(@D)-1],"-",$DomainA[$i],"-Domain-",$DomainA[$i+1],"-Per-Res-rmsd.dat\n";
				#print F2 "atomicfluct :",$DomainA[$i],"-",$DomainA[$i+1]," byres out \/home\/blakhani\/Manju\/MUTS-FILES\/MUTS-Mutation\/Domain-Wise-RMSD\/",$D[scalar(@D)-1],"-Domain-",$DomainA[$i],"-",$DomainA[$i+1],"-Per-Res-rmsf.dat\n";
				close(F2);
				system("~/amber14/bin/cpptraj < DomainA-Wise-RMSD.in");
						}
				
	for($i=1; $i < scalar(@DomainB); $i+=2) {
		#		print $DomainB[$i], " ",$DomainB[$i+1],"\n";
				open(F2,">DomainB-Wise-RMSD.in");
				print F2 "parm ",$_,"/1NNE-dna-atp-mg-Complex.prmtop\n";
				print F2 "reference ",$_,"/1NNE-dna-atp-mg-Complex.inpcrd\n";
				print F2 "trajin ",$_,"/ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_15ns.mdcrd.gz 1 l 10\n";
				print F2 "center :",$DomainB[$i],"-",$DomainB[$i+1]," mass origin\n";
				print F2 "image origin center familiar\n";
				print F2 "rms reference :",$DomainB[$i],"-",$DomainB[$i+1],"\@C,CA,N,P,O5',C5',C4',C3',O3',O mass out \/home\/blakhani\/Manju\/MUTS-FILES\/MUTS-Mutation\/Domain-Wise-RMSD\/",$D[scalar(@D)-1],"-Domain-",$DomainB[$i],"-",$DomainB[$i+1],"-ref-rmsd.dat\n";
				print F2 "rms first :",$DomainB[$i],"-",$DomainB[$i+1],"\@C,CA,N,P,O5',C5',C4',C3',O3',O mass out \/home\/blakhani\/Manju\/MUTS-FILES\/MUTS-Mutation\/Domain-Wise-RMSD\/",$D[scalar(@D)-1],"-",$DomainB[$i],"-Domain-",$DomainB[$i+1],"-first-rmsd.dat\n";
				#print F2 "rms reference :",$DomainB[$i],"-",$DomainB[$i+1],"\&\!\@C,CA,N,P,O5',C5',C4',C3',O3',O mass out \/home\/blakhani\/Manju\/MUTS-FILES\/MUTS-Mutation\/Domain-Wise-RMSD\/",$D[scalar(@D)-1],"-",$DomainB[$i],"-Domain-",$DomainB[$i+1],"-SideChain-rmsd.dat\n";
				#print F2 "rms reference mass :",$DomainB[$i],"-",$DomainB[$i+1]," perres perresout dump.dat perresavg \/home\/blakhani\/Manju\/MUTS-FILES\/MUTS-Mutation\/Domain-Wise-RMSD\/",$D[scalar(@D)-1],"-",$DomainB[$i],"-Domain-",$DomainB[$i+1],"-Per-Res-rmsd.dat\n";
				#print F2 "atomicfluct :",$DomainB[$i],"-",$DomainB[$i+1]," byres out \/home\/blakhani\/Manju\/MUTS-FILES\/MUTS-Mutation\/Domain-Wise-RMSD\/",$D[scalar(@D)-1],"-Domain-",$DomainB[$i],"-",$DomainB[$i+1],"-Per-Res-rmsf.dat\n";
				close(F2);
				system("~/amber14/bin/cpptraj < DomainB-Wise-RMSD.in");
						}
		exit;
	    }
close(F1);
