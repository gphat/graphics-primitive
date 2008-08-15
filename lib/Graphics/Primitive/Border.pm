package Graphics::Primitive::Border;
use Moose;

use Graphics::Primitive::Brush;

with 'MooseX::Clone';

use Graphics::Color;

has 'bottom' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Brush',
    default => sub {
        Graphics::Primitive::Brush->new
    }
);
has 'left' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Brush',
    default => sub {
        Graphics::Primitive::Brush->new
    }
);
has 'right' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Brush',
    default => sub {
        Graphics::Primitive::Brush->new
    }
);
has 'top' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Brush',
    default => sub {
        Graphics::Primitive::Brush->new
    }
);

__PACKAGE__->meta->make_immutable;

sub color {
    my ($self, $c) = @_;

    $self->bottom->color($c);
    $self->left->color($c);
    $self->right->color($c);
    $self->top->color($c);
}

sub dash_pattern {
    my ($self, $d) = @_;

    $self->bottom->dash_pattern($d);
    $self->left->dash_pattern($d);
    $self->right->dash_pattern($d);
    $self->top->dash_pattern($d);
}

sub width {
    my ($self, $w) = @_;

    $self->bottom->width($w);
    $self->left->width($w);
    $self->right->width($w);
    $self->top->width($w);
}

no Moose;
1;
__END__

=head1 NAME

Graphics::Primitive::Border - Line around components

=head1 DESCRIPTION

Graphics::Primitive::Border describes the border to be rendered around a
component.

=head1 SYNOPSIS

  use Graphics::Primitive::Border;

  my $border = Graphics::Primitive::Border->new;

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitiver::Border.  Borders are composed of 4
brushes, one for each of the 4 sides.  See the documentation for
L<Graphics::Primitive::Brush> for more information.

=back

=head2 Instance Methods

=over 4

=item I<bottom>

The brush representing the bottom border.

=item I<color>

Set the Color on all 4 borders to the one supplied.  Shortcut for setting it
with each side.

=item I<dash_pattern>

Set the dash pattern on all 4 borders to the one supplied. Shortcut for
setting it with each side.

=item I<left>

The brush representing the left border.

=item I<right>

The brush representing the right border.

=item I<top>

The brush representing the top border.

=item I<width>

Set the width on all 4 borders to the one supplied.  Shortcut for setting it
with each side.

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