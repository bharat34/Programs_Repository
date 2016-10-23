#!/usr/bin/perl
	
open(F1,$ARGV[0]);

	while($resno=<F1>) {
			chomp($resno);
			open(F2,$ARGV[1]);
			$_=<F2>;
			while(<F2>) {	
					chomp($_);
					split(/\t/,$_);
					if ($resno==$_[0]) {split(/\s+/,$_); print $_[2],"\t";}    
				    }
			close(F2);
			print "\n";
		   }
	close(F1);
