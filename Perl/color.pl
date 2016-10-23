#!/usr/bin/perl
	

@ResArray= (12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84);

@Darray = ();
open(F1,$ARGV[0]);
$j=0;
while(<F1>) {
		@data = split (/\s+/,$_);
		for ( $i = 0; $i < scalar(@data); $i++) {
				     $Darray[$j][$i] = $data[$i];
						        }
		$j++;		
	    }
close(F1);

for($i = 0; $i <= $#Darray; $i++){
           for($j = 0; $j <= $#{$Darray[0]} ; $j++){
					 if($Darray[$i][$j] > 0 and $Darray[$i][$j] == $Darray[$j][$i]) { 
							$Darray[$j][$i] = 0;  
													}
					           }
                                 }
for($i = 0; $i <= $#Darray; $i++){
           for($j = 0; $j <= $#{$Darray[0]} ; $j++){
			         if($Darray[$i][$j] == 0.5) { 
                                                              	#push(@SCA,$ResArray[$i],"\n");  
                                                              	#push(@SCA,$ResArray[$j],"\n");  
							      	#print $ResArray[$i]," ",$ResArray[$j]," ",1,"\n"; 
								push(@store,$ResArray[$i]." ".$ResArray[$j]." ".1);	
								#push(@store,$ResArray[$i]." ".$ResArray[$j]." ".0.5);	
								#print $i+1," ",$j+1," ",1,"\n";
							    } 		
			      elsif($Darray[$i][$j] == 1)   { 
								
                                                              	#push(@MD,$ResArray[$i],"\n");  
                                                              	#push(@MD,$ResArray[$j],"\n");  
								#print $ResArray[$i]," ",$ResArray[$j]," ",2,"\n"; 
								push(@store,$ResArray[$i]." ".$ResArray[$j]." ".2);
								#push(@store,$ResArray[$i]." ".$ResArray[$j]." ".1);
								#print $i+1," ",$j+1," ",2,"\n";
								} 		
			      elsif($Darray[$i][$j] == 1.5) { 
                                                              	#push(@Crowder,$ResArray[$i],"\n");  
                                                              	#push(@Crowder,$ResArray[$j],"\n");  
								#print $ResArray[$i]," ",$ResArray[$j]," ",3,"\n"; 
								push(@store,$ResArray[$i]." ".$ResArray[$j]." ".3);
								#push(@store,$ResArray[$i]." ".$ResArray[$j]." ".1.5);
								#print $i+1," ",$j+1," ",3,"\n";
								} 		
			      elsif($Darray[$i][$j] == 2)   { 
                                                              	#push(@SCAMD,$ResArray[$i],"\n");  
                                                              	#push(@SCAMD,$ResArray[$j],"\n");  
								#print $ResArray[$i]," ",$ResArray[$j]," ",4,"\n"; 
								push(@store,$ResArray[$i]." ".$ResArray[$j]." ".4);
								#push(@store,$ResArray[$i]." ".$ResArray[$j]." ".2);
								#print $i+1," ",$j+1," ",4,"\n";
								} 		
			      elsif($Darray[$i][$j] == 2.5) { 
                                                              	#push(@CrowderMD,$ResArray[$i],"\n");  
                                                              	#push(@CrowderMD,$ResArray[$j],"\n");  
								#print $ResArray[$i]," ",$ResArray[$j]," ",5,"\n"; 
								push(@store,$ResArray[$i]." ".$ResArray[$j]." ".5);
								#push(@store,$ResArray[$i]." ".$ResArray[$j]." ".2.5);
								#print $i+1," ",$j+1," ",5,"\n";
								} 		
			      elsif($Darray[$i][$j] == 3)   { 
                                                              	#push(@SCACrowder,$ResArray[$i],"\n");  
                                                              	#push(@SCACrowder,$ResArray[$j],"\n");  
								#print $ResArray[$i]," ",$ResArray[$j]," ",6,"\n"; 
								push(@store,$ResArray[$i]." ".$ResArray[$j]." ".6);
								#push(@store,$ResArray[$i]." ".$ResArray[$j]." ".3);
								#print $i+1," ",$j+1," ",6,"\n";
								} 		
			      elsif($Darray[$i][$j] == 3.5) { 	
								#print $ResArray[$i]," ",$ResArray[$j]," ",7,"\n"; 
								push(@store,$ResArray[$i]." ".$ResArray[$j]." ".7);
								#push(@store,$ResArray[$i]." ".$ResArray[$j]." ".3.5);
								#print $i+1," ",$j+1," ",7,"\n";
								} 		
			      elsif($Darray[$i][$j] == 4)   { 	
                                                              	#push(@Allthree,$ResArray[$i],"\n");  
                                                              	#push(@Allthree,$ResArray[$j],"\n");  
								#print $ResArray[$i]," ",$ResArray[$j]," ",8,"\n"; 
								push(@store,$ResArray[$i]." ".$ResArray[$j]." ".8);
								#push(@store,$ResArray[$i]." ".$ResArray[$j]." ".4);
								#print $i+1," ",$j+1," ",8,"\n";
								} 		
				else { 
						#print $ResArray[$i]," ",$ResArray[$j]," ",0,"\n"; 
						push(@store,$ResArray[$i]." ".$ResArray[$j]." ".0);
						#print $i+1," ",$j+1," ",0,"\n";
					}
					#print $Darray[$k][$l],"\t";	
						    }
				#	print "\n";
				}
#print scalar(@store);
#print "SCA  result\n";
#print "@SCA\n";
#print "MD result\n";
#print "@MD\n";
#print "Crowder result\n";
#print "@Crowder\n";
#print "SCA MD result\n";
#print "@SCAMD\n";
#print "Crowder MD result\n";
#print "@CrowderMD\n";
#print "SCA Crowder result\n";
#print "@SCACrowder\n";
#print "All three result\n";
#print "@Allthree\n";
#for($i = 0; $i < scalar(@store); $i+=66) {
		#print $store[$i],"\t",$i,"\n";
		$i = 1;
		for($j = 1; $j < 85; $j++) { 
						$flag = 0;
			for($k = 1; $k < 85; $k++) { 
							($a,$b,$c) = split(/\s+/,@store[$i]);
							if($a == $j and $k == $b) {  
											print $store[$i],"\n";
											$i++;
										        $flag=1;
											#print $c,"\t";
										  } 	
							else { 
									print $j," ",$k," ",0,"\n"; 
									#print "0\t";
							     }
					      }
					#		print "\n";
					}
			
			
#print @store;
