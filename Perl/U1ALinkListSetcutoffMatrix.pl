
#!/usr/bin/perl
                          

if(@ARGV != 5) {
                        print "\n\t\t\tperl SetcutoffMatrix.pl ResidueFile1 correlationmatrix ResidueFile2 StartCutoff StepSize\n\n\n";
                        exit;
                }

my %U1A;
(%U1A) = (
'11'=>'B1',
'12'=>'B1,RNP2',
'13'=>'Crow,B1,RNP2',
'14'=>'Crow,B1,RNP2',
'15'=>'Crow,B1,RNP2',
'16'=>'Crow,L1,RNP2',
'17'=>'Crow,L1,RNP2',
'18'=>'L1,',
'19'=>'L1,',
'20'=>'L1,',
'21'=>'Crow,L1,',
'22'=>'L1,',
'23'=>'ah1',
'24'=>'ah1',
'25'=>'ah1',
'26'=>'Crow,ah1',
'27'=>'ah1',
'28'=>'ah1',
'29'=>'ah1',
'30'=>'ah1',
'31'=>'ah1',
'32'=>'ah1',
'33'=>'ah1',
'34'=>'Crow,ah1',
'35'=>'ah1',
'36'=>'ah1',
'37'=>'ah1',
'38'=>'Crow,L2',
'39'=>'L2',
'40'=>'B2',
'41'=>'B2',
'42'=>'B2',
'43'=>'B2',
'44'=>'Crow,B2',
'45'=>'Crow,B2',
'46'=>'L3',
'47'=>'L3',
'48'=>'Crow,L3',
'49'=>'L3',
'50'=>'L3',
'51'=>'L3',
'52'=>'Crow,L3,RNP1',
'53'=>'Crow,L3,RNP1',
'54'=>'Crow,L3,RNP1',
'55'=>'Crow,B3,RNP1',
'56'=>'Crow,B3,RNP1',
'57'=>'Crow,B3,RNP1',
'58'=>'B3,RNP1',
'59'=>'B3,RNP1',
'60'=>'L4',
'61'=>'L4',
'62'=>'ah2',
'63'=>'ah2',
'64'=>'ah2',
'65'=>'ah2',
'66'=>'ah2',
'67'=>'ah2',
'68'=>'Crow,ah2',
'69'=>'ah2',
'70'=>'ah2',
'71'=>'ah2',
'72'=>'Crow,ah2',
'73'=>'L5',
'74'=>'Crow,L5',
'75'=>'L5',
'76'=>'L5',
'77'=>'L5',
'78'=>'L5',
'79'=>'Crow,L5',
'80'=>'L5',
'81'=>'L5',
'82'=>'Crow,L5',
'83'=>'B4',
'84'=>'B4',
'85'=>'B4',
'86'=>'B4',
);


	open(F1,$ARGV[0]);
	@val=<F1>;
	chomp(@val);
	close(F1);
	
	$max=0;
	open(F2,$ARGV[1]);
	$j=0;
	while(<F2>) {
			@matrix = split(/\s+/,$_);
			for ($i = 0; $i < scalar(@matrix); $i++) {
								  next if($i==$j);
								  $max = $matrix[$i] if($matrix[$i] > $max);
								 }
			$j++;
		    }
	close(F2);

	$j=0;
	open(F1,$ARGV[2]);
	@AA=<F1>;
	chomp(@AA);
	close(F1);

	$StartPoint=$ARGV[3];
	$BinSize=$ARGV[4];


for ($j = $StartPoint; $j <= $max; $j += $BinSize) {
open(F2,$ARGV[1]);
	($part1,$part2) = split(/\./,$ARGV[1]);
	open(FW,">LinkList".$part1.$j."Cutoff.txt");
	$count=0;
while(<F2>)
        {
                next if(/^\s+$/);
                @d=split(/\s+/,$_);
                for ( $i = 0; $i < scalar(@val); $i++)
                {
                        next if($d[$i]=~/\s/);
                        $var1=$val[$count];
                        $var2=$val[$i];
			next if($var1==$var2);
                        $value1 = $U1A{$var1} if(exists $U1A{$var1});
                        $value2 = $U1A{$var2} if(exists $U1A{$var2});
			$join=undef;
			$join = $var1." ".$value1." ".$var2." ".$value2 if(exists $U1A{$var1} and (exists $U1A{$var2}));
			$join = "null",$value1=null,$value2=null if($join==null);
                        #print FW $var1,";",$var2,";",$AA[$count],";",$join,"\n" if($d[$i] > $j);
			$g1 = $var1." ".$value1;
			$g2 = $var2." ".$value2;
			print FW $g1,";",$g2,";",$AA[$count],";",$var1,"\n" if($d[$i] > $j);
                }
                $count++;

        }
        close(F2);
	close(FW);
}
