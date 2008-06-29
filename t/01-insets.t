use Test::More tests => 5;

BEGIN {
    use_ok('Graphics::Primitive::Insets');
}

my $obj = Graphics::Primitive::Insets->new(
    top => 1,
    bottom => 2,
    left => 3,
    right => 4
);

cmp_ok($obj->top, '==', 1, 'top');
cmp_ok($obj->bottom, '==', 2, 'bottoms');
cmp_ok($obj->left, '==', 3, 'left');
cmp_ok($obj->right, '==', 4, 'right');
