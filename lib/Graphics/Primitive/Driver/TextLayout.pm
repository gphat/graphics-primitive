package Graphics::Primitive::Driver::TextLayout;
use Moose::Role;

no Moose;
1;
__END__;
=head1 NAME

Graphics::Primitive::TextBox - Text component

=head1 DESCRIPTION

Graphics::Primitive::TextBox is a Component with text.

=head1 SYNOPSIS

  use Graphics::Primitive::Font;
  use Graphics::Primitive::TextBox;

  my $tx = Graphics::Primitive::TextBox->new(
      font => Graphics::Primitive::Font->new(
          face => 'Myriad Pro',
          size => 12
      ),
      text => 'I am a textbox!'
  );

=head1 WARNING

This component is likely to change drastically.  Here be dragons.

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitive::TextBox.

=back

=head2 Instance Methods

=over 4

=item I<angle>

The angle this text will be rotated.

=item I<font>

Set this textbox's font

=item I<horizontal_alignment>

Horizontal alignment.  See L<Graphics::Primitive::Aligned>.

=item I<text>

Set this textbox's text.

=item I<vertical_alignment>

Vertical alignment.  See L<Graphics::Primitive::Aligned>.

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