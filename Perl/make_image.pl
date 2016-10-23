

open(F1,$ARGV[0]);
while(<F1>) {
		($abbre,$res) = split(/\t/,$_);
		(@res) = split(/\,/,$res);
		
open(F2,">".$abbre.".pml");


# Pymol script for representing the sectors of 1BE9.
#print F2 "load 1BE9.pdb\n";
print F2 "rotate y,240\n";
print F2 "bg_color white\n";
print F2 "show cartoon, (chain A)\n";
print F2 "\n";

print F2 "color white\n";
print F2 "\n";
print F2 "create sector_1, (resi ";

foreach (@res) {
		chomp($_);
		print F2 $_,",";
		}


print F2 ")& (chain A)\n\n";
print F2 "show surface, sector_1\n";

foreach (@res) {
		chomp($_);
		print F2 "set_color colres".$_.", [0,0,1]\n";
		print F2 "color colres".$_.", (resi ".$_.")& (chain A)\n\n";
		}

print F2 "set transparency, 0.4\n";
print F2 "set stick_radius, 0.4\n";
print F2 "show stick, (chain B)\n";
print F2 "util.cbay main and chain B\n";
print F2 "set two_sided_lighting, 1\n";
print F2 "set sphere_quality, 2\n";
print F2 "set surface_quality, 2\n";
print F2 "set stick_quality, 10\n";
print F2 "set cartoon_oval_quality, 10\n";
print F2 "set cartoon_loop_quality, 6\n";
print F2 "hide lines,all\n";
print F2 "set_view (\\
	-0.880436897,    0.134605691,    0.454657406,\\
	0.111319803,    0.990739465,   -0.077750385,\\
	-0.460912317,   -0.017842097,   -0.887267053,\\
	0.000000000,    0.000000000, -104.157783508,\\
	35.284568787,   61.732337952,   29.176891327,\\
	88.666572571,  119.648986816,  -20.000000000 )";

print F2 "\n";
print F2 "ray 2400, 2400\n";
print F2 "select BB,chain B\n";
print F2 "hide everything,BB\n";
print F2 "show sticks,BB\n";
print F2 "png $abbre.png, dpi=300";

close(F2);
#system("pymol -cq pymol.pml");
#exit;
}
close(F1);
