#!/usr/bin/perl
	
$k=0;
for ( $i = 0; $i < 67; $i++)
{
	if($i==0) { 
			open(F1,$ARGV[0]);
			$_=<F1>;
			print $_;
			close(F1);
			next;
		  }
			
	$k++;
					open(F1,$ARGV[0]);
					$index = $k - 1;
	for ( $m=0; $m < $k; $m++) {
					$_=<F1>;
					chomp($_);
					split(/\t+/,$_);
					print $_[$index],"\t";
					$index--;
				    }
	$_=<F1>;
	print $_;
	close(F1);
}
