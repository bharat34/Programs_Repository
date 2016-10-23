#!/usr/bin/perl


my @products (
    {
        name      => "Floor Wax",
        wholesale => "50.00",
        retail    => "75.00",
    },
    {
        name      => "Paper Towel",
        wholesale => "20.00",
        retail    => "40.00",
    },
    {
        name      => "Hand Soap",
        wholesale => "30.00",
        retail    => "65.00",
   }
);

my @sorted_by_name = map{$_->[1]}
      sort {$a->[0] cmp $b->[0]}
      map{[$_->{name},$_]} @products

my @sorted_by_wholesale = map{$_->[1]}
      sort {$a->[0] <=> $b->[0]}
      map{[$_->{wholesale},$_]} @products
