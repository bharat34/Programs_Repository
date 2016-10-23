
#!/usr/bin/perl

#How to run the program
# In the BFactor File residue name and corresponding Bfactor should be tab seperated
# perl ChangeBFactor.pl 1URN_res 1URN_BFactor 1URN.pdb > 1URN_new.pdb

open(F1,$ARGV[0]);
@ResList=<F1>;
chomp(@ResList);
close(F1);


open(F2,$ARGV[1]);
%ResBFactor= ();
while(<F2>) {
                chomp;
		split(/\s+/,$_);	
                ResBFactor->{$_[0]} = $_[1];
            }
close(F2);


open(F3,$ARGV[2]);
while(<F3>) {
		$ResNumber =  substr($_,23,3);
		$ResNumber=~s/\s+//g;
		$a=substr($_,6,6);
		$b=substr($_,13,4);
		$c=substr($_,17,3);
		$d=substr($_,21,1);
		$e=substr($_,23,3);
		$f=substr($_,32,6);
		$g=substr($_,40,6);
		$h=substr($_,48,6);
		$i=substr($_,56,4);
		$j=substr($_,61,5);
		$j=0.000;
		$ATOM="ATOM";
		#print $ResNumber,"\n";
		if(exists $ResBFactor{$ResNumber})
		{ 
			#print $ResBFactor{$ResNumber},"\t",$ResNumber,"\n";
			$j=$ResBFactor{$ResNumber};
		#printf  "%-6s%5s %-4s%-5s %3d%12.3f%8.3f%8.3f%6.2f%6.2f\n",$ATOM,$a,$b,$c,$e,$f,$g,$h,$i,$j;
		}
		printf  "%-6s%5s %-4s%-5s %3d%12.3f%8.3f%8.3f%6.2f%6.1f\n",$ATOM,$a,$b,$c,$e,$f,$g,$h,$i,$j;
	    }
close(F3);
