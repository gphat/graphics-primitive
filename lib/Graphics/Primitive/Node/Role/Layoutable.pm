package Graphics::Primitive::Node::Role::Layoutable;
use Moose::Role;

has 'layout_manager' => (
    is => 'rw',
    isa => 'Layout::Manager',
    handles => [ 'do_layout' ],
    predicate => 'has_layout_manager'
);

has 'constraints' => (
    traits => [ 'Array' ],
    is => 'ro',
    isa => 'ArrayRef',
    default => sub { [] },
    handles => {
        add_constraint => 'push',
        get_constraint => 'get',
        set_constraint => 'set'
    }
);

sub add_component {
    my ($self, $comp, $const) = @_;

    print STDERR ref($comp)."\n";
    $self->add_child($comp);
    $self->add_constraint($const);
}

1;

__END__

=head1 NAME

Graphics::Primitive::Node::Role::Layoutable - A node suitable for layout

=head1 DESCRIPTION

Adds a layout_manager attribute.

=head1 ATTRIBUTES

=head2 constraints

Constraints for this components children.

=head2 layout_manager

The layout manager used by this node.

=head1 METHODS

=head2 add_component($component, $constraint)

Adds the component as a child of this component and sets it's constraint
to the one supplied.  Internally uses C<add_child> and C<add_constraint>.

=head2 add_constraint

Push a constraint onto the list.

=head2 get_constraint($index)

Get the constraint at the supplied index.

=head2 set_constraint($index)

Set the constraint at the supplied index.

=head1 AUTHOR

Cory G Watson, C<< <gphat at cpan.org> >>

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2010 Cold Hard Code, LLC.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.