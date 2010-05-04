package Graphics::Primitive::Component;
use Moose;
use MooseX::Storage;

extends 'Scene::Graph::Node::Spatial';
with qw(
    MooseX::Clone
    MooseX::Storage::Deferred
    Graphics::Primitive::Node::Role::Layoutable
);

use overload ('""' => 'to_string');

use Forest::Tree;
use Geometry::Primitive::Dimension;
use Geometry::Primitive::Point;
use Geometry::Primitive::Rectangle;
use Graphics::Primitive::Border;
use Graphics::Primitive::Insets;

has 'background_color' => (
    is => 'rw',
    isa => 'Graphics::Color',
);
has 'border' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Border',
    default => sub { Graphics::Primitive::Border->new },
);
has 'class' => ( is => 'rw', isa => 'Str' );
has 'color' => (
    is => 'rw',
    isa => 'Graphics::Color',
);
has 'dimensions' => (
    is => 'rw',
    isa => 'Geometry::Primitive::Dimension',
    default => sub { Geometry::Primitive::Dimension->new },
    coerce => 1
);
has 'inside_bounding_box' => (
    is => 'ro',
    isa => 'Geometry::Primitive::Rectangle',
    lazy_build => 1
);
has 'inside_dimensions' => (
    is => 'ro',
    isa => 'Geometry::Primitive::Dimension',
    lazy_build => 1
);
has 'margins' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Insets',
    default => sub { Graphics::Primitive::Insets->new },
    coerce => 1,
);
has 'minimum_dimensions' => (
    is => 'rw',
    isa => 'Geometry::Primitive::Dimension',
    default => sub { Geometry::Primitive::Dimension->new },
    coerce => 1
);
has 'name' => ( is => 'rw', isa => 'Str' );
has 'outside_dimensions' => (
    is => 'ro',
    isa => 'Geometry::Primitive::Dimension',
    lazy_build => 1
);
has 'padding' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Insets',
    default => sub { Graphics::Primitive::Insets->new },
    coerce => 1,
);
has 'page' => ( is => 'rw', isa => 'Bool', default => 0 );
has 'visible' => ( is => 'rw', isa => 'Bool', default => 1 );

sub finalize { }

sub _build_inside_bounding_box {

    my ($self) = @_;

    my $padding = $self->padding;
    my $margins = $self->margins;
    my $border = $self->border;

    my $id = $self->inside_dimensions;
    my $rect = Geometry::Primitive::Rectangle->new(
        origin => Geometry::Primitive::Point->new(
            x => $padding->left + $border->left->width + $margins->left,
            y => $padding->top + $border->right->width + $margins->top
        ),
        width => $id->width,
        height => $id->height
    );
}

sub _build_inside_dimensions {
    my ($self) = @_;

    my $w = $self->dimensions->width;

    my $padding = $self->padding;
    my $margins = $self->margins;
    my $border = $self->border;

    $w -= $padding->left + $padding->right;
    $w -= $margins->left + $margins->right;

    $w -= $border->left->width + $border->right->width;

    $w = 0 if $w < 0;

    my $h = $self->dimensions->height;

    $h -= $padding->bottom + $padding->top;
    $h -= $margins->bottom + $margins->top;
    $h -= $border->top->width + $border->bottom->width;

    $h = 0 if $h < 0;

    return Geometry::Primitive::Dimension->new(width => $w, height => $h);
}

sub _build_outside_dimensions {
    my ($self) = @_;

    my $padding = $self->padding;
    my $margins = $self->margins;
    my $border = $self->border;

    my $w = $padding->left + $padding->right;
    $w += $margins->left + $margins->right;
    $w += $border->left->width + $border->right->width;

    my $h = $padding->top + $padding->bottom;
    $h += $margins->top + $margins->bottom;
    $h += $border->bottom->width + $border->top->width;

    return Geometry::Primitive::Dimension->new(width => $w, height => $h);
}

sub minimum_height {
    my ($self) = @_;

    return $self->minimum_dimensions->height;
}

sub minimum_width {
    my ($self) = @_;

    return $self->minimum_dimensions->width;
}

sub prepare {
    my ($self, $driver) = @_;

    1;
}

