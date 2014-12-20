use lib '/Users/cesansim/Devel/SVG-Element/lib';
use SVG::TreeBuilder;
use Path::Tiny;

use Color::Library;
use Graphics::Color::RGB;
use List::Util qw(shuffle);

use strict;

$\ = "\n";

my @files = path($ARGV[0])->children;
my ($c, $empty, $colors, $list, @descriptions);

my @colors = shuffle grep { my $g = Graphics::Color::RGB->from_hex_string($_)->to_hsl; $g->l > 0.5 && $g->s > 0.5 } (Color::Library->dictionary('SVG')->colors);

for (grep {/^_.+png$/ && !/Alpha Output Final/ }@files) {
    #-------------------------------------------------------------
    # for each file
    #-------------------------------------------------------------
    # convert png to svg
    my $svg = qx/convert -negate -format pnm "$_" pnm:- | potrace -s/;
    my $name = $_; for ($name) { s/\.png//; s/^_+//g; s/_+/ /g };
    my $color = $colors[$c];
    # if this is the first file, create an empty one
    if ($c++ == 0) {
	$empty = empty_svg($svg);
	my $l = SVG::TreeBuilder->new;
	$l->parse('<g id="_part_list"></g>');
	$empty->push_content($l)
    };
    # clean up
    $svg = cleanup_svg($svg, $_, $color);
    # append to empty one
    $empty->find('svg')->push_content($svg);
    $empty->find('svg')->push_content($svg);
    push @descriptions, color_description($c, $name, $color);
}

for (@descriptions) { $empty->look_down('id' => "_part_list" )->push_content($_) }
    
print $empty->as_XML;


sub cleanup_svg {
    my $svg = shift;
    my $name = shift;
    my $color = shift;
    my $source = $name;

    #-------------------------------------------------------------
    # eliminate initial underscores, change others into spaces
    #-------------------------------------------------------------
    for ($name) { s/\.png//; s/^\W+/_/g;  };
    my $s = SVG::TreeBuilder->new({ 'NoExpand' => 1, 'ErrorContext' => 0 });
    $s->parse($svg);

    #-------------------------------------------------------------
    # eliminate potrace metadata
    #-------------------------------------------------------------
    $_->delete for $s->look_down('_tag', 'metadata');

    #-------------------------------------------------------------
    # clean up SVG
    #-------------------------------------------------------------
    my $g = $s->look_down('_tag', 'g');  # find first (and only) group
    $g->attr('fill', $color || 'none');            # no fill
    $g->attr('stroke', '#000000');          # stroke
    $g->attr('id', $name);               # id to file name
    
    return $g
};

sub empty_svg {
    my $svg = shift;
    my $s = SVG::TreeBuilder->new({ 'NoExpand' => 1, 'ErrorContext' => 0 });
    #-------------------------------------------------------------
    # gut the SVG to an empty shell
    #-------------------------------------------------------------
    $s->parse($svg);
    $_->delete for $s->look_down('_tag', 'metadata'); # delete metadata
    $_->delete for $s->look_down('_tag', 'g');        # delete first and only group
    return $s
};

sub color_description {
    my $t = <<EOF;
<g transform="translate(80.5 %f)" >
   <text transform="translate(32 0)" font-family="AdihausDIN-Regular" font-size="24">%s</text>
   <rect fill="%s" transform="translate(0 -20)" width="24" height="24"/>
</g>\n
EOF
    ;

    my ($count, $part, $color) = @_;
    my $top = $count * 32 + 72;
    
    my $list = SVG::TreeBuilder->new;
    $list->parse(sprintf($t, $top, $part, $color));
    return $list;
}


__DATA__
