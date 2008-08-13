use strict;
use Test::More tests => 9;

BEGIN {
    use_ok('Graphics::Primitive::Container');
}

my $cont = Graphics::Primitive::Container->new;
isa_ok($cont, 'Graphics::Primitive::Container');

my $comp1 = Graphics::Primitive::Component->new(name => 'first');
$cont->add_component($comp1);
cmp_ok($cont->component_count, '==', 1, 'component_count');

my $comp2 = Graphics::Primitive::Component->new(name => 'second');
$cont->add_component($comp2);
cmp_ok($cont->component_count, '==', 2, 'component_count');

my $found = $cont->find_component('first');
cmp_ok($found->name, 'eq', 'first', 'found first by name');

my $index1 = $cont->get_component(0);
cmp_ok($index1->name, 'eq', 'first', 'found first by index');

my $index2 = $cont->get_component(1);
cmp_ok($index2->name, 'eq', 'second', 'found second by index');

$cont->valid(1);
cmp_ok($cont->valid, '==', 1, 'valid');

my $comp3 = Graphics::Primitive::Component->new;

$cont->add_component($comp3);
cmp_ok($cont->valid, '==', 0, 'not valid');
