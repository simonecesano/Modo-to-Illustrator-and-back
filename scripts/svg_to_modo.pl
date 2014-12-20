use lib '/Users/cesansim/Devel/SVG-Element/lib';
use SVG::TreeBuilder;
use Path::Tiny;

use Color::Library;
use Graphics::Color::RGB;
use List::Util qw(shuffle);
use Text::Unidecode;

use strict;
binmode(STDOUT, ":utf8");

$\ = "\n";

my $l = SVG::TreeBuilder->new({ 'NoExpand' => 1, 'ErrorContext' => 0 });
$l->parse_file($ARGV[0]);

for (map { $_->attr('id') } $l->find('g')) {
    my @res = /(_x[0-9a-f]+_)/g;
    print;

    my $o = $_;
    
    s/(_x[0-9a-f]+_)/decode_ai_entity($1)/ge;
    s/_/ /g;

    print id_to_string($o);
    print;
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