sub to_string {
    my ($self) = @_;

    my $buff = defined($self->name) ? $self->name : ref($self);
    $buff .= ': '.$self->origin->to_string;
    $buff .= ' ('.$self->dimensions->width.'x'.$self->dimensions->height.')';
    return $buff;
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__

=head1 NAME

Graphics::Primitive::Component - Base graphical unit

=head1 DESCRIPTION

A Component is an entity with a graphical representation.

=head1 SYNOPSIS

  my $c = Graphics::Primitive::Component->new({
    origin => Geometry::Primitive::Point->new({
        x => $x, y => $y
    }),
    width => 500, height => 350
  });

=head1 LIFECYCLE

=over 4

=item B<prepare>

Most components do the majority of their setup in the B<prepare>.  The goal of
prepare is to establish it's minimum height and width so that it can be
properly positioned by a layout manager.

  $driver->prepare($comp);

=item B<layout>

This is not a method of Component, but a phase introduced by the use of
L<Layout::Manager>.  If the component is a container then each of it's
child components (even the containers) will be positioned according to the
minimum height and width determined during B<prepare>.  Different layout
manager implementations have different rules, so consult the documentation
for each for details.  After this phase has completed the origin, height and
width should be set for all components.

  $lm->do_layout($comp);

=item B<finalize>

This final phase provides and opportunity for the component to do any final
changes to it's internals before being passed to a driver for drawing.
An example might be a component that draws a fleuron at it's extremities.
Since the final height and width isn't known until this phase, it was
impossible for it to position these internal components until now.  It may
even defer creation of this components until now.

B<It is not ok to defer all action to the finalize phase.  If you do not
establish a minimum height and width during prepare then the layout manager
may not provide you with enough space to draw.>

    $driver->finalize($comp);

=item B<draw>

Handled by L<Graphics::Primitive::Driver>.

   $driver->draw($comp);

=back

=head1 ATTRIBUTES

=head2 background_color

This component's background color.

=head2 border

This component's border, which should be an instance of
L<Border|Graphics::Primitive::Border>.

=head2 class

This component's class, which is an abitrary string. Graphics::Primitive has
no internal use for this attribute but provides it for outside use.

=head2 color

This component's foreground color.

=head2 dimensions

This node's dimensions.  See L<Geometry::Primitive::Dimension>.

=head2 inside_bounding_box

Returns a L<Rectangle|Geometry::Primitive::Rectangle> that defines the edges
of the 'inside' box for this component.  This box is relative to the origin
of the component.  Lazily computed.

=head2 inside_dimensions

Get the width available in this container after taking away space for
padding, margin and borders.  Lazily computed.

head2 margins

This component's margins, which should be an instance of
L<Insets|Graphics::Primitive::Insets>.  Margins are the space I<outside> the
component's bounding box, as in CSS.  The margins should be outside the
border.

=head2 minimum_dimensions

This node's minimum dimensions. See L<Geometry::Primitive::Dimension>.

=head2 minimum_height

Shortcut for C<minimum_dimensions->height>.

=head2 minimum_width

Shortcut for C<minimum_dimensions->width>.

=head2 name

This component's name.  This is not required, but may inform consumers of a
component.  Pay attention to that library's documentation.

=head2 origin

The origin point for this component.  Provided by
L<Scene::Graph::Node::Spatial>.

=head2 outside_dimensions

Get the height consumed by padding, margin and borders.  Lazily computed.

=head2 padding

Set this component's padding, which should be an instance of
L<Insets|Graphics::Primitive::Insets>.  Padding is the space I<inside> the
component's bounding box, as in CSS.  This padding should be between the
border and the component's content.

=head2 page

If true then this component represents stand-alone page.  This informs the
driver that this component (and any children) are to be renderered on a single
surface.  This only really makes sense in formats that have pages such as PDF
of PostScript.

=head2 visible

Set/Get this component's visible flag.

=head1 METHODS

=head2 finalize

Method provided to give component one last opportunity to put it's contents
into the provided space.  Called after prepare.

=head2 prepare

Method to prepare this component for drawing.  This is an empty sub and is
meant to be overriden by a specific implemntation.

=head2 to_string

Get a string representation of this component in the form of:

  $name $x,$y ($widthx$height)

=head1 SEE ALSO

L<Scene::Graph::Node::Spatial>

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2008-2010 by Cory G Watson.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.