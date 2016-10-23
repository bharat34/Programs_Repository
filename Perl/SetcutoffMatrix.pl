
#!/usr/bin/perl

if(@ARGV != 5) {
                        print "\n\t\t\tperl SetcutoffMatrix.pl ResidueFile1 correlationmatrix ResidueFile2 StartCutoff StepSize\n\n\n";
                        exit;
                }

my %U1A;
(%U1A) = (
'322'=>'PDZ',
'323'=>'PDZ',
'325'=>'PDZ',
'327'=>'PDZ',
'329'=>'PDZ',
'330'=>'PDZ',
'336'=>'PDZ',
'347'=>'PDZ',
'351'=>'PDZ',
'353'=>'PDZ',
'359'=>'PDZ',
'362'=>'PDZ',
'363'=>'PDZ',
'364'=>'PDZ',
'372'=>'PDZ',
'375'=>'PDZ',
'376'=>'PDZ',
'379'=>'PDZ',
'386'=>'PDZ',
'388'=>'PDZ',
);


	open(F1,$ARGV[0]);
	@val=<F1>;
	chomp(@val);
	close(F1);

	open(F1,$ARGV[2]);
	@AA=<F1>;
	chomp(@AA);
	close(F1);

	$count=0;
	$StartPoint=$ARGV[3];
	$BinSize=$ARGV[4];


$max=0;
open(F2,$ARGV[1]);
while(<F2>)
        {
                next if(/^\s+$/);
                @d=split(/\s+/,$_);
               for ( $i = 0; $i < scalar(@d); $i++)
                {
			$max=$d[$i] if($max<$d[$i]);
		}
	}
close(F2);

for ($j = $StartPoint; $j <= $max; $j += $BinSize) {
			open(F2,$ARGV[1]);
			($part1,$part2) = split(/./,$ARGV[1]);
			open(FW,">LinkList".$part1.$j."Cutoff.txt");
			$count=0;
while(<F2>)
        {
                next if(/^\s+$/);
                @d=split(/\s+/,$_);
                for ( $i = 0; $i < scalar(@val); $i++)
                {
                        next if($d[$i]=~/\s/);
			$value1=undef; $value2=undef;
                        $var1=$val[$count];
                        $var2=$val[$i];
                        $value1 = $U1A{$var1} if(exists $U1A{$var1});
                        $value2 = $U1A{$var2} if(exists $U1A{$var2});
			$join=undef;
			#$join = $var1."=>".$value1."; ".$var2."=".$value2 if(exists $U1A{$var1} or (exists $U1A{$var2}));
			#$join = "null" if($join==null);
			$join = $value1.$value2;
                        print FW $var1,";",$var2,";",$AA[$count],";",$join,"\n" if($d[$i] > $j);
                }
                $count++;

        }
        close(F2);
	close(FW);
}
