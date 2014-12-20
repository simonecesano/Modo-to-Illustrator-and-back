use XML::LibXSLT;
use XML::LibXML;
use XML::Simple;
use Data::Dump qw/dump/;
use Getopt::Long::Descriptive;

my ($opt, $usage) = describe_options
    (
     $0 . ' %o <some-arg>',
     [ 'perl|p',   "print perl" ],
     [ 'xml|x',   "print xml" ],
     [],
     [ 'verbose|v',  "print extra stuff"            ],
     [ 'help',       "print usage message and exit" ],
    );

  print($usage->text), exit if $opt->help;
$\ = "\n"; $, = "\t";

my $xslt = XML::LibXSLT->new();
 
my $source = XML::LibXML->load_xml(location => $ARGV[0]) || die;
my $style = XML::LibXML->load_xml(location=> $ARGV[1], no_cdata=>1) || die;

my $style = $xslt->parse_stylesheet($style);
my $results = $style->transform($source);


do {
    my $p = XMLin($style->output_as_bytes($results), (ForceArray => qr/^part$/, KeyAttr => ""));
    print dump $p->{part}
} if $opt->perl;

print $style->output_as_bytes($results)
    if $opt->xml;
