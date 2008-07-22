package Graphics::Primitive::Border;
use Moose;

extends 'Graphics::Primitive::Stroke';

use Graphics::Color;

has 'color' => (
    is => 'rw',
    isa => 'Graphics::Color',
);
has '+width' => ( default => sub { 0 });

no Moose;
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
    width => 3
  });

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitiver::Border.  Border extends Stroke and adds a
color attribute. Has a default stroke if none is specified.  See the
documentation for L<Graphics::Primitive::Stroke> for more information.

=back

=head2 Instance Methods

=over 4

=item I<color>

Set/Get the Color.  Expected to be a L<Graphics::Color> object.

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