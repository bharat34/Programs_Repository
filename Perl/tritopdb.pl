##Dt 26/02/05 GM
                 #program to convert Tripos to PDB #
#!/usr/bin/perl -w
print "type the folder name\n";

$a=<STDIN>;
chomp $a;

opendir(FOLDER,$a);

@files=grep(!/^\.\.?$/,readdir(FOLDER));

print "The destination folder\n";

$b=<STDIN>;

chomp $b;
$x=@files;
for($i=0;$i<=$x;$i++)
   {
   open (MOLFILE,"/home/gandhimathi/druglike/lead4/$a/$files[$i]");
   $files[$i] =~ s/mol2/pdb/g;
   open (PRO,">/home/gandhimathi/druglike/lead4/$b/$files[$i]");
  @con=<MOLFILE>;
 print PRO ("IUPAC NAME : $con[5]\n");
 delete ($con[0]);
 delete ($con[1]);
 delete ($con[2]);
 delete ($con[3]);
 delete ($con[4]);
 delete ($con[6]);
 $len=@con;
for($j=7;$j<$len;$j++)
{   $var=$con[$j];
 if ($var =~ /@<TRIPOS>BOND/)
  {  last; 

 }

 
  foreach ($var)
  {
     @contents= split(/\s+/,$var);

     printf PRO ("%-6s%5d  %-4s %3s   %3d    %8.3f%8.3f%8.3f%8.3f%8.3f\n","ATOM","$contents[1]","$contents[2]","DRG", "1","$contents[3]","$contents[4]","$contents[5]","1.000","0.000");
    }
 }

}
   

