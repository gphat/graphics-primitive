use strict;
use Test::More tests => 5;

use Graphics::Primitive::Font;

BEGIN {
    use_ok('Graphics::Primitive::TextBox');
}

my $tb = Graphics::Primitive::TextBox->new;
isa_ok($tb, 'Graphics::Primitive::TextBox');

cmp_ok($tb->prepared, '==', 0, 'not prepared');
$tb->prepared(1);
cmp_ok($tb->prepared, '==', 1, 'prepared');
$tb->text('Different');
cmp_ok($tb->prepared, '==', 0, 'not prepared');