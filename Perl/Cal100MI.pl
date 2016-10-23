#!/usr/bin/perl
	

@array= ();
for ($i = 0; $i <1000; $i++) {
			system("java covariance.algorithms.RandomScore U1A.free MI_On_U1A_randomOut.txt");
			$k=0;		
			open(F2,"MI_On_U1A_randomOut.txt");
			$_=<F2>;
		while(<F2>) {
				chomp;
				split(/\t/,$_);
				$array[$k] += $_[2];
				$k++;
			    }
		close(F2);
			}
close(F1);


open(F3,$ARGV[1]);
@Fir_and_Sec_column=();
$k=0;
while(<F3>) {
		chomp;
		$Fir_and_Sec_column[$k] =$_;
		$k++;
	    }
close(F3);



$k=0;
@array1 = ();
foreach $line (@array) {
	$array1[$k] = $line/$i;
	$k++;
}




$k=0;
open(F2,$ARGV[0]);
$_=<F2>;
while(<F2>) {
                                chomp;
                                split(/\t/,$_);
                                $_[2] -= $array1[$k];
				print $Fir_and_Sec_column[$k],"\t",$_[2],"\n";
				#push($Fir_and_Sec_column[$k],$_[2]);
				#print $_[0],"\t",$_[1],"\t",$array1[$k],"\n";
				#print $_[0],"\t",$_[1],"\t",$_[2],"\n";
                                $k++;
            }
close(F2);
