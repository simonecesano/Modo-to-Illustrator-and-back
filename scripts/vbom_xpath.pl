use XML::Simple;
use XML::LibXSLT;
use XML::XPath;
use Data::Dump qw/dump/;
use List::MoreUtils qw/uniq/;
use Graphics::Color::HSV;

$\ = "\n"; $, = "\t";

my $xp = XML::XPath->new( filename => $ARGV[0] );
$nodeset = $xp->find('//ColorWay//ColorPartList/Color/TargetPart');

print join "\n", map { $_->toString } $nodeset->get_nodelist;

    
# print $nodeset->to_literal;
