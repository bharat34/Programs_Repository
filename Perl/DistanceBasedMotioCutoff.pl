#!/usr/bin/perl
# This programs take first column spaced amber generated motion and inter atomic distance matrix returns
# three seperated file in ver1 you have zero only for phsically connected residues, ver2 has zero
# phsically and inter atomic distance based (zero if the distance is 3.5A), ver3 contains  
# zero along with zero for negative values
#
#
#

@distMATRIX=[];
$cutoff=10;
$i=0;

open(F1,$ARGV[0]);
while(<F1>) {
	chomp($_);
	@matrix=split(/\s+/,$_);
	#print $_,"n";
	for ($j = 1; $j <= scalar(@matrix); $j++) {
		$distMATRIX[$i][$j-1] = $matrix[$j-1];
						}
	$i++;
	}

close(F1);
	
@corrMATRIX=[];
$nega_mean=0;
$pos_mean=0;
$nega_count=0;
$pos_count=0;

$i=0;
open(F2,$ARGV[1]);
while(<F2>) {
	chomp($_);
	@matrix=split(/\s+/,$_);
	for ($j = 1; $j <= scalar(@matrix); $j++) {
		$corrMATRIX[$i][$j-1] = abs($matrix[$j-1]);
		#print $corrMATRIX[$i][$j-1],"\n";
		if($matrix[$j-1] < 0) { $nega_mean += $matrix[$j-1]; $nega_count++; }
		if($matrix[$j-1] > 0) { $pos_mean += $matrix[$j-1]; $pos_count++; }
		
						}
	#print "\n";
	$i++;
	}

print "Total rows ",$i,"\n";
#print "Negative Mean ",$nega_mean," ",$nega_count," ",$nega_mean/$nega_count,"\n";
print "Positive Mean ",$pos_mean," ",$pos_count," ",$pos_mean/$pos_count,"\n";

for ($a = 0; $a <= $i; $a++) {
	for ($b = 0; $b < $i; $b++) {
			$corrMATRIX[$a][$b] = 0 if($distMATRIX[$a][$b] < $cutoff);
			#print $corrMATRIX[$a][$b]," ", $distMATRIX[$a][$b],"\n";
			#$corrMATRIX[$a][$b] =0 if($corrMATRIX[$a][$b] > 0);
			#print "$corrMATRIX[$a][$b] \n" if($corrMATRIX[$a][$b] > 0);
				    }
			   }

open(F3,">ver1".$ARGV[1]);
$e=-1; $f=0; $g=1;
for ($a = 0; $a <= $i; $a++) {
        for ($b = 0; $b <= $i; $b++) {
                        print F3 $corrMATRIX[$a][$b],"\t";
                                    }
                        $e++; $f++; $g++;
                        print F3 "\n";
                            }
close(F3);

#open(F3,">ver2".$ARGV[1]);
#$e=-1; $f=0; $g=1;
#for ($a = 0; $a <= $i; $a++) {
#	for ($b = 0; $b <= $i; $b++) {
#			$corrMATRIX[$a][$b]=0 if($b==$e or $b==$f or $b==$g);
#			print F3 $corrMATRIX[$a][$b],"\t";
#				    }
#			$e++; $f++; $g++;
#			print F3 "\n";
#			    }
#close(F3);
#
#open(F3,">ver3".$ARGV[1]);
#$e=-1; $f=0; $g=1;
#for ($a = 0; $a <= $i; $a++) {
#	for ($b = 0; $b <= $i; $b++) {
#			$corrMATRIX[$a][$b]=0 if($b==$e or $b==$f or $b==$g);
#			$corrMATRIX[$a][$b]=0 if($corrMATRIX[$a][$b] < 0);
#			print F3 abs($corrMATRIX[$a][$b]),"\t";
#				    }
#			$e++; $f++; $g++;
#			print F3 "\n";
#			    }
#close(F3);
