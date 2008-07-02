package Graphics::Primitive::Border;
use Moose;

extends 'Graphics::Primitive::Stroke';

use Graphics::Color;

has 'color' => (
    is => 'rw',
    isa => 'Graphics::Color',
    # TODO color space independent!
    default => sub { Graphics::Color::RGB->new(
        red     => 0,
        green   => 0,
        blue    => 0,
        alpha   => 1
    ) },
    # TODO coerce!
    # coerce => 1
);

1;
__END__

=head1 NAME

Graphics::Primitive::Border

=head1 DESCRIPTION

Graphics::Primitive::Border describes the border to be rendered around a
component.

=head1 SYNOPSIS

  use Graphics::Primitive::Border;

  my $border = Graphics::Primitive::Border->new({
      # TODO Color!!
    color => 'black',
    width => 3
  });

=head1 METHODS

=head2 Constructor

=over 4

=item new

Creates a new Graphics::Primitiver::Border.  Border extends Stroke and adds a
color attribute. Defaults to a color of black and a default stroke if none are
specified.  See the documentation for L<Graphics::Primitive::Stroke> for more
information.

=back

=head2 Class Methods

=over 4

=item color

Set/Get the Color.

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