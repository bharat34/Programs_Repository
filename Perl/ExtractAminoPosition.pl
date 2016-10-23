
#!/usr/bin/perl

open(F1,$ARGV[0]);
@val=<F1>;
chomp(@val);
close(F1);


open(F2,$ARGV[1]);
	while(<F2>)
	{
		@d=split(/\s+/,$_);
		shift(@d);
		push @data, [ @d ];
	}
	close(F2);


for ( $i = 0; $i < scalar(@val); $i++) 
{
#	print $val[$i],"\n";
	$m = $val[$i]  ;
	for ( $j = 0; $j < scalar(@val); $j++) 
	{
		
		$n = $val[$j]  ;
		#print $n,"\t";
		 printf "%7.2f",abs($data[$m][$n]);	
	}
	print "\n";
}
