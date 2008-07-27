use Test::More tests => 9;

BEGIN {
    use_ok('Graphics::Primitive::Path');
    use_ok('Geometry::Primitive::Rectangle');
};

my $path = Graphics::Primitive::Path->new;
cmp_ok($path->count_primitives, '==', 0, 'primitive count');

my $start = Geometry::Primitive::Point->new(x => 0, y => 0);
$path->current_point($start);
ok($path->current_point->equal_to($start), 'current_point');

my $line_end = Geometry::Primitive::Point->new(x => 10, y => 0);
$path->line_to($line_end);
ok($path->current_point->equal_to($line_end), 'line set current_point');
cmp_ok($path->count_primitives, '==', 1, 'primitive count');

$mover = Geometry::Primitive::Point->new(x => 10, y => 10);
$path->move_to($mover);
ok($path->current_point->equal_to($mover), 'move_to set current_point');
cmp_ok($path->count_primitives, '==', 1, 'primitive count after move_to');


$path->move_to(12, 12);
cmp_ok($path->current_point->x, '==', 12, 'move to with scalars');
