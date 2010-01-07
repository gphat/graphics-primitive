package Graphics::Primitive::Types;

use MooseX::Types -declare => [qw(
    LineCap
    LineJoin
)];

enum LineCap, (qw(butt round square));
enum LineJoin, (qw(miter round bevel));

1;

__END__

=head1 NAME

Graphics::Primitive::Types - Types used with Graphics::Primitive

=head1 DESCRIPTION

This is a collection of types used with Graphics::Primitive

=head1 SYNOPSIS

  use Graphics::Primitive::Types qw(LineJoin);

  has 'line_join' => (
    is => 'ro',
    isa => LineJoin
  );
  
=head1 Types

=head2 LineCap

Types of line caps.  Valid values are butt, round and square.

=head2 LineJoin

Types of line join.  Valid values are miter, round and bevel.

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-geometry-primitive at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Geometry-Primitive>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2008-2010 by Cory G Watson.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.