open(F1,$ARGV[0]);
while(<F1>) {
		print $_;
		chomp;


          	open(F2,$_."/1NNE-crystal-2xATP+Mg-2x3H2O-gas.pdb");


		$mdcrd=undef;

                open(F3,">".$_."/1NNE-dna-atp-mg-Complex.pdb");
                open(F4,">".$_."/1NNE-dna-atp-mg-Protein.pdb");
                open(F5,">".$_."/1NNE-dna-atp-mg-ligand.pdb");
                while($PDB=<F2>) {
                                        split(/\s+/,$PDB);
                                        last if($_[4] > 1579);
                                        print F3 $PDB;

                                     if($_[4]!=1577) { print F4 $PDB; }
                                     elsif($_[4]==1577) { print F5 $PDB; }
                                }
                close(F2);
                close(F3);
                close(F4);
                close(F5);

		system("cp MM-PBSA_Input/mmpbsa_tleap.in MM-PBSA_Input/mmpbsa1.sh MM-PBSA_Input/mmpbsa1.in ".$_);
		system("tleap -s -f ".$_."/mmpbsa_tleap.in > ".$_."/mmpbsa_tleap.out");	

		print "Running script on $_ folder\n";
		print "Combining all the mdcrd into one stripped mdcrd file for $_ folder\n\n";
		print "writing cpptral tleap file for $_ folder\n\n";
		open(F6,">".$_."/combine.in");
		print F6 "#!/bin/bash\n";
		print F6 "#BSUB -q tinymem\n";
		print F6 "#BSUB -n 1\n";
		print F6 "#BSUB -J $_\n";
		print F6 "#BSUB -o out\n";
		print F6 "#BSUB -e err\n";
		print F6 "#BSUB -R \"rusage[mem=15144:tmslow=1]\"\n";

		
		print F6 "mkdir ANALYSIS\n";
		print F6 "~/amber14/bin/cpptraj <<EOF1 > cpptraj.out\n";
		print F6 "parm 1NNE-dna-atp-mg.prmtop\n";
		print F6 "reference 1NNE-dna-atp-mg.inpcrd\n\n";

                print F6 "# Transform .mdcrd.gz files  to origin defined by center-of-mass of MD cell\n";

		print F6 "center :1-1579 mass origin\n";
		print F6 "image origin center familiar\n\n";


		for($i=1; $i<=15; $i++) { 
				if(-s $_."/1NNE-dna-atp-mg_prod.".$i.".mdcrd.gz"){ 
									$j=$i;
									$mdcrd .= "1NNE-dna-atp-mg_prod.".$i.".mdcrd.gz ";
								print F6 "trajin 1NNE-dna-atp-mg_prod.".$i.".mdcrd.gz 1 500 1","\n";												}
					}
                print F6 "# Strip the water and chloride ions (minimal salt 6pti)\n\n";
                print F6 "strip :WAT\n";
                print F6 "strip :Cl-\n";
                print F6 "strip :K+\n";
                print F6 "strip :Na+\n\n";
                print F6 "average ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1-".$j."ns-avg1st.pdb pdb\n\n";
                print F6 "#output a combined trajectory file as 6pti_MD_combi_dry_noions.mdcrd.gz\n\n";
                print F6 "trajout ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns.mdcrd nobox\n\n";
                print F6 "EOF1\n\n";
		
		

		print F6 "#Backbone RMSD\n";
		print F6 "~/amber14/bin/cpptraj <<EOF2 >> cpptraj.out\n";
		print F6 "parm 1NNE-dna-atp-mg-Complex.prmtop\n";
                print F6 "reference 1NNE-dna-atp-mg-Complex.inpcrd\n";
                print F6 "center :1-1579 mass origin\n";
                print F6 "image origin center familiar\n";
                print F6 "trajin ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns.mdcrd nobox 1 last 1\n";
		print F6 "rms reference :1-1579\@C,CA,N,P,O5',C5',C4',C3',O3',O mass out ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-1D-Backbone-rmsd-ref.dat\n";
		print F6 "average ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-1D-Backbone-rmsd-ref.pdb\n";
		print F6 "rms first :1-1579\@C,CA,N,P,O5',C5',C4',C3',O3',O mass out ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-1D-Backbone-rmsd-avg.dat\n";
		print F6 "average ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-1D-Backbone-rmsd-avg.pdb\n";
		#print F6 "/home/blakhani/mdanalysis/gr_mdanalysis/1drms_mdanalysis.sh ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-1D-Backbone-rmsd-ref.dat ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-1D-Backbone-rmsd-avg.dat\n";
                print F6 "EOF2\n\n";


		print F6 "#Side-Chain RMSD\n";
		print F6 "~/amber14/bin/cpptraj <<EOF3 >> cpptraj.out\n";
		print F6 "parm 1NNE-dna-atp-mg-Complex.prmtop\n";
		print F6 "reference 1NNE-dna-atp-mg-Complex.inpcrd\n";
		print F6 "center :1-1579 mass origin\n";
		print F6 "image origin center familiar\n";
                print F6 "trajin ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns.mdcrd nobox 1 last 1\n";
		print F6 "rms reference :1-1579&!\@C,CA,N,P,O5',C5',C4',C3',O3',H,HA mass out ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-1D-SideChain-rmsd.dat\n";
		#print F6 "/home/blakhani/mdanalysis/gr_mdanalysis/1drms_mdanalysis.sh ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-1D-SideChain-rmsd.dat\n";
                print F6 "EOF3\n\n";

		print F6 "#B-Factor\n";
		print F6 "~/amber14/bin/cpptraj <<EOF4 >> cpptraj.out\n";
		print F6 "parm 1NNE-dna-atp-mg-Complex.prmtop\n";
		print F6 "reference 1NNE-dna-atp-mg-Complex.inpcrd\n";
		print F6 "center :1-1579 mass origin\n";
		print F6 "image origin center familiar\n";
                print F6 "trajin ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns.mdcrd nobox 1 last 1\n";
		print F6 "#B-Factor\n";
		print F6 "rms reference mass :1-1579\@C,CA,N,P,O5',C5',C4',C3',O3',O\n";
		print F6 "atomicfluct out ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-Bfactor.dat \@C,CA,N,P,O5',C5',C4',C3',O3',O byres bfactor\n";
		#print F6 "/home/blakhani/mdanalysis/gr_mdanalysis/Bfactor_mdanalysis.sh ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-Bfactor.dat\n";
                print F6 "EOF4\n\n";


		print F6 "#PerRes RMSD\n";
		print F6 "~/amber14/bin/cpptraj <<EOF5 >> cpptraj.out\n";
		print F6 "parm 1NNE-dna-atp-mg-Complex.prmtop\n";
		print F6 "reference 1NNE-dna-atp-mg-Complex.inpcrd\n";
		print F6 "center :1-1579 mass origin\n";
		print F6 "image origin center familiar\n";
                print F6 "trajin ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns.mdcrd nobox 1 last 1\n";
		print F6 "rms reference mass :1-1579 perres perresout ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi-per-res-rms_vs_time-1_".$j."ns.dat perresavg ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-per-res-RMSD.dat\n";
		#print F6 "/home/blakhani/mdanalysis/gr_mdanalysis/1drms_mdanalysis.sh ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-per-res-RMSD.dat\n";
                print F6 "EOF5\n\n";


		print F6 "#PerRes RMSF\n";
		print F6 "~/amber14/bin/cpptraj <<EOF6 >> cpptraj.out\n";
		print F6 "parm 1NNE-dna-atp-mg-Complex.prmtop\n";
		print F6 "reference 1NNE-dna-atp-mg-Complex.inpcrd\n";
		print F6 "center :1-1579 mass origin\n";
		print F6 "image origin center familiar\n";
                print F6 "trajin ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns.mdcrd nobox 1 last 1\n";
		print F6 "rms reference mass :1-1579\n";
		print F6 "atomicfluct :1-1579 byres out ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-per-res-RMSF.dat\n";
		#print F6 "/home/blakhani/mdanalysis/gr_mdanalysis/Bfactor_mdanalysis.sh ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns-per-res-RMSF.dat\n";
                print F6 "EOF6\n\n";
		
		
		open(F7,">>".$_."/mmpbsa1.sh");
		
		print F7 "\#BSUB \-J ".$_."\n";
		print F7 "/share/apps/openmpi/1.4.4+intel-12/bin/mpirun -np 16 ~/12cpu-only/bin/MMPBSA.py.MPI -O -i mmpbsa1.in -o FINAL_RESULTS_MMPBSA.dat -sp 1NNE-dna-atp-mg.prmtop -cp 1NNE-dna-atp-mg-Complex.prmtop -rp 1NNE-dna-atp-mg-Protein.prmtop -lp 1NNE-dna-atp-mg-ligand.prmtop -y ".$mdcrd."\n";
		print F7 "#~/12cpu-only/bin/MMPBSA.py -O -i mmpbsa1.in -o FINAL_RESULTS_MMPBSA.dat -sp 1NNE-dna-atp-mg.prmtop -cp 1NNE-dna-atp-mg-Complex.prmtop -rp 1NNE-dna-atp-mg-Protein.prmtop -lp 1NNE-dna-atp-mg-ligand.prmtop -y ".$mdcrd."\n";
		print F7 "rm -rf _MMPBSA_*\n";

		close(F7);
		
		
		
		close(F6);
	
		print F6 "~/amber14/bin/cpptraj <<EOF7 >> cpptraj.out\n";
        	print F6 "parm 1NNE-dna-atp-mg-Complex.prmtop\n";
        	print F6 "reference 1NNE-dna-atp-mg-Complex.inpcrd\n";
		print F6 "trajin ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns.mdcrd.gz nobox 1 last 1\n";
        	print F6 "center :1-1579\n";
       		print F6 "image origin center familiar\n";
        	print F6 "strip :1576-1579\n";
        	print F6 "strip :1-1530\n";
        	print F6 "trajout 1NNE-dna_prod-stripped-combi_1_15ns.trj nobox\n";
                print F6 "EOF7\n\n";
		
        	print F6 "cp ~/Manju/MUTS-FILES/MUTS-Mutation/MM-PBSA_Input/runMD_c* .\n";
        	print F6 "cp ~/Manju/MUTS-FILES/MUTS-Mutation/MM-PBSA_Input/DNA* .\n";
		print F6 "mkdir DNA\n";
		print F6 "sh runMD_curves.sh\n";
		print F6 "sh runMD_canal.sh\n";
		print F6 "mv dna_1-15ns* result_dna_1-15ns* DNA\n";
		print F6 "gzip 1NNE-dna_prod-stripped-combi_1_15ns.trj\n";
		print F6 "gzip ANALYSIS/1NNE-dna-atp-mg_prod-stripped-combi_1_".$j."ns.mdcrd\n";

		close(F6);
	    }
close(F1);
