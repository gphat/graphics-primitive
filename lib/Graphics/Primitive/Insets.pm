package Graphics::Primitive::Insets;
use Moose;

with 'Geometry::Primitive::Equal';

has 'top' => ( is => 'rw', isa => 'Num', default => 0 );
has 'bottom' => ( is => 'rw', isa => 'Num', default => 0 );
has 'left' => ( is => 'rw', isa => 'Num', default => 0 );
has 'right' => ( is => 'rw', isa => 'Num', default => 0 );

sub equal_to {
    my ($self, $other) = @_;

    return ($self->top == $other->top) && ($self->bottom == $other->bottom())
        && ($self->left == $other->left) && ($self->right == $other->right);
}

sub zero {
    my ($self) = @_;

    $self->top(0); $self->bottom(0); $self->left(0); $self->right(0);
}

no Moose;
1;
__END__
=head1 NAME

Graphics::Primitive::Insets

=head1 DESCRIPTION

Graphics::Primitive::Insets represents the amount of space that surrounds
something.  This object can be used to represent either padding or margins
(in the CSS sense, one being inside the bounding box, the other being outside)

=head1 SYNOPSIS

  use Graphics::Primitive::Insets;

  my $insets = Graphics::Primitive::Insets->new({
    top     => 5,
    bottom  => 5,
    left    => 5,
    right   => 5
  });

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitive::Insets.

=back

=head2 Instance Methods

=over 4

=item I<bottom>

Set/Get the inset from the bottom.

=item I<equal_to>

Determine if these Insets are equal to another.

=item I<left>

Set/Get the inset from the left.

=item I<right>

Set/Get the inset from the right.

=item I<top>

Set/Get the inset from the top.

=item I<zero>

Sets all the insets (top, left, bottom, right) to 0.

=back

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 SEE ALSO

perl(1), L<Wikipedia|http://en.wikipedia.org/wiki/HSL_color_space>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.