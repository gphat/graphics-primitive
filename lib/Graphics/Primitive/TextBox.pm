package Graphics::Primitive::TextBox;
use Moose;

extends 'Graphics::Primitive::Component';

use Graphics::Primitive::Font

has 'font' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Font',
    default => sub { Graphics::Primitive::Font->new }
);
has 'lines' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [] }
);
has 'text' => (
    is => 'rw',
    isa => 'Str',
);
has 'text_bounding_box' => (
    is => 'rw',
    isa => 'Geometry::Primitive::Rectangle'
);

override('prepare', sub {
    my ($self, $driver) = @_;

    super;

    my @lines = split("\n", $self->text);

    foreach my $line (@lines) {
        my $bb = $driver->get_text_bounding_box($self->font, $self->text);
        $self->text_bounding_box($bb);
        $self->minimum_height($self->minimum_height + $bb->height);
        $self->minimum_width($self->minimum_width + $bb->width);
        push(@{ $self->lines }, { text => $line, box => $bb });
    }
});

1;
__END__
=head1 NAME

Graphics::Primitive::TextBox

=head1 DESCRIPTION

Graphics::Primitive::TextBox is a Componet with text.

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

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitive::TextBox.

=back

=head2 Instance Methods

=over 4

=item I<font>

Set this textbox's font

=item I<text>

Set this textbox's text.

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