package Graphics::Primitive::Path;
use Moose;

with 'MooseX::Clone';

use MooseX::AttributeHelpers;

use Geometry::Primitive::Arc;
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
        'get' => 'get_primitive'
    }
);

after('add_primitive', sub {
    my ($self, $prim) = @_;

    $self->current_point($prim->point_end->clone);
});

sub arc {
    my ($self, $radius, $start, $end, $line_to) = @_;

    my $arc = Geometry::Primitive::Arc->new(
        origin => $self->current_point->clone,
        radius => $radius, angle_start => $start, angle_end => $end
    );

    unless($line_to) {
        $self->line_to($arc->point_start);
    }

    $self->add_primitive($arc);
}

sub close_path {
    my ($self) = @_;

    $self->line_to($self->get_primitive(0)->point_start->clone);
}

sub line_to {
    my ($self, $x, $y) = @_;

    my $point;
    if(!ref($x) && defined($y)) {
        # This allows the user to pass in $x and $y as scalars, which
        # easier sometimes.
        $point = Geometry::Primitive::Point->new(x => $x, y => $y);
    } else {
        $point = $x->clone;
    }

    $self->add_primitive(Geometry::Primitive::Line->new(
            start => $self->current_point->clone,
            end => $point
    ));
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

sub rel_line_to {
    my ($self, $x, $y) = @_;

    my $point = $self->current_point->clone;
    $point->x($point->x + $x);
    $point->y($point->y + $y);

    $self->add_primitive(Geometry::Primitive::Line->new(
            start => $self->current_point->clone,
            end => $point
    ));
}

sub rel_move_to {
    my ($self, $x, $y) = @_;

    my $point = $self->current_point->clone;
    $self->move_to($point->x + $x, $point->y + $y);
}

__PACKAGE__->meta->make_immutable;

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

=item I<add_primitive ($prim)>

Add a primitive to this Path.

=item I<arc ($radius, $start, $end, [ $skip_line_to ])>

  $path->arc($radius, $start_angle_in_radians, $end_angle_in_radians);

Draw an arc based at the current point with the given radius from the given
start angle to the given end angle.  B<A line will be drawn from the
current_point to the start point of the described arc.  If you do not want
this to happen, supply a true value as the last argument.>

=item I<clear_current_point>

Clears the current point on this Path.

=item I<clear_primitives>

Clears all primitives from this Path.  NOTE: This does not clear the
current point.

=item I<close_path>

Close the current path by drawing a line from the I<current_point> back to
the first point in the path.

=item I<count_primitives>

Returns the number of primitives on this Path.

=item I<current_point>

Returns the current -- or last -- point on this Path.

=item I<get_points>

Get this path as a series of points.

=item I<get_primitive>

Returns the primitive at the specified offset.

=item I<line_to ($point | $x, $y)>

Draw a line from the current point to the one provided. Accepts either a
Geoemetry::Primitive::Point or two arguments for x and y.

=item I<move_to ($point | $x, $y)>

Move the current point to the one specified.  This will not add any
primitives to the path.  Accepts either a Geoemetry::Primitive::Point or
two arguments for x and y.

=item I<rel_line_to ($x_amount, $y_amount)>

Draw a line by adding the supplied x and y values to the current one.  For
example if the current point is 5,5 then calling rel_line_to(2, 2) would draw
a line from the current point to 7,7.

=back

=head1 AUTHOR

Cory Watson <gphat@cpan.org>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

You can redistribute and/or modify this code under the same terms as Perl
itself.