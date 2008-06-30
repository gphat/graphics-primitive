use Test::More tests => 5;

BEGIN {
    use_ok('Graphics::Primitive::Border');
}

use Graphics::Color::RGB;

my $color = Graphics::Color::RGB->new();

my $obj = Graphics::Primitive::Border->new(
    color => $color,
    width => 3,
    line_cap => 'round',
    line_join => 'bevel'
);

cmp_ok($obj->color->red, '==', $color->red(), 'color');
cmp_ok($obj->width, '==', 3, 'width');
cmp_ok($obj->line_cap, 'eq', 'round', 'line_cap');
cmp_ok($obj->line_join, 'eq', 'bevel', 'line_join');

