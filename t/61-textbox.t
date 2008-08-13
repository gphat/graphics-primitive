use strict;
use Test::More tests => 5;

use Graphics::Primitive::Font;

BEGIN {
    use_ok('Graphics::Primitive::TextBox');
}

my $tb = Graphics::Primitive::TextBox->new;
isa_ok($tb, 'Graphics::Primitive::TextBox');

cmp_ok($tb->valid, '==', 0, 'not valid');
$tb->valid(1);
cmp_ok($tb->valid, '==', 1, 'valid');
$tb->text('Different');
cmp_ok($tb->valid, '==', 0, 'not valid');