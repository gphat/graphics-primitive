package Graphics::Primitive::Operation::Stroke;
use Moose;

extends 'Graphics::Primitive::Operation';

has brush => (
    isa => 'Graphics::Primitive::Brush',
    is  => 'rw',
    default =>  sub { Graphics::Primitive::Brush->new },
);

no Moose;
1;
__END__