$string = "[ 1 2 3 ]\n[ 2 2 -1 ]\n[ 1 1 1 ]\n";
  $matrix = Math::MatrixReal->new_from_string($string);
  print "$matrix";
