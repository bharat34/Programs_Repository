#!/usr/bin/env perl


use PDL;
  $a = ones(3,3);
	print $a;
  $b = $a->slice('-1:0,(1)');
	print $b;
  $c = $a->dummy(2);
	print $c;
	

