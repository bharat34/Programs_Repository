		open (F6,">test.in");
		$j=15;

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
		print F6 "mv 1NNE-dna_prod-stripped-combi_1_15ns.trj.gz DNA\n";
		close(F6)

