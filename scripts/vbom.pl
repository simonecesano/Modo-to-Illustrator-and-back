use lib '/Users/cesansim/Devel/SVG-Element/lib';
use XML::TreeBuilder;
use SVG::TreeBuilder;
use Path::Tiny;
use Data::Dump qw/dump/;

use XML::Simple;

my $v = XMLin($ARGV[0], KeyAttr => 'id');

print dump keys $v->{ColorWays}->{ColorWay}->{ColorPartList}->{Color};
