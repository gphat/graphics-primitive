package Graphics::Primitive::Container;
use Moose;

extends 'Graphics::Primitive::Component';

has 'components' => (
    metaclass => 'Collection::Array',
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [] },
    provides => {
        'clear'=> 'clear_components',
        'count'=> 'component_count',
    }
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

sub do_prepare {
    my ($self) = @_;

    foreach my $c (@{ $self->components }) {
        next unless defined($c->{component}) && $c->{component}->visible;
        $c->{component}->prepare();
    }
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

override('prepare', sub {
    my ($self) = @_;

    super;

    foreach my $comp (@{ $self->components }) {
        next unless defined($comp) && defined($comp->{component}) && $comp->{component}->visible;
        $comp->{component}->prepare();
    }
});

no Moose;
1;
__END__

=head1 NAME

Graphics::Primitive::Container

=head1 DESCRIPTION

A Container is a role for components that may contain other components.

=head1 SYNOPSIS

  my $c = Graphics::Primitive::Container->new({
    width => 500, height => 350
  });
  $c->add_component($comp, { meta => 'data' });

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

=item I<count_components>

Returns the number of components in this container.

=item I<do_prepare>

Prepare this component and all it's child components.

=item I<find_component>

Find a component with the given name.

=item I<get_component>

Get the component at the specified index.

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