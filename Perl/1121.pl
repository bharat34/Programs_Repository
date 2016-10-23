#!/usr/bin/perl


$a="input";
$b=2;
$c="output";

#system "./Eigen.exe ".$a." ".$b." > ".$c;
#system "cat ".$c." | sed 's/[ ]/,/g'";

#print "awk \'{print ";
#for ($i=1; $i <9259; $i++) 
#{
#	print "\$$i\",\"";
#}
#print "\$$i";
#print "}\'";

@d = 0;
	
 $d[0][0] = 2;
 $d[0][1] = 2;
 $d[0][1] = 3;

	
	for ( $i = 0; $i < 3; $i++) { 
			for ( $j = 0; $j < 3; $j++) { 
								$d[$i][$j] = 0;
						    }
				    }

	for ( $i = 0; $i < 3; $i++) { 
			for ( $j = 0; $j < 3; $j++) { 
						print $d[$i][$j]," ";
							}
					print "\n";
				    }
