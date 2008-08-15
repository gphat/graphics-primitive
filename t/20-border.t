use Test::More tests => 9;

BEGIN {
    use_ok('Graphics::Primitive::Border');
}

use Graphics::Color::RGB;

my $color = Graphics::Color::RGB->new();

my $obj = Graphics::Primitive::Border->new;

$obj->color($color);
$obj->width(3);

cmp_ok($obj->left->color->red, '==', $color->red, 'left color');
cmp_ok($obj->right->color->red, '==', $color->red, 'right color');
cmp_ok($obj->top->color->red, '==', $color->red, 'top color');
cmp_ok($obj->bottom->color->red, '==', $color->red, 'bottom color');

cmp_ok($obj->left->width, '==', 3, 'left width');
cmp_ok($obj->right->width, '==', 3, 'right width');
cmp_ok($obj->top->width, '==', 3, 'top width');
cmp_ok($obj->bottom->width, '==', 3, 'bottom width');
