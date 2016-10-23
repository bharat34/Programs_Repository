
#!/usr/bin/perl



open(F2,$ARGV[0]);
	while(<F2>)
	{
		@d=split(/\s+/,$_);
		#shift(@d);
		push @data, [ @d ];
	}
	close(F2);

	$increment=-1.00;
	print $increment,"\t";
	push(@val,$increment);
while(true) {
	 	$increment += 0.01; 
		print $increment,"\t";
		push(@val,$increment);
		last if($increment eq 1);
	    }

	$val[100] = 0.0;
	@add_data = ();
for $i ( 0 .. $#data ) {
        for ($nk = 0; $nk < scalar(@val); $nk++) {
							$add_data[$i][$nk] =0;
						 }
			}
	
for $i ( 0 .. $#data ) {
     for $j ( 0 .. $#{ $data[$i] } ) {
	for ($nk = 0; $nk < scalar(@val); $nk++) {
         						#print "elt $i $j is $data[$i][$j]\n" if($data[$i][$j] >= $val[$nk] and $data[$i][$j] <= $val[$nk+1])
							$add_data[$i][$nk] += 1 if($data[$i][$j] >= $val[$nk] and $data[$i][$j] <= $val[$nk+1]);
						 }
     				     }
 			}

for $i ( 0 .. $#data ) {
	for ($nk = 0; $nk < scalar(@val); $nk++) {
							print $add_data[$i][$nk],"\t";
						 }
			print "\n";
			}			
