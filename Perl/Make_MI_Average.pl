
#!/usr/bin/perl

if(@ARGV != 2) {
                        print "\n\t\t\tperl Make_MI_Average.pl list MSAResiduelength\n\n\n";
                        exit;
                }

open(F1,$ARGV[0]);
$limit=$ARGV[1];
@SUM = ();

while(<F1>) {
		chomp;
		$count= 0;
		open(F2,$_);
		$_= <F2>;
		while(<F2>) {
				@data = split(/\s+/,$_);
				for ($i = 1; $i < scalar(@data); $i++) {
						$SUM[$count] += $data[$i];
						$count++;
								       }
			    }
		close(F2);
	    }
close(F1);



open(F1,">FINAL_RANDOM_MI_MSA_CONVERSION.txt");
for ( $i = 0; $i < scalar(@SUM); $i++) {
			if($i%$limit ==0) { print F1 "\n"; }
			print F1 $SUM[$i]/100,"\t"; 
				      }

