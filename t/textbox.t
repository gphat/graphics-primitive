use strict;
use Test::More;

use Graphics::Primitive::Font;

BEGIN {
    use_ok('Graphics::Primitive::TextBox');
}

my $tb = Graphics::Primitive::TextBox->new;
isa_ok($tb, 'Graphics::Primitive::TextBox');

cmp_ok($tb->horizontal_alignment, 'eq', 'left', 'default horizontal alignment');
cmp_ok($tb->vertical_alignment, 'eq', 'top', 'default vertical alignment');

done_testing;