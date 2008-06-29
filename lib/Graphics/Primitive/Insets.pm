package Graphics::Primitive::Insets;
use Moose;

has 'top' => ( is => 'rw', isa => 'Num', default => 0 );
has 'bottom' => ( is => 'rw', isa => 'Num', default => 0 );
has 'left' => ( is => 'rw', isa => 'Num', default => 0 );
has 'right' => ( is => 'rw', isa => 'Num', default => 0 );

1;
__END__
=head1 NAME

Graphics::Primitive::Insets

=head1 DESCRIPTION

Graphics::Primitive::Insets represents the amount of space a that surrounds
something.

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

=item new

Creates a new Graphics::Primitive::Insets.

=back

=head2 Class Methods

=over 4

=item top

Set/Get the inset from the top.

=item left

Set/Get the inset from the left.

=item right

Set/Get the inset from the right.

=item bottom

Set/Get the inset from the bottom.

=back

=head1 AUTHOR

Cory Watson, C<< <cory.watson at iinteractive.com> >>

=head1 SEE ALSO

perl(1), L<Wikipedia|http://en.wikipedia.org/wiki/HSL_color_space>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.