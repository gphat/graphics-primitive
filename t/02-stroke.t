use Test::More tests => 4;

BEGIN {
    use_ok('Graphics::Primitive::Stroke');
}

my $obj = Graphics::Primitive::Stroke->new(
    width => 3,
    line_cap => 'round',
    line_join => 'bevel'
);

cmp_ok($obj->width, '==', 3, 'width');
cmp_ok($obj->line_cap, 'eq', 'round', 'line_cap');
cmp_ok($obj->line_join, 'eq', 'bevel', 'line_join');

