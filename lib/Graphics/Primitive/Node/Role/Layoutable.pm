package Graphics::Primitive::Node::Role::Layoutable;
use Moose::Role;

requires 'prepared';

has 'layout_manager' => (
    is => 'rw',
    isa => 'Layout::Manager',
    handles => [ 'do_layout' ],
    trigger => sub { my ($self) = @_; $self->prepared(0); },
);

1;