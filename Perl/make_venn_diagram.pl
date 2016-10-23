# This program is to create van diagram

#/usr/bin/perl

%venn;
%fin_venn;
$total=0;

open(F1,$ARGV[0]);
while(<F1>) {
	chomp($_);
	if($_!~/^\d/)   { push(@keys,$_); $key= $_; $total++; }	
	elsif($_=~/\d/) { push(@{$venn{$key}}, $_); }
	    }
close(F1);

for($i=0; $i < scalar(@keys); $i++) {

	for($j=$i+1; $j < scalar(@keys); $j++) {

			foreach $keys1 ( @{$venn{$keys[$i]}} ) {
				foreach $keys2 ( @{$venn{$keys[$j]}} ) {
						if($keys1==$keys2 and exists($finn_venn{$keys1})) { 	
													$pattern = $finn_venn{$keys1};
													$flag=0;
							for ($k=0; $k < length($pattern); $k++) { $flag=1 if($keys[$j] eq substr($pattern,$k,1)); } 
										if($flag!=1){	
													$comb_key = $finn_venn{$keys1}.$keys[$j]; 
													$finn_venn{$keys1}=$comb_key; 
												     }
												}
						elsif($keys1==$keys2) {
									$comb_key = $keys[$i].$keys[$j]; 
									$finn_venn{$keys1}=$comb_key; 
								      }
									}
						 if(not exists($finn_venn{$keys1})) {
									$finn_venn{$keys1}=$keys[$i];
						     				     }
								}
						}
					}

for($i=scalar(@keys)-1 ; $i < scalar(@keys); $i++) { 
		for($j=0; $j < 1; $j++) {
			foreach $keys1 ( @{$venn{$keys[$i]}} ) {
				foreach $keys2 ( @{$venn{$keys[$j]}} ) { 
						if(not exists($finn_venn{$keys1})) {
										$finn_venn{$keys1}=$keys[$i];
											}			
									}
								}
					}
		 }
					

foreach my $key ( keys %finn_venn )  {
				#if((length($finn_venn{$key})) > 1){
				print $key," ",$finn_venn{$key},"\n";
				#}
				     }
