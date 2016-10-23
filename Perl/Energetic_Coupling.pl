
#!usr/bin/perl
# This Program calculates Positive, Negative, Neutral
# energetic coupling between all the sequence position.
# you need to provide three inputs in order to run this
# program, three inputs are Combine, reference sequence
# and the sequence length. 
#
#
#

if (scalar(@ARGV)!=3) {
			print "\n How to run the program";
			print "\n perl Energetic_Coupling.pl Combine ref sequence_length\n\n";
			exit;
		    }

open(F1,$ARGV[0])|| die("Can't open file:".$ARGV[0]);
while(<F1>) {
		next if(/^\w+/);
		($deltaG,$deltaKi)=split(/\s+/,$_);
		
		$Q += $deltaKi;
	    }
close(F1);

open(F1,$ARGV[1])|| die("Can't open file:".$ARGV[1]);
while(<F1>) {
		chomp;
		$ref_seq .= $_;
	    } 
close(F1);

$seq_len=$ARGV[2] || die("Could not find the length of the reference sequence");

%Ki_state;
%deltaG_state;

open(F1,$ARGV[0])|| die("Can't open file:".$ARGV[0]);
$_=<F1>;
$_=<F1>;
$_=<F1>;
$line=0;

while(<F1>) {
		chomp;
		$sequence = $_;
		
		$_=<F1>;
		chomp;
		$F_or_U=$_;

		
		$_=<F1>;
		chomp;
		($deltaG,$deltaKi)=split(/\s+/,$_);
		
		$j=0;
		next if($deltaG==0 and $deltaKi==1);

		#print  $sequence,"\n";
		#print  $F_or_U,"\n";
		#print  $deltaG," ",$deltaKi,"\n";
		$deltaKi /= $Q;
		#print "delataKi ",$deltaKi,"\n";

		#print $deltaKi,"\n";
		for($i = 0; $i <length($sequence); $i++) {
				$seq_pos = substr($sequence,$i,1);
				$State = substr($F_or_U,$j,1);

				#print $i+1," ",substr($sequence,$i,1)," ",substr($F_or_U,$j,1)," ",$deltaKi,"\n" if((length($sequence)) == $seq_len);
				#print $i+2," ",substr($sequence,$i,1)," ",substr($F_or_U,$j,1)," ",$deltaKi,"\n" if((length($sequence)) == $seq_len-1);
				#print $i+3," ",substr($sequence,$i,1)," ",substr($F_or_U,$j,1)," ",$deltaKi,"\n" if((length($sequence)) == $seq_len-2);
				$flag=0;
				$pos=0;

				if((length($sequence) == $seq_len) and (substr($sequence,$i,1) eq substr($ref_seq,$i,1))) { $flag=1; $pos=$i+1 }
				elsif((length($sequence) == $seq_len-1) and (substr($sequence,$i,1) eq substr($ref_seq,$i+1,1))) { $flag=1; $pos=$i+2}
				elsif((length($sequence) == $seq_len-2) and (substr($sequence,$i,1) eq substr($ref_seq,$i+2,1))) { $flag=1; $pos=$i+3; }
				
				if($flag==0) { print "FATAL ERROR: Please check the line no ",$line+1," ",$line+2," ",$line+3,"\n"; }			

				$j+=2;
				$Ki_state{$pos}{$State} += $deltaKi;

				#$deltaG_state{$i+1}{$State} += $deltaG;
					  }
		$line++;
	    }
close(F1);

foreach my $line (keys %Ki_state) {
        #print "$line: \n";
        foreach my $elem (keys %{$Ki_state{$line}}) {
	   #$Ki_state{$line}->{$elem} /= $Q;		
           #print "  $elem: " . $Ki_state{$line}->{$elem} . "\n";
        }
	   $F = $Ki_state{$line}->{'F'};
	   $U = $Ki_state{$line}->{'U'};
           #print log($F/$U)*2.3,"\n";
    }

#Positive Coupling
$deltaGpert=-2;
$phi_pert_k=exp(-2/(1.985877*298.16*0.001));

for ($i = 1; $i <= $seq_len; $i++) {
		$F1 = $Ki_state{$i}->{'F'};
		$U1 = $Ki_state{$i}->{'U'};
	for ($j = 1; $j <= $seq_len; $j++) {
		$F2 = $Ki_state{$j}->{'F'};
		$U2 = $Ki_state{$j}->{'U'};
		$numerator=$F1/$F2;
		$denominator=$U1/$U2;
		$K_fj_pertk = (($phi_pert_k *$numerator)/$denominator);
		print log($K_fj_pertk)," ";
		#print $i," ",$F1," ",$U1," ",$j," ",$F2," ",$U2," ",$numerator," ",$denominator," ",$K_fj_pertk, " ",log($K_fj_pertk),"\n";	
			}
		print "\n";
		}

print "\n\n\n";
#Negative coupling
for ($i = 1; $i <= $seq_len; $i++) {
		$F1 = $Ki_state{$i}->{'F'};
		$U1 = $Ki_state{$i}->{'U'};
	for ($j = 1; $j <= $seq_len; $j++) {
		$F2 = $Ki_state{$j}->{'F'};
		$U2 = $Ki_state{$j}->{'U'};
		$numerator=$F1/$U2;
		$denominator=$U1/$F2;
		$K_fj_pertk = ($numerator/$denominator);
		print log($K_fj_pertk)," ";
		#print $i," ",$F1," ",$U1," ",$j," ",$F2," ",$U2," ",$numerator," ",$denominator," ",$K_fj_pertk, " ",log($K_fj_pertk),"\n";	
			}
		print "\n";
		}
