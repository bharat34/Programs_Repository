#!/usr/bin/perl -w
# This is a Perl script for post processing of matrices from Fodor's code.
# Need to
#	Read in 1d list of results from fodors Program
#	Form a 2d full matrix from a 1d list of elements of the upper triangle
#	Make upper triangle contain positive correlations, lower negative   


# Open file for output and test;
# my($outputfile) = "Fodor Matrix Results";

# unless( open(OUTPUTFILE,"+<$outputfile")) {
# print "/n/nCannot open file $outputfile\n\n";
#      exit;
# }

  print "\n\n Post Processing of Fodor Output Matrix\n\n";

#######################################################
# Initialize Variables
# nseq = number of sequences in the alignment
# npos = number of positions in the sequence alignment

   my($fodor_array_name) = "test_mi_out.txt";

   open(FODOR_ARRAY,$fodor_array_name);

   my($fodor_array) =<FODOR_ARRAY>;
  
   my($nseq) = 4; my($npos) = 8;

   print "\n\n$nseq,$npos\n\n";

   my(%fodor_matrix); 
   
   print "\n\nInput Fodor Array is $fodor_array\n\n";


exit;

