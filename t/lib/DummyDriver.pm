package # hide from the CPAN
    DummyDriver;
use Moose;

extends 'Graphics::Primitive::Driver';

has 'draw_component_called' => (
    is => 'rw',
    isa => 'Int',
    default => sub { 0 }
);

sub _draw_component {
    my ($self, $comp) = @_;

    $self->draw_component_called(
        $self->draw_component_called + 1
    );
}

no Moose;
1;