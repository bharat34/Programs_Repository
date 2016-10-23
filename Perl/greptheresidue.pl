
#!/usr/bin/perl

open(F1,$ARGV[0]);
@val1=<F1>;
chomp(@val1);
close(F1);


open(F2,$ARGV[1]);
@val2=<F2>;
chomp(@val2);
close(F2);
foreach $line1 (@val1) {
			
foreach $line3 (@val1) {
			 	$add=$line1." ".$line3;
				($vall,$a,$b) = grep(/$add/,@val2);
				($a) = split(/\s+/,$vall);
				if($a <= 10) { print "1\t"; }
				else { print "0\t"; }
			}
				print "\n";
			}
