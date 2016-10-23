#!/usr/bin/perl
	

@CrowderRun = ();
open(F1,$ARGV[0]);
$i=0; $j=0;
#$Crowder=0;
while(<F1>) { 
		chomp;
		@data = split(/\s+/,$_);
		for ($i = 0; $i <scalar(@data); $i++) {
			 next if( $i==$j);	
			$CrowderRun[$j][$i] = 0.0;	
			$CrowderRun[$j][$i] = $data[$i] if( $data[$i] >= 0.85700);	
			#$Crowder++ if( $data[$i] >= 0.85700);	
			#print $data[$i],"\n" if( $data[$i] >= 0.85700);	
			#print $data[$i],"\n" if( $i==$j);	
			}
		$j++;
		}
close(F1);


@MDRun =();
open(F1,$ARGV[1]);
$i=0; $j=0;
#$MDer=0;
while(<F1>) {
		chomp;
                @data = split(/\s+/,$_);
                for ($i = 0; $i <scalar(@data); $i++) {
			next if( $i==$j);	
                        $MDRun[$j][$i] = 0.0;
			$MDRun[$j][$i] = $data[$i] if( $data[$i] >= 0.87);	
			#$MDer++ if($data[$i] >= 0.87);	
			#print $MDRun[$j][$i],"\n"  if( $data[$i] >= 0.87);	
			#print $data[$i],"\n" if( $i==$j);	
                        }
                $j++;
                }
close(F1);

@SCARun =();
open(F1,$ARGV[2]);
$i=0; $j=0;
#$SCAer=0;
while(<F1>) {
		chomp;
                @data = split(/\s+/,$_);
                for ($i = 0; $i <scalar(@data); $i++) {
			next if( $i==$j);	
                        $SCARun[$j][$i] = 0.0;
                        $SCARun[$j][$i] = $data[$i] if( $data[$i] >= 0.4107);        
                        #$SCAer++ if( $data[$i] >= 0.4107);        
                        #print $SCARun[$j][$i],"\n" if( $data[$i] >= 0.4107);        
			#print $data[$i],"\n" if( $i==$j);	
                        }
                $j++;
                }
close(F1);

#print $Crowder,"\t",$MDer,"\t",$SCAer,"\n";
#exit;
@CombineAll=();
for($i = 0; $i <= $#CrowderRun; $i++){
           for($j = 0; $j <= $#{$CrowderRun[0]} ; $j++){
					$CombineAll[$i][$j] = 0;
						       }
				}

@CombineAll=();
for($i = 0; $i <= $#CrowderRun; $i++){
           for($j = 0; $j <= $#{$CrowderRun[0]} ; $j++){
					     #print $SCARun[$i][$j],"\t",$MDRun[$i][$j],"\t",$CrowderRun[$i][$j],"\t",$i,"\t",$j,"\n";
					     #if($i==$j) { $CombineAll[$i][$j] = 0; }
					     if($SCARun[$i][$j] > 0 and  $MDRun[$i][$j] > 0 and $CrowderRun[$i][$j] > 0) { $CombineAll[$i][$j] = 4; }
					     elsif($SCARun[$i][$j] > 0 and  $MDRun[$i][$j] > 0) { $CombineAll[$i][$j] = 2; }
					     elsif($MDRun[$i][$j] > 0 and $CrowderRun[$i][$j] > 0) { $CombineAll[$i][$j] = 2.5; }
					     elsif($SCARun[$i][$j] > 0 and $CrowderRun[$i][$j] > 0) { $CombineAll[$i][$j] = 3; }
					     elsif($SCARun[$i][$j] > 0) { $CombineAll[$i][$j] = 0.5; }
					     elsif($MDRun[$i][$j] > 0) { $CombineAll[$i][$j] = 1; }
					     elsif($CrowderRun[$i][$j] > 0) { $CombineAll[$i][$j] = 1.5; }
					     else { $CombineAll[$i][$j] = 0; }
					     #if($SCARun[$i][$j] > 0 and  $MDRun[$i][$j] > 0 and $CrowderRun[$i][$j] > 0) { print "$CombineAll[$i][$j] \n"; }
					     print "$CombineAll[$i][$j] \t";	
                                                       }
					     print "\n";
                                }
