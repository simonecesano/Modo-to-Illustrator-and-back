use JSON;
use File::Slurp;
use Data::Dump qw/dump/;
use List::Util qw/sum max/; 
use Number::Tolerant;

$\ = "\n";

my $str = do { local $/; <STDIN> };
my $v = from_json($str);

my $avg = (sum map { ($_->[2] - $_->[0]) } @$v) / (scalar @$v);      # avg width
my $max = (max map { ($_->[2] - $_->[0]) } @$v);                     # max width

my $t = $max / 4;
my @rows = ();
my $center;

for (sort { (($a->[1] + $a->[3]) / 2) <=> (($b->[1] + $b->[3]) / 2) }
     @$v) { # column

    my $c = (($_->[1] + $_->[3]) / 2);
    
    if ($c == $center) {
	push $rows[-1], $_;
    } else {
	$center = tolerance($c => plus_or_minus => $t);
	push @rows, [];
	push $rows[-1], $_;
    }
    
}
print $avg;
print $max;

for (@rows) { $_ = [ reverse map { $_->[-1] } @$_] }
@rows = reverse @rows;

print dump \@rows;

__DATA__
Layer_1,140.75781,51.648448,617.4235,477.05807
image3,213.5779,129.80011,128.64,72.360001
image5,349.75311,129.80011,128.64,72.360001
image7,489.64721,129.80011,128.64,72.360001
image9,629.54131,129.80011,128.64,72.360001
image11,213.5779,211.43671,128.64,72.360001
image13,349.75311,211.43671,128.64,72.360001
image15,489.64721,211.43671,128.64,72.360001
image17,629.54131,211.43671,128.64,72.360001
image19,213.5779,293.07331,128.64,72.360001
image21,349.75311,293.07331,128.64,72.360001
image23,489.64721,293.07331,128.64,72.360001
image25,629.54131,293.07331,128.64,72.360001
image27,213.5779,374.70992,128.64,72.360001
image29,349.75311,374.70992,128.64,72.360001
image31,489.64721,374.70992,128.64,72.360001
image33,629.54131,374.70992,128.64,72.360001
image35,213.5779,456.34652,128.64,72.360001
image37,349.75311,456.34652,128.64,72.360001
text39,262.16211,58.837901,16.628907,20.671875
text41,402.52894,51.648448,17.613282,27.861329
text43,544.24884,58.837901,15.574219,20.671875
text45,682.98634,51.648448,17.595703,27.861329
text47,142.95508,146.75587,15.626953,26.244141
text49,141.63672,229.53136,16.664063,26.71875
text51,141.74219,312.78166,17.279297,27.228516
text53,140.75781,396.50578,19.125,26.244141
text55,141.77735,479.75588,16.980469,26.753907
