package Graphics::Primitive::Operation::Stroke;
use Moose;

extends 'Graphics::Primitive::Operation';

use Graphics::Primitive::Brush;

has brush => (
    isa => 'Graphics::Primitive::Brush',
    is  => 'rw',
    default =>  sub { Graphics::Primitive::Brush->new },
);

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__
=head1 NAME

Graphics::Primitive::Operation::Stroke

=head1 DESCRIPTION

Graphics::Primitive::Operation::Stroke represents a stroke operation to be
performed on a path.

=head1 SYNOPSIS

  use Graphics::Primitive::Operation::Stroke;

  my $stroke = Graphics::Primitive::Operation::Stroke->new;
  $stroke->brush->width(2);

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitive::Operation::Stroke. Uses a default
L<Brush|Graphics::Primitive::Brush>.

=back

=head2 Instance Methods

=over 4

=item I<brush>

Set/Get this Stroke's Brush

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