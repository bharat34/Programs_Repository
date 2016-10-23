#!/usr/bin/perl
	
@ResArray= (12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84);


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
				$flag1=0; $flag2=0; $flag3=0;
           for($j = 0; $j <= $#{$CrowderRun[0]} ; $j++){
					     if($SCARun[$i][$j] > 0) { $flag1=1; }	     	
					     if($MDRun[$i][$j] > 0) { $flag2=1; }	     	
					     if($CrowderRun[$i][$j] > 0) { $flag3=1; }	     	
                                                       }
					     if($flag1 == 1 and $flag2 == 1 and $flag3 == 1) { push(@Allthree1,$ResArray[$i]); }
					     elsif($flag1 == 1 and $flag2 == 1) { push(@SCAMD1,$ResArray,[$i]); }
					     elsif($flag2 == 1 and $flag3 == 1) { push(@MDCrowder1,$ResArray[$i]); }
					     elsif($flag1 == 1 and $flag3 == 1) { push(@SCACrowder1,$ResArray[$i]); }
					     elsif($flag1 == 1) { push(@SCA1,$ResArray[$i]); }
					     elsif($flag2 == 1) { push(@MD1,$ResArray[$i]); }
					     elsif($flag3 == 1) { push(@Crowder1,$ResArray[$i]); }
					     else {; }
					     #print $flag1,"\t",$flag2,"\t",$flag3,"\n";	
                                }
print "SCA  result\n";
print "@SCA1\n";
print "MD result\n";
print "@MD1\n";
print "Crowder result\n";
print "@Crowder1\n";
print "SCA MD result\n";
print "@SCAMD1\n";
print "Crowder MD result\n";
print "@CrowderMD1\n";
print "SCA Crowder result\n";
print "@SCACrowder1\n";
print "All three result\n";
print "@Allthree1\n";
