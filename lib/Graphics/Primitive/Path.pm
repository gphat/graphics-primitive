package Graphics::Primitive::Path;
use Moose;

with 'MooseX::Clone';

use MooseX::AttributeHelpers;

use Geometry::Primitive::Arc;
use Geometry::Primitive::Line;

has 'current_point' => (
    is => 'rw',
    isa => 'Geometry::Primitive::Point',
    traits => [qw(Clone)],
    default => sub { Geometry::Primitive::Point->new(x => 0, y => 0) },
    clearer => 'clear_current_point'
);

has 'contiguous' => (
    isa => 'Str',
    is  => 'rw',
    default =>  sub { 0 },
);

has 'hints' => (
    metaclass => 'Collection::Array',
    is => 'rw',
    isa => 'ArrayRef[HashRef]',
    traints => [qw(Clone)],
    default => sub { [] },
    provides => {
        push => 'add_hint',
        get => 'get_hint',
    }
);

has 'primitives' => (
    metaclass => 'Collection::Array',
    is => 'rw',
    isa => 'ArrayRef[Geometry::Primitive]',
    traits => [qw(Clone)],
    default => sub { [] },
    provides => {
        'push' => 'add_primitive',
        'clear' => 'clear_primitives',
        'count' => 'primitive_count',
        'get' => 'get_primitive'
    }
);

after('add_primitive', sub {
    my ($self, $prim) = @_;

    my %hint = (
        contiguous => 0
    );
    my $new_end = $prim->point_end->clone;

    if($self->contiguous) {
        # If we are contiguous we can pass that hint to the backend.  The
        # Cairo driver needs to know this to avoid creating a sub-path
        $hint{contiguous} = 1;
    } else {
        # We weren't contiguous for this hint, but we WILL be if move_to
        # isn't used.  Set it now so we don't have to later.
        $self->contiguous(1);
    }
    $self->add_hint(\%hint);

    $self->current_point($new_end);
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

    # Move to effectively creates a new path, so we are no longer contiguous.
    # This mainly serves as a backend hint.
    $self->contiguous(0);
    $self->current_point($point);
}

sub rectangle {
    my ($self, $width, $height) = @_;

    $self->add_primitive(Geometry::Primitive::Rectangle->new(
        origin => $self->current_point,
        width => $width,
        height => $height
    ));
}

sub rel_line_to {
    my ($self, $x, $y) = @_;

    # FIXME Relative hinting?
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

Grahics::Primitive::Path - Collection of primitives

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

=item I<contiguous>

Flag this path as being contiguous at this point.  Continuity is important
so some path-based drivers such as Cairo.  You should not mess with this
attribute unless you know what you are doing.  It's used for driver hinting.

=item I<current_point>

Returns the current -- or last -- point on this Path.

=item I<get_points>

Get this path as a series of points.

=item I<get_primitive>

Returns the primitive at the specified offset.

=item I<hints>

List of hint hashrefs. This hint arrayref matches the primitives arrayref
one-to-one.  Hints are tidbits of information that may assist drivers in
optimizing (or successfully handling) primitives in this path's list.  You
should not mess with this structure unless you know what you are doing.

=item I<line_to ($point | $x, $y)>

Draw a line from the current point to the one provided. Accepts either a
Geoemetry::Primitive::Point or two arguments for x and y.

=item I<move_to ($point | $x, $y)>

Move the current point to the one specified.  This will not add any
primitives to the path.  Accepts either a Geoemetry::Primitive::Point or
two arguments for x and y.

=item I<primitive_count>

Returns the number of primitives on this Path.

=item I<rectangle ($width, $height)>

Draw a rectangle at I<current_position> of the specified width and height.

=item I<rel_line_to ($x_amount, $y_amount)>

Draw a line by adding the supplied x and y values to the current one.  For
example if the current point is 5,5 then calling rel_line_to(2, 2) would draw
a line from the current point to 7,7.

=item I<rel_move_to ($x_amount, $y_amount)>

Move to a new point by adding the supplied x and y values to the current ones.

=back

=head1 AUTHOR

Cory Watson <gphat@cpan.org>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

You can redistribute and/or modify this code under the same terms as Perl
itself.