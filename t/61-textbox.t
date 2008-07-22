use strict;
use Test::More tests => 2;

use Graphics::Primitive::Font;

BEGIN {
    use_ok('Graphics::Primitive::TextBox');
}

my $tb = Graphics::Primitive::TextBox->new;
isa_ok($tb, 'Graphics::Primitive::TextBox');