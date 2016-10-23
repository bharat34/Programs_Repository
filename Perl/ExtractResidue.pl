
#!/usr/bin/perl

open(F1,$ARGV[0]);

open(F2,$ARGV[1]);

$b=<F2>;
chomp($b);



while(<F1>) {
		split(/\s+/,$_);
		#print "if($b+20==$_[4]){ \n"; 
		if($b==$_[4]-20 and $_[2] eq CA ){ 
						printf  "%-6s%5s %-5s%-5s %3d%12.3f%8.3f%8.3f\n",$_[0],$_[1],$_[2],$_[3],$b,$_[5],$_[6],$_[7];
						$flag=1;
						 }
		if($b!=$_[4]-20 and $flag==1){ 
						$b=<F2>;
						chomp($b);
						$flag=0
					     }
	    }
close(F1);
close(F2);
