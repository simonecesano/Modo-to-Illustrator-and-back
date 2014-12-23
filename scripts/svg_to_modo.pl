use lib '/Users/cesansim/Devel/SVG-Element/lib';
use SVG::TreeBuilder;
use Path::Tiny;

use Color::Library;
use Graphics::Color::RGB;
use List::AllUtils qw(shuffle uniq);
use Text::Unidecode;

use strict;
binmode(STDOUT, ":utf8");

$\ = "\n"; $, = "\t";

my $l = SVG::TreeBuilder->new({ 'NoExpand' => 1, 'ErrorContext' => 0 });
$l->parse_file($ARGV[0]);

for ($l->find('g')) {
    my @col = map { $_->attr('fill') } $_->find('path');
    next unless @col;
    print (id_to_string($_->attr('id')), (scalar @col), (scalar uniq @col));
}

sub decode_ai_entity {
    local $_ = shift;
    s/^_x|_$//g;
    return chr(hex($_));
}

sub id_to_string {
    local $_ = shift;
    s/(_x[0-9a-f]+_)/decode_ai_entity($1)/ge;
    s/_/ /g;
    return $_;
}
