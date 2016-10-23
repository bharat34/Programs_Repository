
#!/usr/bin/perl

open(F1,$ARGV[0]);
@val=<F1>;
chomp(@val);
close(F1);

	$count=0;

open(F2,$ARGV[1]);
open(F3,">In_One_Line".$ARGV[1]);
	while(<F2>)
	{
		@d=split(/\s+/,$_);
		for ( $i = 0; $i < scalar(@val); $i++)
		{
			#print $d[$i+1]," ",$val[$count]," ",$val[$i],"\n";		
			#print F3 $val[$count]," ",$val[$i]," ",abs($d[$i+1]),"\n";		
			print F3 $val[$count]," ",$val[$i]," ",($d[$i]),"\n";		
		}
		$count++;
		
	}
	close(F2);
	close(F3);
