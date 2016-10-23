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

%pdb;
open(F1,$ARGV[0]) or die "Please input the Prody generated nmd file";
$a=undef;
while(<F1>) {
		split(/\s+/,$_);
		if($a!=$_[5]) { $pdb{$_[5]} = $AA{$_[3]} if exists $AA{$_[3]}; $a=$_[5];}
	    }
close(F1);

open(F1,$ARGV[1]) or die "Please input the Prody generated nmd file";
while(<F1>) {
		chomp;
		print $pdb{$_},$_,"\n" if exists $pdb{$_};
	    }
close(F1);
