
#!/usr/bin/perl


open(F2,$ARGV[1]);
open(F3,">temp.fasta");

	while(<F2>)
	{
		chomp;
		print F3 "\n",$_,"\n" if(/^>/);
		print F3 $_ if(!/^>/);
	}
close(F2);
close(F3);

	system("cat juvenile_list_highexpr.txt | xargs -i egrep -A 1 \">{}\" temp.fasta > result.fasta");
	print "check the  result.fasta file";
