open(F1,$ARGV[0]);
@val=<F1>;
close(F1);


for ($k=1; $k<=32; $k++) {
	print $k,"\n";;
	$linee=0;
	@d=();
open(F1,$ARGV[1]);
while(<F1>) {
	chomp;
	@data=split(/,/,$_);
	for ($i=0; $i <scalar(@data) ; $i++) {
	$data[$i]=~s/\s+//g;
	if($k==$data[$i]) {
	$val[$linee]=~s/\n//g;
	print $val[$linee],",";
			}
	}
	$linee+=1;
}
	print "\n";
close(F1);
}
