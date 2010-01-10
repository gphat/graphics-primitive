use lib 't/lib', 'lib';
use strict;

use Test::More tests => 4;

use Graphics::Primitive::Component;

BEGIN {
    use_ok('Graphics::Primitive::Driver');
    use_ok('DummyDriver');
}

my $driver = DummyDriver->new;
isa_ok($driver, 'DummyDriver');

my $container = Graphics::Primitive::Component->new(
    width => 100, height => 100
);
my $comp = Graphics::Primitive::Component->new(
    width => 10, height => 10
);
$container->add_child($comp, 'c');

$driver->prepare($container);
$driver->finalize($container);
$driver->draw($container);
cmp_ok($driver->draw_component_called, '==', 2, 'component draws');

