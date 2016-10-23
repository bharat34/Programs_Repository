#
# This Programs remove the either N or C or both termial with certail given no of residues and print the rest of the Prody generater any nmd file 
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

$offset1=0; $offset2=0;
$offset1=$ARGV[2];
$offset2=$ARGV[3];

if(scalar(@ARGV)!=4)
{
	print "Arguments are missing\n";
	print "perl Prody_nmd_filter.pl nmd_file option N_terminal_offset C_termial_offset \n";
	print "option 1 for N-terminal\n";
	print "option 2 for N and C terminal\n";
	exit;
}

open(F1,$ARGV[0]) or die "Please input the Prody generated nmd file";

$name=undef;
if($offset1 > 0 and $offset2 == 0) { $name = $offset1."ResRevN_Terminal"; }
elsif($offset2 > 0 and $offset1 == 0) { $name = $offset2."ResRevC_Terminal"; }
else { $name = $offset1."ResRevN_TerminalAND".$offset2."ResRevC_Terminal"; }

open(F4,">".$name.$ARGV[0]) or die "Please input the Prody generated nmd file";
		$_=<F1>;
		print F4 $_;

		$_=<F1>;
		print F4 $_;
					$a= $offset1+1;
					$b=($offset1*3)+2;
					$c=($offset2*3);
					$d=($offset2);

if($ARGV[1]==1) {
					
		while(<F1>) {
				@data = split(/\s+/,$_);
				if(($_!~/^mode/) and ($_!~/^coordinates/)) { print F4 $data[0]," "; &one_side(1,$a,$d,@data); }
			      else { print F4 $data[0]," ",$data[1]," "; &one_side(2,$b,$c,@data); }
			    }
		}
elsif($ARGV[1]==2) {

		while(<F1>) {
				@data = split(/\s+/,$_);
				if(($_!~/^mode/) and ($_!~/^coordinates/)) { print F4 $data[0]," "; &one_side(1,$a,$d,@data); }
			      else { print F4 $data[0]," ",$data[1]," "; &one_side(2,$b,$c,@data); }
			    }
		}


sub one_side {	
					($index,$offset1,$offset2,@line) = @_;
					#print $index," ",$offset1," ",$offset2,"\n";
					
	for ($i = $offset1; $i < (scalar(@line) - $offset2); $i++) {
			print F4 $line[$i]," ";
								   }
			print F4 "\n";
	      }
close(F1);
close(F4);
print "\n\t\t\t Output written in $name.$ARGV[0] \n\n";
