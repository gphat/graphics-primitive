package Graphics::Primitive::Node::Role::Layoutable;
use Moose::Role;

has 'layout_manager' => (
    is => 'rw',
    isa => 'Layout::Manager',
    handles => [ 'do_layout' ],
    trigger => sub { my ($self) = @_; $self->prepared(0); },
);

1;