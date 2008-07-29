package Graphics::Primitive::Path;
use Moose;

with 'MooseX::Clone';

use MooseX::AttributeHelpers;

extends 'Geometry::Primitive';

with 'Geometry::Primitive::Shape';

use Geometry::Primitive::Line;

has 'current_point' => (
    is => 'rw',
    isa => 'Geometry::Primitive::Point',
    default => sub { Geometry::Primitive::Point->new(x => 0, y => 0) },
    clearer => 'clear_current_point'
);

has 'primitives' => (
    metaclass => 'Collection::Array',
    is => 'rw',
    isa => 'ArrayRef[Geometry::Primitive]',
    default => sub { [] },
    provides => {
        'push' => 'add_primitive',
        'clear' => 'clear_primitives',
        'count' => 'count_primitives',
        'get' => 'get_primitive_at'
    }
);

# TODO rel_line_to, rel_move_to

sub line_to {
    my ($self, $x, $y) = @_;

    my $point;
    if(!ref($x) && defined($y)) {
        # This allows the user to pass in $x and $y as scalars, which
        # easier sometimes.
        $point = Geometry::Primitive::Point->new(x => $x, y => $y);
    } else {
        $point = $x;
    }

    $self->add_primitive(Geometry::Primitive::Line->new(
            point_start => $self->current_point,
            point_end => $point
    ));
    $self->current_point($point);
}

sub move_to {
    my ($self, $x, $y) = @_;

    my $point;
    if(!ref($x) && defined($y)) {
        # This allows the user to pass in $x and $y as scalars, which
        # easier sometimes.
        $point = Geometry::Primitive::Point->new(x => $x, y => $y);
    } else {
        $point = $x;
    }

    $self->current_point($point);
}

sub get_points {
    #TODO Implement me!
}

no Moose;
1;

__END__

=head1 NAME

Grahics::Primitive::Path

=head1 DESCRIPTION

Graphics::Primitive::Path is a shape defined by a list of primitives.
=head1 SYNOPSIS

  use Graphics::Primitive::Path;

  my $path = Graphics::Primitive::Path->new();
  $path->add_primitive($line);
  $path->move_to($point);

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitive::Path

=back

=head2 Instance Methods

=over 4

=item I<add_primitive>

Add a primitive to this Path.

=item I<clear_current_point>

Clears the current point on this Path.

=item I<clear_primitives>

Clears all primitives from this Path.  NOTE: This does not clear the
current point.

=item I<count_primitives>

Returns the number of primitives on this Path.

=item I<current_point>

Returns the current, or last, point on this Path.

=item I<get_points>

Get this path as a series of points.

=item I<get_primitive_at>

Returns the primitive at the specified offset.

=item I<line_to>

Draw a line from the current point to the one provided. Accepts either a
Geoemetry::Primitive::Point or two arguments for x and y.

=item I<move_to>

Move the current point to the one specified.  This will not add any
primitives to the path.  Accepts either a Geoemetry::Primitive::Point or
two arguments for x and y.

=back

=head1 AUTHOR

Cory Watson <gphat@cpan.org>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

You can redistribute and/or modify this code under the same terms as Perl
itself.