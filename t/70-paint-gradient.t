use Test::More tests => 5;

BEGIN {
    use_ok('Graphics::Primitive::Paint::Gradient');
}

use Graphics::Color::RGB;

my $grad = Graphics::Primitive::Paint::Gradient->new;
isa_ok($grad, 'Graphics::Primitive::Paint::Gradient');

my $red = Graphics::Color::RGB->new(red => 1, green => 0, blue => 0);
my $blue = Graphics::Color::RGB->new(red => 0, green => 0, blue => 1);

cmp_ok($grad->stop_count, '==', 0, 'stop count');

$grad->add_stop(0.0, $red);
cmp_ok($grad->stop_count, '==', 1, 'stop count');
$grad->add_stop(0.75, $blue);

my @stops = $grad->stops;
cmp_ok(scalar(@stops), '==', 2, '2 stops');