
#!/usr/bin/perl

open(F1,"1stcol_3TGI");
@red=<F1>;
chomp(@red);
close(F1);

open(F1,"2ndcol_3TGI");
@blue=<F1>;
chomp(@blue);
close(F1);

open(F1,"3rdcol_3TGI");
@green=<F1>;
chomp(@gren);
close(F1);

$count=0;
$red1;$green1;$blue1;
@redS;@greenS;@blueS;
$flag1;$flag2;$flag3;
@pseudo_sector_dummy;
@pseudo_sector;
		
	open(F2,$ARGV[0]) or die;
	while(<F2>)
	{
		$flag = 0;
		$flag1 = 0;
		$flag2 = 0;
		$flag3 = 0;
		split(/\s+/,$_);
		for ( $i = 0; $i < scalar(@red); $i++)
		{
			($no,$res) = split(/\s+/,$red[$i]);
			 if($no == $_[1] and $res eq $_[2] or $no == $_[3] and $res eq $_[4]) { 
					$redS[$i] .= "\t\t".$_,"\n";
					$flag=1;
					$flag1=1;
											      }
		}
		
		for ( $i = 0; $i < scalar(@blue); $i++)
		{
			($no,$res) = split(/\s+/,$blue[$i]);
			 if($no == $_[1] and $res eq $_[2] or $no == $_[3] and $res eq $_[4]) { 
					$blueS[$i] .= "\t\t".$_,"\n";
					$flag=1;
					$flag2=1;
											      }
		}

		for ( $i = 0; $i < scalar(@green); $i++)
		{
			($no,$res) = split(/\s+/,$green[$i]);
			 if($no == $_[1] and $res eq $_[2] or $no == $_[3] and $res eq $_[4]) { 
					$greenS[$i] .= "\t\t".$_,"\n";
					$flag=1;
					$flag3=1;
											      }
		}

		$count++  if($flag==0);
		$red1++   if($flag1==1);
		$blue1++  if($flag2==1);
	        $green1++ if($flag3==1);

					$flag1=0;

		if($flag == 0) {
				  push(@pseudo_sector,$_) if(scalar(@pseudo_sector)==0);
				  push(@pseudo_sector_dummy,$_) if(scalar(@pseudo_sector)==0);
				  for ( $i = 0; $i < scalar(@pseudo_sector); $i++)
				  {
					(undef,$no,$res) = split(/\s+/,$pseudo_sector[$i]);
					# print $no,"\t",$res,"\n";

			 			if($no == $_[1] and $res eq $_[2] or $no == $_[3] and $res eq $_[4]) {
															$flag1=1;
														     }
						if($flag1==1) {
								$pseudo_sector_dummy[$i] .= $_;		
								last;
							      }
				  }
				   #print $i,"\n";
				   push(@pseudo_sector,$_) if($flag1==0);	
				   $pseudo_sector_dummy[$i] .= $_ if($flag1==0);	
				  	
			       } 
	}
	close(F2);
				#print @pseudo_sector;
	        for ( $i = 0; $i < scalar(@pseudo_sector); $i++) {
									print $pseudo_sector[$i],"\t",$pseudo_sector_dummy[$i],"\n\n";
								 }
				exit;

							print "Red Sector\n";
		for ( $i = 0; $i < scalar(@red); $i++) {
								print $red[$i],"\t",$redS[$i],"\n\n";
						        }
							print "Blue Sector\n";
		for ( $i = 0; $i < scalar(@blue); $i++) {
								print $blue[$i],"\t",$blueS[$i],"\n\n";
							 } 
							 print "Green Sector\n";
		for ( $i = 0; $i < scalar(@green); $i++) {
								print $green[$i],"\t",$greenS[$i],"\n\n";
							 }
		print "In Red: $red1\n";
		print "In Blue: $blue1\n";
		print "In Green: $green1\n";
		print "pseudo sector: $count\n";
