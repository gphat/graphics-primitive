package Graphics::Primitive::Container;
use Moose;

extends 'Graphics::Primitive::Component';

use Layout::Manager;

has 'layout' => (
    is => 'rw',
    isa => 'Layout::Manager',
    handles => [
        'components', 'add_component', 'component_count', 'remove_component',
        'clear_components', 'do_layout', 'get_component', 'find_component'
    ]
);

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
    layout => $layout_manager,
    width => 500, height => 350
  });

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Container.

=back

=head2 Instance Methods

=over 4

=item I<layout>

Set/Get the layout manager for this Container.

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