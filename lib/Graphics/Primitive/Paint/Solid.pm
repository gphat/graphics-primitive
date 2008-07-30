package Graphics::Primitive::Paint::Solid;
use Moose;

has color => (
    isa => 'Graphics::Color',
    is  => 'rw',
);

__PACKAGE__->meta->make_immutable;

no Moose;
1;
=head1 NAME

Grahics::Primitive::Paint::Solid

=head1 DESCRIPTION

Graphics::Primitive::Paint::Solid is a

=head1 SYNOPSIS

  use Graphics::Primitive::Paint::Solid;

  my $solid = Graphics::Primitive::Solid->new;
  $solid->color(Graphics::Color::RGB->new(red => 1, green => 0, blue => 0));

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitive::Solid

=back

=head2 Instance Methods

=over 4

=item I<color>

Get/Set the color of this solid

=back

=head1 AUTHOR

Cory Watson <gphat@cpan.org>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

You can redistribute and/or modify this code under the same terms as Perl
itself.
