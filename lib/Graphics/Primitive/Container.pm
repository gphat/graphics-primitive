package Graphics::Primitive::Component;
use Moose;

use Moose::Util::TypeConstraints;

extends 'Geometry::Primitive::Rectangle';

use Geometry::Primitive::Point;

# enum 'Orientations' => ($CC_HORIZONTAL, $CC_VERTICAL);
# enum 'Positions' => ($CC_TOP, $CC_BOTTOM, $CC_LEFT, $CC_RIGHT );

# TODO Coerce color

has 'background_color' => ( is => 'rw', isa => 'Graphics::Color');
has 'border' => ( is => 'rw', isa => 'Chart::Clicker::Drawing::Border' );
has 'color' => ( is => 'rw', isa => 'Graphics::Color');
has 'location' => ( is => 'rw', isa => 'Geometry::Primitive::Point' );
has 'insets' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Insets',
    default => sub { Graphics::Primitive::Insets->new() }
);
has 'margins' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Insets',
    default => sub { Graphics::Primitive::Insets->new() }
);

sub inside_width {
    my $self = shift();

    my $w = $self->width();

    my $ins = $self->insets();
    if(defined($ins)) {
        $w -= $ins->left() + $ins->right()
    }
    my $marg = $self->margins();
    if(defined($marg)) {
        $w -= $marg->left() + $marg->right();
    }
    my $bord = $self->border();
    if(defined($bord)) {
        $w -= $bord->stroke->width() * 2;
    }

    return $w;
}

sub inside_height {
    my $self = shift();

    my $h = $self->height();

    my $ins = $self->insets();
    if(defined($ins)) {
        $h -= $ins->bottom() + $ins->top();
    }
    my $marg = $self->margins();
    if(defined($marg)) {
        $h -= $marg->bottom() + $marg->top();
    }
    my $bord = $self->border();
    if(defined($bord)) {
        $h -= $bord->stroke->width() * 2;
    }

    return $h;
}

sub upper_left_inside_point {
    my $self = shift();

    my $point = Geoemetry::Primitive::Point->new({ x => 0, y => 0 });

    if(defined($self->insets())) {
        $point->x($self->insets->left());
        $point->y($self->insets->top());
    }
    if(defined($self->border())) {
        $point->x($point->x() + $self->border->stroke->width());
        $point->y($point->y() + $self->border->stroke->width());
    }

    return $point;
}

sub upper_right_inside_point {
    my $self = shift();

    my $point = $self->upper_left_inside_point();
    $point->x($point->x() + $self->inside_width());

    return $point;
}

sub lower_left_inside_point {
    my $self = shift();

    my $point = $self->upper_left_inside_point();
    $point->y($point->y() + $self->inside_height());

    return $point;
}

1;
__END__

=head1 NAME

Graphics::Primitive::Component

=head1 DESCRIPTION

A Component is an entity with a graphical representation.

=head1 SYNOPSIS

  my $c = Graphics::Primitive::Component->new({
    location => Geometry::Primitive::Point->new({
        x => $x, y => $y
    }),
    width => 500, height => 350
  });

=head1 METHODS

=head2 Constructor

=over 4

=item new

  my $c = Graphics::Primitive::Component->new({
    location => Geometry::Primitive::Point->new({
        x => $x, y => $y
    }),
    width => 500, height => 350
  });

Creates a new Component.

=back

=head2 Class Methods

=over 4

=item dimensions

Get this Component's dimensions.

=item draw

Draw this component.

=item inside_width

Get the width available in this container after taking away space for
insets and borders.

=item inside_dimension

Get the dimension of this container's inside.

=item inside_height

Get the height available in this container after taking away space for
insets and borders.

=item height

Set/Get this Component's height

=item location

Set/Get this Component's location

=item width

Set/Get this Component's height

=item upper_left_inside_point

Get the Point for this container's upper left inside.

=item upper_right_inside_point

Get the Point for this container's upper right inside.

=back

=head1 AUTHOR

Cory Watson, C<< <cory.watson at iinteractive.com> >>

=head1 ACKNOWLEDGEMENTS

Many of the ideas here come from my experience using the Cairo library.  It is
entirely possible that 

=head1 BUGS

Please report any bugs or feature requests to C<bug-geometry-primitive at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Geometry-Primitive>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.