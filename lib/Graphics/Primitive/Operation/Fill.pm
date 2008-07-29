package Graphics::Primitive::Operation::Fill;
use Moose;

extends 'Graphics::Primitive::Operation';

has paint => (
    isa => 'Graphics::Primitive::Paint',
    is  => 'rw'
);

no Moose;
1;
__END__