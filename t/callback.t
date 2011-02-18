use lib 't/lib', 'lib';
use strict;

use Test::More;

use Graphics::Primitive::Component;
use Graphics::Primitive::Container;

BEGIN {
    use_ok('Graphics::Primitive::Driver');
    use_ok('DummyDriver');
}

my $driver = DummyDriver->new;
isa_ok($driver, 'DummyDriver');

my $container = Graphics::Primitive::Container->new;
my $comp = Graphics::Primitive::Component->new;
my $comp_call = 0;
$comp->callback(sub { $comp_call = 1 });

$container->add_component($comp, 'c');

my $cont_call = 0;
$container->callback(sub { $cont_call = 1 });

$driver->prepare($container);
$driver->finalize($container);

cmp_ok($cont_call, '==', 1, 'container callback fired');
cmp_ok($comp_call, '==', 1, 'component callback fired');

done_testing;