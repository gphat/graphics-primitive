package Graphics::Primitive::Container;
use Moose;

use Forest::Tree;

extends 'Graphics::Primitive::Component';

with 'MooseX::Clone';

has 'components' => (
    metaclass => 'Collection::Array',
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [] },
    provides => {
        'clear'=> 'clear_components',
        'count'=> 'component_count',
        'pop' => 'pop_component'
    }
);
has 'layout_manager' => (
    is => 'rw',
    isa => 'Layout::Manager',
    handles => [ 'do_layout' ]
);

sub add_component {
    my ($self, $component, $args) = @_;

    return 0 unless $self->validate_component($component, $args);

    push(@{ $self->components }, {
        component => $component,
        args      => $args
    });

    return 1;
}

sub find_component {
    my ($self, $name) = @_;

    foreach my $c (@{ $self->components }) {
        my $comp = $c->{component};

        if(defined($comp) && defined($comp->name) && $comp->name eq $name) {

            return $comp;
        }
    }

    return undef;
}

sub get_component {
    my ($self, $idx) = @_;

    my $comp = $self->components->[$idx];
    if(defined($comp)) {
        return $comp->{component};
    }
    return undef;
}

override('get_tree', sub {
    my ($self) = @_;

    my $tree = Forest::Tree->new(node => $self);

    foreach my $c (@{ $self->components }) {
        my $comp = $c->{component};
        $tree->add_child($comp->get_tree);
    }

    return $tree;
});

sub remove_component {
    my ($self, $component) = @_;

    my $name;

    # Handle either a component object or a scalar name
    if(ref($component)) {
        if($component->can('name')) {
            $name = $component->name();
        } else {
            die('Must supply a Component or a scalar name.');
        }
    } else {
        $name = $component;
    }

    my $count = 0;
    my $del;
    foreach my $c (@{ $self->components }) {
        my $comp = $c->{component};

        if(defined($comp) && defined($comp->name) && $comp->name eq $name) {

            delete($self->components->[$count]);
            $del++;
        }
        $count++;
    }

    return $del;
}

sub validate_component {
    my ($self, $c, $a) = @_;

    return 1;
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__

=head1 NAME

Graphics::Primitive::Container - Component that holds other Components

=head1 DESCRIPTION

A Container is a omponent that may contain other components.

=head1 SYNOPSIS

  my $c = Graphics::Primitive::Container->new({
    width => 500, height => 350,
    layout_manager => Layout::Manager::Compass->new
  });
  $c->add_component($comp, { meta => 'data' });

=head1 DESCRIPTION

Containers are components that contain other components.  They can also hold
an instance of a L<Layout::Manager> for automatic layout of their internal
components. See the
L<Component's Lifecycle Section|Graphics::Primitive::Component#LIFECYCLE> for
more information.

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Container.

=back

=head2 Instance Methods

=over 4

=item I<add_component>

Add a component to the container.  Returns a true value if the component
was added successfully. A second argument may be required, please consult the
POD for your specific layout manager implementation.

Before the component is added, it is passed to the validate_component method.
If validate_component does not return a true value, then the component is not
added.

=item I<clear_components>

Remove all components from the layout manager.

=item I<component_count>

Returns the number of components in this container.

=item I<find_component>

Find a component with the given name.

=item I<get_component>

Get the component at the specified index.

=item I<get_tree>

Returns a Forest::Tree object with this component at the root and all child
components as children.  Calling this from your root container will result
in a tree representation of the entire scene.

=item I<remove_component>

Removes a component.  B<Components must have names to be removed.>  Returns 
the number of components removed.

=item I<validate_component>

Optionally overriden by an implementation, allows it to deem 

=back

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 BUGS

Please report any bugs or feature requests to C<bug-geometry-primitive at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Geometry-Primitive>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.