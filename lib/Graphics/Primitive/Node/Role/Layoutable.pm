package Graphics::Primitive::Node::Role::Layoutable;
use Moose::Role;

use Geometry::Primitive::Dimension;

has 'dimensions' => (
    is => 'rw',
    isa => 'Geometry::Primitive::Dimension',
    default => sub { Geometry::Primitive::Dimension->new },
);
has 'layout_manager' => (
    is => 'rw',
    isa => 'Layout::Manager',
    handles => [ 'do_layout' ],
    predicate => 'has_layout_manager'
);
has 'margins' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Insets',
    default => sub { Graphics::Primitive::Insets->new },
    coerce => 1,
);
has 'padding' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Insets',
    default => sub { Graphics::Primitive::Insets->new },
    coerce => 1,
);

sub inside_dimensions {
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

sub minimum_dimensions {
    my ($self) = @_;

    my $padding = $self->padding;
    my $margins = $self->margins;
    my $border = $self->border;

    my $w = 0;
    $w -= $padding->left + $padding->right;
    $w -= $margins->left + $margins->right;
    $w -= $border->left->width + $border->right->width;
    $w = 0 if $w < 0;

    my $h = 0;
    $h -= $padding->bottom + $padding->top;
    $h -= $margins->bottom + $margins->top;
    $h -= $border->top->width + $border->bottom->width;
    $h = 0 if $h < 0;

    return Geometry::Primitive::Dimension->new(width => $w, height => $h);
}

sub inside_bounding_box {

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

sub outside_dimensions {
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

sub prepare {
    my ($self, $driver) = @_;

    1;
}

1;

__END__

=head1 NAME

Graphics::Primitive::Node::Role::Layoutable - A node suitable for layout

=head1 DESCRIPTION

Adds dimensions, margins and padding to a node.

=head1 ATTRIBUTES

=head2 dimensions

This node's dimensions.  See L<Geometry::Primitive::Dimension>.

=head2 layout_manager

The layout manager used by this node.

=head2 margins

This node's margins.  See L<Graphics::Primitive::Insets>.

=head2 padding

This node's padding.  See L<Graphics::Primitive::Insets>.

=head1 METHODS

=head2 inside_dimensions

Returns the dimensions for the box I<inside> this node.  The inside is the
width and height of the component minus padding, margins and borders.

=head2 minimum_dimensions

This node's minimum_dimensions, or the size it must not be smaller than. 
See L<Geometry::Primitive::Dimension>.

=head2 outside_dimensions

Returns the dimensions for the box I<outside> this node.  The outside is the
width and height of the padding, margins and borders.


=head1 AUTHOR

Cory G Watson, C<< <gphat at cpan.org> >>

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2010 Cold Hard Code, LLC.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.