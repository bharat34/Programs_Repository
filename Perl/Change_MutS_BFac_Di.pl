open(F1,$ARGV[1]);
while(<F1>) {
		push(@DATA,$_);
		}
close(F1);

$i=0; $flag=0;
open(F1,$ARGV[0]);
while(<F1>) {
		
		next if(!/^ATOM|^HETATM|^TER|^END/);
		$res=substr($_,22,4);
if($flag==0) {
		if($A==$res-1 or $A==$res-7) { $i++; }
		$chain=substr($_,21,1);
		($A,$B)=split(/\s+/,$DATA[$i]);
		if($A==$res) { print substr($_,0,60)," ",$B,"\n"; $RES1=substr($_,17,3); }
		else { print substr($_,0,60),"\n"; }
		
		}
		if($_=~/TER/ and $_=~/765/ and $_=~/ARG/) { $flag=1; $i=0; }
if($flag==1) {

		if($A+1000==$res-1 or $A+1000==$res-7) { $i++; }
		if(substr($_,7,4)==7721) { $i=108; }
		
                $chain=substr($_,21,1);
                ($A,$B)=split(/\s+/,$DATA[$i]);
                if($A+1000==$res) { print substr($_,0,60)," ",$B,"\n"; $RES1=substr($_,17,3); }
                else { print substr($_,0,60),"\n"; }

	     }
				

		
		}
close(F1);
