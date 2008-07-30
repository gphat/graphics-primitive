package Graphics::Primitive::Component;
use Moose;

use overload ('""' => 'to_string');

use Graphics::Primitive::Border;
use Graphics::Primitive::Insets;
use Geometry::Primitive::Point;
use Geometry::Primitive::Rectangle;

use Tree::Simple;

has 'background_color' => ( is => 'rw', isa => 'Graphics::Color');
has 'border' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Border',
    default => sub { Graphics::Primitive::Border->new() }
);
has 'color' => ( is => 'rw', isa => 'Graphics::Color');
has 'height' => ( is => 'rw', isa => 'Num', default => sub { 0 } );
has 'margins' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Insets',
    default => sub { Graphics::Primitive::Insets->new() }
);
has 'name' => ( is => 'rw', isa => 'Str' );
has 'origin' => (
    is => 'rw',
    isa => 'Geometry::Primitive::Point',
    default =>  sub { Geometry::Primitive::Point->new( x => 0, y => 0 ) },
);
has 'padding' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Insets',
    default => sub { Graphics::Primitive::Insets->new() }
);
has 'maximum_height' => ( is => 'rw', isa => 'Num', default => sub { 0 } );
has 'maximum_width' => ( is => 'rw', isa => 'Num', default => sub { 0 } );
has 'minimum_height' => ( is => 'rw', isa => 'Num', default => sub { 0 } );
has 'minimum_width' => ( is => 'rw', isa => 'Num', default => sub { 0 } );
has 'preferred_height' => ( is => 'rw', isa => 'Num', default => sub { 0 });
has 'preferred_width' => ( is => 'rw', isa => 'Num', default => sub { 0 });
has 'visible' => ( is => 'rw', isa => 'Bool', default => sub { 1 } );
has 'width' => ( is => 'rw', isa => 'Num', default => sub { 0 } );

sub get_tree {
    my ($self) = @_;

    return Tree::Simple->new($self);
}

sub inside_width {
    my ($self) = @_;

    my $w = $self->width;

    $w -= $self->padding->left + $self->padding->right;
    $w -= $self->margins->left + $self->margins->right;
    $w -= $self->border->width * 2;

    $w = 0 if $w < 0;

    return $w;
}

sub inside_height {
    my ($self) = @_;

    my $h = $self->height;

    $h -= $self->padding->bottom + $self->padding->top;
    $h -= $self->margins->bottom + $self->margins->top;
    $h -= $self->border->width * 2;

    $h = 0 if $h < 0;

    return $h;
}

sub inside_bounding_box {

    my ($self) = @_;

    my $rect = Geometry::Primitive::Rectangle->new(
        origin => Geometry::Primitive::Point->new(
            x => $self->padding->left + $self->border->width
                + $self->margins->left,
            y => $self->padding->top + $self->border->width
                + $self->margins->top
        ),
        width => $self->inside_width,
        height => $self->inside_height
    );
}

sub outside_width {
    my $self = shift();

    my $w = $self->padding->left + $self->padding->right;
    $w += $self->margins->left + $self->margins->right;
    $w += $self->border->width * 2;
}

sub outside_height {
    my $self = shift();

    my $w = $self->padding->top + $self->padding->bottom;
    $w += $self->margins->top + $self->margins->bottom;
    $w += $self->border->width * 2;
}

sub pack { }

sub prepare {
    my ($self, $driver) = @_;

    $self->minimum_height($self->outside_height);
    $self->minimum_width($self->outside_width);
}

sub to_string {
    my ($self) = @_;

    my $buff = defined($self->name) ? $self->name : ref($self);
    $buff .= ': '.$self->origin->to_string;
    $buff .= ' ('.$self->width.'x'.$self->height.')';
    return $buff;
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__

=head1 NAME

Graphics::Primitive::Component

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

=item B<layout>

This is not a method of Component, but a phase introduced by the use of
L<Layout::Manager>.  If the component is a container then each of it's
child components (even the containers) will be positioned according to the
minimum height and width determined during B<prepare>.  Different layout
manager implementations have different rules, so consult the documentation
for each for details.  After this phase has completed the origin, height and
width should be set for all components.

=item B<pack>

This final phase provides and opportunity for the component to do any final
changes to it's internals before being passed to a driver for drawing.
An example might be a component that draws a fleuron at it's extremities.
Since the final height and width isn't known until this phase, it was
impossible for it to position these internal components until now.  It may
even defer creation of this components until now.

B<It is not ok to defer all action to the pack phase.  If you do not
establish a minimum hieght and width during prepare then the layout manager
may not provide you with enough space to draw.>

=item B<draw>

Handled by L<Graphics::Primitive::Driver>.

=back

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Component.

=back

=head2 Instance Methods

=over 4

=item I<background_color>

Set this component's background color.

=item I<border>

Set this component's border, which should be an instance of
L<Border|Graphics::Primitive::Border>.

=item I<color>

Set this component's foreground color.

=item I<get_tree>

Get a tree for this component.  Since components are -- by definiton -- leaf
nodes, this tree will only have the one member at it's root.

=item I<height>

Set this component's height.

=item I<inside_bounding_box>

Returns a L<Rectangle|Geometry::Primitive::Rectangle> that defines the edges
of the 'inside' box for this component.  This box is relative to the origin
of the component.

=item I<inside_height>

Get the height available in this container after taking away space for
padding, margin and borders.

=item I<inside_width>

Get the width available in this container after taking away space for
padding, margin and borders.

=item I<margins>

Set this component's margins, which should be an instance of
L<Insets|Graphics::Primitive::Insets>.  Margins are the space I<outside> the
component's bounding box, as in CSS.  The margins should be outside the
border.

=item I<maximum_height>

Set/Get this component's maximum height.  Used to inform a layout manager.

item I<maximum_width>

Set/Get this component's maximum width.  Used to inform a layout manager.

item I<minimum_height>

Set/Get this component's minimum height.  Used to inform a layout manager.

item I<minimum_width>

Set/Get this component's minimum width.  Used to inform a layout manager.

=item I<name>

Set this component's name.  This is not required, but may inform consumers
of a component.  Pay attention to that library's documentation.

=item I<origin>

Set/Get the origin point for this component.

=item I<outside_height>

Get the height consumed by padding, margin and borders.

=item I<outside_width>

Get the width consumed by padding, margin and borders.

=item I<pack>

Method provided to give component one last opportunity to pack it's contents
into the provided space.  Called after prepare.

=item I<padding>

Set this component's padding, which should be an instance of
L<Insets|Graphics::Primitive::Insets>.  Padding is the space I<inside> the
component's bounding box, as in CSS.  This padding should be between the
border and the component's content.

=item I<prepare>

Method to prepare this component for drawing.  This is an empty sub and is
meant to be overriden by a specific implemntation.

=item I<preferred_height>

Set/Get this component's preferred height.  Used to inform a layout manager.

=item I<preferred_width>

Set/Get this component's preferred width.  Used to inform a layout manager.

=item I<to_string>

Get a string representation of this component in the form of:

  $name $x,$y ($widthx$height)

=item I<visible>

Set/Get this component's visible flag.

=item I<width>

Set/Get this component's width.

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