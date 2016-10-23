#!/usr/bin/perl   

# This is a perl script for calculating the dipole moment of a distribution of point charges.
# Specifically the points are atoms of a molecule and the point charges are net atomic charges.

# Authors: Bharat Lakhani and Lena Dang (DLB Group) DLB Version of 3/4/12

# You need to create a folder containing the perl script (listed here) and an input file.
# Lets call the program "dipole.pl".  The input file contains the xyz coordinates of each atom 
# and their corresponding net charges. Call it "Thymine.pdb" which is in PDB format.

# Here is an example of a "Thymine.pdb" input file in pdb format: x,y, z, and net charge for each atom:

#################################################################################################################
#										
#	ATOM      1  N1  T       1       0.214   0.668   1.296  0.354						#
#	ATOM      2  C6  T       1       0.171  -0.052   2.470 -0.080						#
#	ATOM      3  C2  T       1       0.374   2.035   1.303  0.290						#
#	ATOM      4  O2  T       1       0.416   2.705   0.284 -0.654						#
#	ATOM      5  N3  T       1       0.483   2.592   2.553  0.313						#
#	ATOM      6  C4  T       1       0.449   1.933   3.767 -0.052						#
#	ATOM      7  O4  T       1       0.560   2.568   4.812 -0.616						#
#	ATOM      8  C5  T       1       0.279   0.500   3.685  0.141						#
#	ATOM      9  C5A T       1       0.231  -0.299   4.949  0.304						#
#														
#														
#################################################################################################################

# To execute this program on a PC, go to the start menu and click "Run.." 
# A window will open. Enter "cmd" followed by "return". A command line window will open.
#
# You will get a prompt ">". Change directory (cd) to the folder with the program and input file in it.
# If the folder is "PCLS", so to get there do c:\Users\dbeveridge > cd Desktop\PCLS
#
# To list the contenets of the file you ae in, enter "dir"
# The file should contain the program "dipole.pl" and the input file "Thymine.pdb".

# To execute the perl script, enter "dipole.pl" in response to the prompt. For example,
# this will look something like "c:\Users\dbeveridge\Desktop\PCLS > perl dipole.pl" on your screen.

# The dipole.pl program should execute and print out the calculated dipole moment in Debye units.

# ************************************************************************************

# The listing of the program starts here. Note any line from here on starting with a "#"  is a comment. 

# Initialization: Define the variables to be used:
$mypositivecharge=0; $mynegativecharge=0; $mynoofpositivecharge =0; $mynoofnegativecharge=0;



# Specify which input file to open, i.e. make it available to the program.
print"\nType the name of your PDB file to be analyzed and hit enter. Ex: Adenine.pdb \n";

# Read in user input from command line.
$PDB_file = <STDIN>;

# Remove newline \n (user hitting enter) from filename.
chomp $PDB_file;

# Open the file, and add the ".pdb" extension whether the user specifies it or not.
# If the file is not found in the current directory, notify the user it cannot be found. 
 
if ($PDB_file !~ /.pdb/) {
	$PDB_file2 = $PDB_file . ".pdb";
	open(F1, "$PDB_file2")|| die("Can't open PDB input file: $PDB_file2 not found.");
	}
else 	{
	open(F1, "$PDB_file")|| die("Can't open PDB input file: $PDB_file not found.");
	}



# Tell the program to make a loop over the atoms and read one line of the input file at a time
while($line = <F1>){
		next if($line!=/^ATOM/);
		
# Break out the variables in the line into separate quantities
				($atom,$numbers,$atomtype,$notation,$one,$x,$y,$z,$charge) = split(/\s+/,$line);
    		
# Now compute the contribution of the atom to center of postive charge 
if($charge > 0) {
                        $xcom1 += $charge * $x;
                        $ycom1 += $charge * $y;
                        $zcom1 += $charge * $z;
                        $div1 += $charge;
                        
# Increment the loop counter
			$mynoofpositivecharge++;
			
# add this contribution to the sum
			$mypositivecharge += $charge;
		}
		
# or else compute the contribution of the atom to the center of negative charge and sum
else {
                        $xcom2 += $charge * $x;
                        $ycom2 += $charge * $y;
                        $zcom2 += $charge * $z;
                        $div2 += $charge;
			$mynoofnegativecharge++;
			$mynegativecharge += $charge;
			
     }
	}
# Close the brackets which delineate the loop
close(F1);

# Print out the totals on the screen
	print "\nRESULTS OF \"dipole.pl\" ON \"$PDB_file\" \n \n";
	print "Total +ve charge =",$mypositivecharge," (units of electrical charge,e)\n";
	print "Total -ve charge =",$mynegativecharge," (units of electrical charge,e) \n \n";
	
# Calculate the xyz coordinates of the centers of + and - charges and print.
	$xcom1 = $xcom1 / $div1;
        $ycom1 = $ycom1 / $div1;
        $zcom1 = $zcom1 / $div1;

	$xcom2 = $xcom2 / $div2;
        $ycom2 = $ycom2 / $div2;
        $zcom2 = $zcom2 / $div2;

	printf  "+ ve CO %-6s%5s %-5s%-5s %3d%12.3f%8.3f%8.3f\n",ATOM,1,"+ve",COM,1,$xcom1,$ycom1,$zcom1;
	printf  "- ve CO %-6s%5s %-5s%-5s %3d%12.3f%8.3f%8.3f\n",ATOM,2,"-ve",COM,1,$xcom2,$ycom2,$zcom2;
	print "\n";
	
# Calculate the distance between them and print.
	$distance=(($xcom1 - $xcom2)**2) + (($ycom1- $ycom2)**2) + (($zcom1 - $zcom2)**2);
	$distance = sqrt($distance);
	
#Calculate difference in these charges and print.
	$total_difference_charge = $mypositivecharge - $mynegativecharge;

	print "Difference between centers of (+) and (-) charges = ",$total_difference_charge ,"\n\n";
	print "Distance between (+) and (-) = ",$distance," (Angstroms) \n\n";
	
# Calculate the dipole moment and print out the results.
	$dipole_moment  = $distance * $total_difference_charge/ 0.20822678,"\n";
	print "Dipole moment = $dipole_moment (Debyes)\n";
	$dipole_moment  = $distance * $total_difference_charge,"\n";
	print "Dipole moment = $dipole_moment (Debyes)\n";
	
# End of program
