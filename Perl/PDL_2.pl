#!/usr/bin/perl    # -*-EPerl-*-

use PDL;

my @becteams = (
    'Pittsburgh',
    'Louisville',
    'Rutgers',
    'West Virginia',
    'South Florida',
    'Connecticut',
    'Syracuse',
    'Cincinnati'
);

# $C is the Colley Matrix. It depends only on the schedule
# of games already played. Rows and columns are indexed in
# the same order, by teams. The diagonal elements are the
# number of games played plus two. Off-diagonals are zero 
# for no game yet played for the indexed teams, or minus one
# for a game played. It contains nothing about the result of
# the games. It's obviously a symmetric matrix.
my $C = pdl([
   # UP UL RU WV SF CT SU UC
    [ 5, 0,-1, 0, 0, 0,-1,-1], # Pittsburgh
    [ 0, 4, 0, 0, 0, 0,-1,-1], # Louisville
    [-1, 0, 4, 0,-1, 0, 0, 0], # Rutgers
    [ 0, 0, 0, 4, 0,-1,-1, 0], # West Virginia
    [ 0, 0,-1, 0, 5,-1, 0,-1], # South Florida
    [ 0, 0, 0,-1,-1, 4, 0, 0], # Connecticut
    [-1,-1, 0,-1, 0, 0, 5, 0], # Syracuse
    [-1,-1, 0, 0,-1, 0, 0, 5]  # Cincinnati
]);

# $wl is a column vector containing win and loss information.
# For each team in the same order as $C is indexed, the value
# is numerically 1 + (wins - losses)/2.
my $wl = pdl([[ 3/2],[ 2 ],[ 2 ],[ 2 ],[ 1/2],[ 0 ],[-1/2],[ 1/2]]);
#              Pitt   UL    Rut   WVU    USF  UConn   SU    Cincy

my $c = $C->inv;
my $r = $c x $wl;
print $r;

my %rating;
@rating{@becteams} = list $r;

{
    my $ct = 1;
    for (sort {$rating{$b}<=>$rating{$a}} keys %rating) {
        my $out = pack 'A4 A20 A6', $ct++, $_, sprintf '%5.4f', $rating{$_};
        print $out, $/;
    }
}

