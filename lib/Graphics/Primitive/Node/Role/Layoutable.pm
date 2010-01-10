package Graphics::Primitive::Node::Role::Layoutable;
use Moose::Role;

has 'layout_manager' => (
    is => 'rw',
    isa => 'Layout::Manager',
    handles => [ 'do_layout' ],
    predicate => 'has_layout_manager'
);

1;