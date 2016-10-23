#!/usr/bin/perl


open(F1,$ARGV[0])|| die("Can't open file:".$ARGV[0]);

while(<F1>) {
		chomp;
		push(@MSA,$_);
	    }
close(F1);

open(F2,">Final".$ARGV[0])|| die("Can't open file:".$ARGV[0]);

for ($i =0; $i < scalar(@MSA); $i++) {
					next if(@MSA[$i]=~/^none/);
					#print @MSA;
					($fasta1,$sequence1) = split(/\s+/,$MSA[$i]);
					#print "here i $i\n";
for ($j =$i+1; $j < scalar(@MSA); $j++) {
					next if(@MSA[$j] =~/^none/);	
					($fasta2,$sequence2) = split(/\s+/,$MSA[$j]);
					$match=0;
					$mismatch=0;
					#print $sequence1,"\n",$sequence2,"\n";
for($a=0; $a < (length($sequence1) && length($sequence2)); $a++) {
						next if((substr($sequence1,$a,1))=~/[a-z]/);
						next if((substr($sequence2,$a,1))=~/[a-z]/);
					  	if((substr($sequence1,$a,1)=~/\w/) and (substr($sequence2,$a,1)=~/\w/) and (substr($sequence1,$a,1) eq substr($sequence2,$a,1))){
						#print substr($sequence1,$a,1),"\t",substr($sequence2,$a,1),"\n";
								$match++;
				       								}
					  	elsif((substr($sequence1,$a,1)=~/\w/) and (substr($sequence2,$a,1)=~/\w/)){
								#print "mismatch",substr($sequence1,$a,1),"\t",substr($sequence2,$a,1),"\n";
								$mismatch++;
											        }
					  	elsif((substr($sequence1,$a,1)=~/\w/)){
								#print "mismatch",substr($sequence1,$a,1),"\t",substr($sequence2,$a,1),"\n";
								#print F2 substr($sequence1,$a,1),"\n";
								$mismatch++;
											        }
					  	elsif((substr($sequence2,$a,1)=~/\w/)){
								#print "mismatch",substr($sequence1,$a,1),"\t",substr($sequence2,$a,1),"\n";
								#print F2 substr($sequence2,$a,1),"\n";
								$mismatch++;
											        }
								}
								#print F2 $match,"\t",$match+$mismatch,"\n";
								$Identity=($match/($match+$mismatch))*100;
								if($Identity > 90) {
											@MSA[$j] = "none\tnone";
										   }	
								#print $Identity,"\n";
					 }
						#print "\n";
				        }

foreach $sequence(@MSA) {
			next if($sequence=~/^none/);
			print F2 $sequence,"\n";
			 }
print "Please check the Fianl".$ARGV[0]." file for result\n";
close(F2);
