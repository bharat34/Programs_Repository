
#!/usr/bin/perl

@ARRAY=[];
$len=$ARGV[0];

for ($i=1; $i<=$len; $i++) {
	for ($j=1; $j<=$len; $j++) {
			$ARRAY[$i][$j]=0;
				 }
			  }


open(F1,$ARGV[1]);
$i=0;
$j=0;
$_=<F1>;
@compare1=split(/\s+/,$_);
%hash= ();
@hash;

while(<F1>) {
		chomp;
		@data= split(/\s+/,$_);
		$j=1;
	for($i=2; $i <scalar(@data); $i++) {
						if ($data[$i]==1) {
						$a=$data[0]-300;
						$b=$compare1[$j]-300;
						$ARRAY[$a][$b]=1;
						#push($a." ".$b)
						#hash->{$a}=$b;
						#print $a," ",$b,"\n";
								}
						$j+=2;
					   }
		
		#$ARRAY[$i][$j]=$_;
		#$ARRAY[$j][$i]=$_;
		#$i++;
	    }
close(F1);
for ($i=1; $i<=$len; $i++) {
        for ($j=1; $j<=$len; $j++) {
                        print $ARRAY[$i][$j]," ";
                                 }
			print "\n";
                          }

#use Data::Dumper;
#print Dumper(\%hash);
#foreach $line (keys %hash) {
#				print $line," ",$hash{$line},"\n";
#				}

#for $g ( 0 .. $#ARRAY ) {
#for $h ( 0 .. $#{$ARRAY[$g]} ) {
#		print $ARRAY[$g][$h]," ",$ARRAY[$h][$g],"\n"
#		}
#}

