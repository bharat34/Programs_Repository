
#!/usr/bin/perl

open(F1,$ARGV[0]);
@val=<F1>;
#chomp(@val);
close(F1);

%seen = ();
foreach $item (@val) {
			split(/\s+/,$item);
			next if($_[1]==$_[3]);
			next if($_[1]==$_[3]-1 or $_[1] == $_[3]+1);
			next if($_[1]==$_[3]-2 or $_[1] == $_[3]+2);
    			push(@uniq, $item) unless $seen{$item}++;
		     }	

	print @uniq;
