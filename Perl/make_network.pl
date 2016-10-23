#!/usr/bin/perl

		
	open(F2,$ARGV[0]) or die;
	@data1 = reverse sort(<F2>);
	close(F2);

	
	@an_array = ();
	open(F3,$ARGV[1]) or die;

	 
	$cutoff = 500;
	$exit1 = 0;
	@new_data;
	
	foreach $_(@data1) {
				last if($exit1==500);
				split(/\s+/,$_);
				next if($_[0]=~/E/);
				push(@new_data,$_[1]." ".$_[2]);
				push(@new_data,$_[3]." ".$_[4]);
				$exit1++;
			   }

		
	my @unique = grep { not $seen{$_} ++ } @new_data;
	%hash1 = map {split ' ', $_, 2} @unique;
	%hash2 = map {split ' ', $_, 2} @unique;
	$flick=undef;
	
	for $key1 ( sort {$a<=>$b} keys %hash1) {
							push(@store,$key1." ".$hash1{$key1}."\n");
							print $key1." ".$hash1{$key1}."\n";
							
						}
	$count1=0; $count3=0; $count4 =0;
	($a1,$b1) = split(/\s+/,$store[$count1]);
	($a2,$b2) = split(/\s+/,$store[$count4]);
	 $fg=0;

	exit;


	while(<F3>) {
			 split(/\s+/,$_);
			 $count++;
			 if($count%223 == 0 and $fg ==1 ) { 
								$fg=0; 
								$count3++; 
								$count1 = $count3; 
								$count4 = 0;
								($a1,$b1) = split(/\s+/,$store[$count1]); 
								($a2,$b2) = split(/\s+/,$store[$count4]);
							  }
			 
			 if($a1 == $_[1] and $b1 eq $_[2] and $a2 == $_[3] and $b2 eq $_[4]) {
							#	print $a1," ",$_[1]," ",$b1," ",$_[2]," ",$a2," ",$b2,"\n";
								$count1++;
								$count4++;
								($a2,$b2) = split(/\s+/,$store[$count4]);
								 $fg=1;
							 }
			 if($a1 == $_[1] and $b1 eq $_[2] and $a1 == $_[3] and $b1 eq $_[4]) {
								print $a1," ",$_[1]," ",$b1," ",$_[2]," ",$a2," ",$b2,"\n";
							}
		    }
	close(F3);
	
	print scalar(@store),"\n";
	print (@store),"\n";
	exit;

	print "Sector Thing\n";
	$total=0;
	
	for $key1 ( sort {$a<=>$b} keys %hash1) {
        for $key2 ( sort {$a<=>$b} keys %hash2) {
							$flag = 0;
							@make_line = ();

		      				if($key1==$key2 or $key1+1 == $key2 or $key1+2 == $key2 ) {
													    push(@make_line,$key2." ".$hash2{$key2});
													    $flag=1;
								       					  }
						 
					#	@add_on=();
					#	($val, $k, $l, $m, $n) = grep(/$key1 $hash1{$key1} $key2 $hash2{$key2}$/,@pairedDistance);
					#	push(@add_on,$val);
	
					#	 if(substr($val,0,5) < 10) {
					#				push(@make_line,$key2." ".$hash2{$key2});
					#				print @add_on;
					#		        }
						if($flag==1) {	
								$scalar = delete $hash2{$key2};
								$key1 = $key2;
							     }
							      }
							push @an_array, [@make_line] if($flag==1);
						}
	print $total,"\n";
