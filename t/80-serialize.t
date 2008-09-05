use strict;

use Test::More tests => 3;

use Graphics::Color::RGB;
use Graphics::Primitive::Brush;
use Graphics::Primitive::Border;
use Graphics::Primitive::Insets;
use Graphics::Primitive::Component;

my $brush = Graphics::Primitive::Brush->new;
my $brush2 = Graphics::Primitive::Brush->unpack($brush->pack);
ok($brush->equal_to($brush2), 'brush equal_to');

my $border = Graphics::Primitive::Border->new;
my $border2 = Graphics::Primitive::Border->unpack($border->pack);
ok($border->equal_to($border2), 'border equal_to');

my $insets = Graphics::Primitive::Insets->new;
my $insets2 = Graphics::Primitive::Insets->unpack($insets->pack);
ok($insets->equal_to($insets2), 'insets equal_to');

my $comp = Graphics::Primitive::Component->new(
    width => 100,
    height => 50,
    name => 'foo'
);
use Data::Dumper;
print STDERR Dumper($comp->freeze)."\n";
# my $comp2 = Graphics::Primitive::Component->unpack($comp->pack);
# use Data::Dumper;
# diag Dumper($comp2);