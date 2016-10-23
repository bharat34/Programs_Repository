#!/usr/bin/perl
	

$cmd="./covariance_crowder ".$ARGV[0]." | grep \"(\" > raw_score";
system($cmd);

@raw_score = ();
open(F1,"raw_score");
$line=<F1>;
while($line=<F1>) {
                chomp;
                $line=~s/\(//g;
                $line=~s/\)//g;
                ($a,$b)=split(/=/,$line);
                ($c,$d)=split(/,/,$a);
                $c=~s/\s+//g;
                $d=~s/\s+//g;
                ($e,$f)=split(/,/,$b);
                push(@raw_score,$e);	
            }
close(F1);

open(F2,"list");
@random_score = ();
@random_score_average = ();

$FileCount=0;
while(<F2>) {
		chomp;
		$cmd="cat ".$_." \| egrep \-v \"\>\" \> temp_sequence";
		system($cmd);
		$cmd="./covariance_crowder temp_sequence | grep \"(\" > raw_score";
		system($cmd);
		
		$k = 0;
		open(F1,"raw_score");
		$line=<F1>;
while($line=<F1>) {
                chomp;
                $line=~s/\(//g;
                $line=~s/\)//g;
                ($a,$b)=split(/=/,$line);
                ($c,$d)=split(/,/,$a);
                $c=~s/\s+//g;
                $d=~s/\s+//g;
                ($e,$f)=split(/,/,$b);
		$random_score[$k] += $e;
		$k++;
	    }
		$FileCount++;
	    }
close(F2);

$k=0;
foreach $line (@random_score) {
		$random_score_average[$k] = $line/$FileCount;
		$k++;
		}


for ($i = 0; $i < $k; $i++) { 
		
		$raw_score[$i] -= $random_score_average[$i];
				}


$k=0;
open(F1,"raw_score");
$_=<F1>;
while(<F1>) {   
                chomp;
                $_=~s/\(//g;
                $_=~s/\)//g;
                ($a,$b)=split(/=/,$_);
                ($c,$d)=split(/,/,$a);
                $c=~s/\s+//g;
                $d=~s/\s+//g;
                ($e,$f)=split(/,/,$b);
                $array[$c-1][$d-1] = $raw_score[$k];
		$k++;
          }
close(F1);


for($i = 0; $i <= $#array; $i++){
	   for($j = 0; $j <= $#{$array[0]} ; $j++){
	      print "$array[$i][$j] \t";
	   }
	   print "\n";
	}
