use Test::More tests => 9;

use Geometry::Primitive;

BEGIN {
    use_ok('Graphics::Primitive::Canvas');
    use_ok('Graphics::Primitive::Operation::Stroke');
}

my $canvas = Graphics::Primitive::Canvas->new;
isa_ok($canvas, 'Graphics::Primitive::Canvas');

my $point = Geometry::Primitive::Point->new(x => 0, y => 0);
ok($canvas->current_point->equal_to($point), 'starting point');

$canvas->move_to(5, 5);
$point->x(5); $point->y(5);
ok($canvas->current_point->equal_to($point), 'move_to');

$canvas->save;

$canvas->move_to(11, 5);
$point->x(11); $point->y(5);
ok($canvas->current_point->equal_to($point), 'move_to after save');

$canvas->restore;
$point->x(5); $point->y(5);
ok($canvas->current_point->equal_to($point), 'current after restore');

$canvas->do(Graphics::Primitive::Operation::Stroke->new);
$point->x(0); $point->y(0);
ok($canvas->current_point->equal_to($point), 'current after do');

cmp_ok($canvas->path_count, '==', 1, '1 path');
