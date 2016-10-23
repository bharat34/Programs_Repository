#!/usr/bin/perl -w


# This version is for transforming an correl.txt matrix from ptraj to the interval (0,1)

#	Output is printed and written to file lineout.txt.
#      Version 1 Feb 4 08 DLB REvised 3/5/08 DLB and SK: Works OK!!!!


#  This is my test matrix
#   0.37   0.29  -0.14   0.02
#   0.29   0.74   0.32   0.27
#  -0.14   0.32   0.60   0.20
#   0.02   0.27   0.20   0.68

#  TEst of Printing to a file from
#	open(OUT, '>lineout.txt') or die "Problem: can't open input_file!";
#	for ($i = 1; $i <=10; $i += 1)
#	{
#		print "This is line $i\n";
#		print OUT "This is line $i\n";
#	}
#  This works to lineout.txt!!

      my(@mat);

      $n = 0;

# 	$input_file = "test_matrix.txt";
#  	$input_file = "test_matrix_2.txt";
#	$input_file = "average.txt";
 	$input_file = "1be9_free_50ns_combi_00001-25000-1-correlmat.dat";
#    **** Note: MAke sure correlmat does not have any trailing lines at the end
#     $input_file = "correlmat.dat";
      open(INFILE,$input_file) or die "Problem: can't open input_file!";
      while (<INFILE>)
      {
#             Assuming no header line ....
		$new_line = $_;
#             This removes white space and CR from the end of the line:
	       chomp($new_line);
#             This removes white space from the beginning of the line:
		$new_line =~ s/^\s+//;
	          	@next_row = split (/\s+/,$new_line);
			push (@mat, [@next_row]);
		$n = $n + 1;
     }


       print "mmdevel average.txt Matrix for (0,1) Transformation Accepted\n";


# So like KK turn this into absolute values 	
	
	$i=0;
	foreach $matArray (@mat){    
	$j=0;  foreach $matCell (@$matArray)    {
				
    		$mat[$i][$j] = abs($mat[$i][$j]);
	
	$j++;  } 
 	$i++;}



# script for printing out the matrix

#           print "\n\nprint of mat_before transformation\n\n";

#	         for $array_ref ( @mat )
#              {

#			print ( "[ @$array_ref ]\n");
#            	       print OUT ( "@$array_ref  \n");
#              }
# 		print OUT "\n";
	print "\n";

	$min =$mat[0][0];
	$max =$mat[0][0];
	print "\n initial max is $max\n";
	print "\n initial min is $min\n";

#  This wierd loop is from http://www.tek-tips.com/viewthread.cfm?qid=1275479&page=3
#  but it works OK

# So find the  min value in the matrix	
	
	$i=0;
	foreach $matArray (@mat){    
	$j=0;  foreach $matCell (@$matArray)    {
#            print "\$i = $i, \$j = $j, $mat[$i][$j]\n";
				
    		if ($mat[$i][$j] < $min) {
				$min = $mat[$i][$j];
		}
	$j++;  } 
 	$i++;}

       
 	print "\n min is $min\n";

# Transform the matrix to a new min value of 0

my(@newmat);
	$i=0;
	foreach $matArray (@mat){    
	$j=0;  foreach $matCell (@$matArray)    {
#            		print "\$i = $i, \$j = $j, mat = $mat[$i][$j]\n";
			$newmat[$i][$j] = $mat[$i][$j]-$min;	
#    			print "\$i = $i, \$j = $j, newmat = $newmat[$i][$j]\n";		
		$j++;  } 
 	$i++;}


# print out the matrix newmat
#	print "\n";
#	for $aref ( @newmat ) {
#     	print "\t [ @$aref ],\n"; }

# Now find the  max value in the  matrix	newmat (has lower bound of 0)
	
	$i=0;
	foreach $matArray (@newmat){    
	$j=0;  foreach $matCell (@$matArray)    {
#           print "\$i = $i, \$j = $j, $newmat[$i][$j]\n";
				
    		if ($newmat[$i][$j] > $max) {
				$max = $newmat[$i][$j];
		}
	$j++;  } 
 	$i++;}

print "\n max is $max\n";


my(@finalmat);
	$i=0;
	foreach $matArray (@newmat){    
	$j=0;  foreach $matCell (@$matArray)    {
#            		print "\$i = $i, \$j = $j, newmat = $newmat[$i][$j]\n";
			$finalmat[$i][$j] = $newmat[$i][$j]/$max;	
#    			print "\$i = $i, \$j = $j, finalmat = $finalmat[$i][$j]\n";		
		$j++;  } 
 	$i++;}

# print the whole thing with refs
#	for $aref ( @finalmat ) {
#     print "\t [ @$aref ],\n"; }

$unrounded = 0.66666;

printf "$unrounded rounded to 3 decimal places is %.3f\n",$unrounded;
print "\n";

	open(OUT, '>lineout.txt') or die "Problem: can't open input_file!";



#  script for printing out the matrix to lineout

          print "\n\nprint of finalmat_after\n\n";

	         for $array_ref ( @finalmat )
           {

#			print ( "[ @$array_ref ]\n");
            	       print OUT ( "@$array_ref  \n");
            }
		print OUT "\n";
print "\n";

       print "Matrix (0,1) Transformation Completed\n";
      exit;