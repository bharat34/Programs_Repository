#!/usr/bin/perl

%AA= (
'GCT'=>'Alanine',
'GCG'=>'Alanine',
'GCC'=>'Alanine',
'GCA'=>'Alanine',
'CGT'=>'Arginine',
'CGG'=>'Arginine',
'CGC'=>'Arginine',
'CGA'=>'Arginine',
'AGG'=>'Arginine',
'AGA'=>'Arginine',
'AAT'=>'Asparagine',
'AAC'=>'Asparagine',
'GAT'=>'Aspartate',
'GAC'=>'Aspartate',
'TGT'=>'Cysteine',
'TGC'=>'Cysteine',
'GAG'=>'Glutamate',
'GAA'=>'Glutamate',
'CAG'=>'Glutamine',
'CAA'=>'Glutamine',
'GGT'=>'Glycine',
'GGG'=>'Glycine',
'GGC'=>'Glycine',
'GGA'=>'Glycine',
'CAT'=>'Histadine',
'CAC'=>'Histadine',
'ATT'=>'Isoleucine',
'ATC'=>'Isoleucine',
'ATA'=>'Isoleucine',
'TTG'=>'Leucine',
'TTA'=>'Leucine',
'CTT'=>'Leucine',
'CTG'=>'Leucine',
'CTC'=>'Leucine',
'CTA'=>'Leucine',
'AAG'=>'Lysine',
'AAA'=>'Lysine',
'ATG'=>'Methionine',
'TTT'=>'Phenylalanine',
'TTC'=>'Phenylalanine',
'CCT'=>'Proline',
'CCG'=>'Proline',
'CCC'=>'Proline',
'CCA'=>'Proline',
'TCT'=>'Serine',
'TCG'=>'Serine',
'TCC'=>'Serine',
'TCA'=>'Serine',
'AGT'=>'Serine',
'AGC'=>'Serine',
#'TGA'=>'Stop',
#'TAG'=>'Stop',
#'TAA'=>'Stop',
'ACT'=>'Threonine',
'ACG'=>'Threonine',
'ACC'=>'Threonine',
'ACA'=>'Threonine',
'TGG'=>'Tryptophan',
'TAT'=>'Tyrosine',
'TAC'=>'Tyrosine',
'GTT'=>'Valine',
'GTG'=>'Valine',
'GTC'=>'Valine',
'GTA'=>'Valine', );


for $keys (keys %AA) {  
		      #if(substr($keys,0,1) eq 'T' ) {
							$def=undef;
							$pos1=undef;
		       $def.='A',$pos1.=3 if((substr($keys,0,1) eq 'T') and (substr($keys,1,1) eq 'G') and (substr($keys,2,1) ne 'A')); 
		       $def.='G',$pos1.=2 if((substr($keys,0,1) eq 'T') and (substr($keys,1,1) ne 'G') and (substr($keys,2,1) eq 'A')); 

		       $def.='G',$pos1.=3 if((substr($keys,0,1) eq 'T') and (substr($keys,1,1) eq 'A') and (substr($keys,2,1) ne 'G')); 
		       $def.='A',$pos1.=2 if((substr($keys,0,1) eq 'T') and (substr($keys,1,1) ne 'A') and (substr($keys,2,1) eq 'G')); 

		       $def.='A',$pos1.=3 if((substr($keys,0,1) eq 'T') and (substr($keys,1,1) eq 'A') and (substr($keys,2,1) ne 'A')); 
		       $def.='A',$pos1.=2 if((substr($keys,0,1) eq 'T') and (substr($keys,1,1) ne 'A') and (substr($keys,2,1) eq 'A')); 

		       $def.='T',$pos1.=1 if((substr($keys,1,1) ne 'T') and (substr($keys,1,1) eq 'G') and (substr($keys,2,1) eq 'A')); 
		       $def.='T',$pos1.=1 if((substr($keys,1,1) ne 'T') and (substr($keys,1,1) eq 'A') and (substr($keys,2,1) eq 'G')); 
		       $def.='T',$pos1.=1 if((substr($keys,1,1) ne 'T') and (substr($keys,1,1) eq 'A') and (substr($keys,2,1) eq 'A')); 
			
		       print $keys," change to the ",substr($def,0,1)," at ",substr($pos1,0,1),"nd position code for ",$AA{$keys},"\n" if(length($def)!=0);
		       print $keys," change to the ",substr($def,1,1)," at ",substr($pos1,1,1),"nd position code for ",$AA{$keys},"\n" if(length($def)==2);
		       print $keys," change to the ",substr($def,2,1)," at ",substr($pos1,2,1),"nd position code for ",$AA{$keys},"\n" if(length($def)==3);
			#			    }
	             }
