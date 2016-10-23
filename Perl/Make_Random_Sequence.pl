
#!/usr/bin/perl

%MSA=();
open(F1,$ARGV[0]);
$limit = $ARGV[1];

if(@ARGV != 2) {
			print "\n\t\t\tperl Make_Random_Sequence.pl USER_MSA.fasta NoOfRandomSequences\n\n\n";
			exit;
		}
while(<F1>) {
		chomp;
		if(/^>/) { 
				$_=~s/^>//g; 
				$header = $_;
			 }
		$_=<F1>;
		chomp;
		MSA->{$header} = lc($_);
	    }
close(F1);



foreach $key ( keys %MSA) {
				$sytem = "./main.exe -s ".$MSA{$key}." -n 100 > ".$key;
				#print $sytem,"\n";
				system($sytem);
				#print $key,"=>",$MSA{$key},"\n";
			  }

for ($i = 0; $i < 100; $i++) {
					open(F2,">Random_MSA_".$i.".txt");
foreach $key ( keys %MSA) {

					@data= ();
					open(F1,$key);
					@data=<F1>;
					close(F1);
					print F2 ">".$key,"\n";
					print F2 uc($data[$i]);
                          }
					close(F2);
			     }


foreach $key ( keys %MSA) {
				system "rm ".$key;
			  }
