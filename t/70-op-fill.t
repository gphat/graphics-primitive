use Test::More tests => 2;

BEGIN {
    use_ok('Graphics::Primitive::Operation::Fill');
}

my $stroke = Graphics::Primitive::Operation::Fill->new;
isa_ok($stroke, 'Graphics::Primitive::Operation::Fill');
