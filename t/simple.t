use Test::More;

use Graphics::Primitive::Component;

my $root = Graphics::Primitive::Component->new(dimensions => [ 640, 480 ] );
cmp_ok($root->dimensions->width, '==', 640, 'width');
cmp_ok($root->dimensions->height, '==', 480, 'height');

$root->margins([4, 3, 2, 1]);
$root->padding([5, 6, 7, 8]);
$root->border->width(2);

# This also tests ->inside_dimensions, as it's used internally
my $ibb = $root->inside_bounding_box;
cmp_ok($ibb->origin->x, '==', 11, 'inside bounding box origin x');
cmp_ok($ibb->origin->y, '==', 11, 'inside bounding box origin y');
cmp_ok($ibb->width, '==', 618, 'inside bounding box width');
cmp_ok($ibb->height, '==', 458, 'inside bounding box height');

my $odim = $root->outside_dimensions;
cmp_ok($odim->width, '==', 22, 'outside dimensions width');
cmp_ok($odim->height, '==', 22, 'outside dimensions height');

done_testing;