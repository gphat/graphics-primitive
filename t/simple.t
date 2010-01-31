use Test::More;

use Graphics::Primitive::Component;

my $root = Graphics::Primitive::Component->new(dimensions => [ 640, 480 ] );
cmp_ok($root->dimensions->width, '==', 640, 'width');
cmp_ok($root->dimensions->height, '==', 480, 'height');

$root->margins([4, 3, 2, 1]);

diag($root->minimum_dimensions->width());

done_testing;