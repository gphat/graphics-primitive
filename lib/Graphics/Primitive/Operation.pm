package Graphics::Primitive::Operation;
use Moose;

__PACKAGE__->meta->make_immutable;

no Moose;
1;
=head1 NAME

Grahics::Primitive::Operation

=head1 DESCRIPTION

Graphics::Primitive::Operation is the base class for operations.  An operation
is an action that is performed on a path such as a
L<Fill|Graphics::Primitive::Operation::Fill> or
L<Fill|Graphics::Primitive::Operation::Stroke>.

=head1 AUTHOR

Cory Watson <gphat@cpan.org>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

You can redistribute and/or modify this code under the same terms as Perl
itself.
