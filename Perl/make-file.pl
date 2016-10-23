open(F1,$ARGV[0]);
$a=2129;
while(<F1>) { chomp; split(/\s+/,$_); if($a!=$_[1]-1) {print "trajin 1NF3_CRIB_postleap_combi_5-105ns.mdcrd ",$b," ",$a,"\n"; $b=$_[1];} $a=$_[1]; }
close(F1);
