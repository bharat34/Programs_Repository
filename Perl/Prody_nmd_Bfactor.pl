#
# This Programs extrract two columns namely resids and bfactors and convert both into rows from Prody generated .nmd files 
#
#

%AA = (
	 'ALA'=>'A',
'CYS'=>'C',
'ASP'=>'D',
'GLU'=>'E',
'PHE'=>'F',
'GLY'=>'G',
'HIS'=>'H',
'ILE'=>'I',
'LYS'=>'K',
'LEU'=>'L',
'MET'=>'M',
'ASN'=>'N',
'PRO'=>'P',
'GLN'=>'Q',
'ARG'=>'R',
'SER'=>'S',
'THR'=>'T',
'VAL'=>'V',
'TRP'=>'W',
'TYR'=>'Y',
      );
#!/usr/bin/perl

open(F1,$ARGV[0]) or die "Please input the Prody generated nmd file";
while(<F1>) {
		if($_=~/^resnames/)   {
                                        @resnames1 = split(/\s+/,$_);
					foreach $res (@resnames1) {
							push (@resnames2,$AA{$res});
							      }
                                    }
		if($_=~/^resids/)   { 
					@resids = split(/\s+/,$_); 
				    }
		if($_=~/^bfactors/) { 
					@bfactors = split(/\s+/,$_);

					open(F2,">Plot_".$ARGV[0]) or die "Please input the Prody generated nmd file";
		for ($i= 0; $i < scalar(@resids and @bfactors); $i++) {
									print F2 $resids[$i],$resnames2[$i],"   ",$bfactors[$i],"\n";
								      }
					close(F2);
		exit;
			
				    }
	    }
close(F1);
