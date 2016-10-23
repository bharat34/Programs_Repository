
#!/usr/bin/perl

if (scalar @ARGV != 2) {
			print "\n";
			print "\t\tperl ChangeVisoneId.pl Myvisone.graphml residueNumbers\n";
			print "                residueNumbers file should contain two column => 1st column should be the same Id which is listed in your Myvisone.graphml and 2nd column should be the new Ids which you want to replace itto\n";
			print "\n";
			print "\n";
			exit;
		       }
open(F1,$ARGV[0]);
@alldata = <F1>;
close(F1);

open(F2,$ARGV[1]);

$Limit = 2 + 1;
for ($i = 2; $i < $Limit; $i++) {
				push @combine,"  \<key attr.name=\"Id".$i."\" attr.type=\"string\" for=\"node\" id=\"d".$i."\"\/\>\n"; 
			        }
$replace="d".$i;
$flag_1=1;

%FindTheRes= ();
while(<F2>) {
		split(/\s+/,$_);
		FindTheRes->{$_[0]} = $_[1];
            }
close(F2);
$count=0;

				
foreach $line (@alldata) {
				$flag=0;
				if($line=~/d1/ and $flag_1==1) { print $line; print @combine; $flag_1=0; next;}
				elsif($line=~/d2/) { $line =~s/d2/$replace/g; $flag=1; }
				elsif($line=~/d3/ and $flag != 1) { $a = $i+1; $line =~s/d3/d$a/g; $flag=1;}
				elsif($line=~/d4/ and $flag != 1) { $a = $i+2; $line =~s/d4/d$a/g; $flag=1;}
				elsif($line=~/d5/ and $flag != 1) { $a = $i+3; $line =~s/d5/d$a/g; $flag=1;}
				elsif($line=~/d6/ and $flag != 1) { $a = $i+4; $line =~s/d6/d$a/g; $flag=1;}
				elsif($line=~/d7/ and $flag != 1) { $a = $i+5; $line =~s/d7/d$a/g; $flag=1;}
				elsif($line=~/d8/ and $flag != 1) { $a = $i+6; $line =~s/d8/d$a/g; $flag=1;}
				elsif($line=~/d9/ and $flag != 1) { $a = $i+7; $line =~s/d9/d$a/g; $flag=1;}
				elsif($line=~/d10/ and $flag != 1) { $a = $i+8; $line =~s/d10/d$a/g; $flag=1;}
				elsif($line=~/d11/ and $flag != 1) { $a = $i+9; $line =~s/d11/d$a/g; $flag=1;}
				elsif($line=~/d12/ and $flag != 1) { $a = $i+10; $line =~s/d12/d$a/g; $flag=1;}
				elsif($line=~/d13/ and $flag != 1) { $a = $i+11; $line =~s/d13/d$a/g; $flag=1;}
				elsif($line=~/d14/ and $flag != 1) { $a = $i+12; $line =~s/d14/d$a/g; $flag=1;}
				elsif($line=~/<data key="d1">/) { print $line; split(/<data key="d1">/,$line); $_[1]=~s/\<\/data\>//g; $_[1]; $k = substr($_[1],0,length($_[1]-1)); $J = $FindTheRes{$k},"\n" if ( exists $FindTheRes{$k}); print "      \<data key=\"d2\"\>".$J."\<\/data\>\n"; next;}  
				elsif($line=~/d1&/ and $count==3) { print $line; print "      &amp;lt;data key=&amp;quot;d2&amp;quot;&amp;gt;&#13;\n"; $count++; next; }
				elsif($line=~/d1&/ and $count==2) { print $line; print "      &amp;lt;data key=&amp;quot;d2&amp;quot;&amp;gt;&#13;\n"; $count++; next; }
				elsif($line=~/d1&/ and $count==1) { print $line; print "      &amp;lt;data key=&amp;quot;d2&amp;quot;&amp;gt;&#13;\n"; $count++; next; }
				elsif($line=~/d1&/ and $count==0) { print $line; print "  &amp;lt;key for=&amp;quot;node&amp;quot; id=&amp;quot;d2&amp;quot; yfiles.type=&amp;quot;nodegraphics&amp;quot;/&amp;gt;&#13;\n"; $count++; next; }
				print $line;
			 }

close(F2);
