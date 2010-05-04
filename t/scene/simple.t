use Test::More;

use Graphics::Primitive::Component;
use DummyDriver;

my $comp = Graphics::Primitive::Component->new(dimensions => [ 100, 100 ]);
$comp->border->width(5);
$comp->padding->width(3);

cmp_ok($comp->inside_dimensions->width, '==', 84, 'inside width');
cmp_ok($comp->inside_dimensions->height, '==', 84, 'inside height');

cmp_ok($comp->outside_dimensions->width, '==', 16, 'outside width');
cmp_ok($comp->outside_dimensions->height, '==', 16, 'outside height');

$comp2 = Graphics::Primitive::Component->new(dimensions => [ 20, 20 ]);
$comp->add_child($comp2);

cmp_ok($comp->child_count, '==', 1, '1 child');

my $driver = DummyDriver->new;

$driver->prepare($comp);
$driver->finalize($comp);
$driver->draw($comp);

cmp_ok($driver->draw_component_called, '==', 2, '2 component draws');

cmp_ok($driver->drawn_components->[0]->origin->x, '==', 0, 'first component x:0');
cmp_ok($driver->drawn_components->[0]->origin->y, '==', 0, 'first component y:0');

cmp_ok($driver->drawn_components->[1]->origin->x, '==', 8, 'first component x:0');
cmp_ok($driver->drawn_components->[1]->origin->y, '==', 8, 'first component y:0');

done_testing;