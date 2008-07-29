package Graphics::Primitive::Paint::Solid;
use Moose;

has color => (
    isa => 'Graphics::Color',
    is  => 'rw',
);

no Moose;
1;
