use strict;
use Test::More;

BEGIN {
    use_ok('Graphics::Primitive::Container');
}

use Graphics::Primitive::Component;

my $cont = Graphics::Primitive::Component->new(name => 'root');
isa_ok($cont, 'Graphics::Primitive::Component');

my $comp1 = Graphics::Primitive::Component->new(name => 'first');
$cont->add_child($comp1);
cmp_ok($cont->child_count, '==', 1, 'child_count');
cmp_ok($comp1->parent->name, 'eq', $cont->name, 'parent');

my $comp2 = Graphics::Primitive::Component->new(name => 'second');
$cont->add_child($comp2);
cmp_ok($cont->child_count, '==', 2, 'child_count');

my $foundi = $cont->find_by_id('first');
my $found = $cont->get_child_at($foundi);
cmp_ok($found->name, 'eq', 'first', 'found first by name');

my $index1 = $cont->get_child_at(0);
cmp_ok($index1->name, 'eq', 'first', 'found first by index');

my $index2 = $cont->get_child_at(1);
cmp_ok($index2->name, 'eq', 'second', 'found second by index');

my $comp3 = Graphics::Primitive::Component->new;

$cont->add_child($comp3);

my $removed = $cont->remove_child_at(1);
ok(!defined($comp2->parent), 'no parent after removal');

$cont->clear_children;
cmp_ok($cont->child_count, '==', 1, '1 child removed');

done_testing;