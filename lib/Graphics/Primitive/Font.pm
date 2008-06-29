package Graphics::Primitive::Font;
use Moose;
use Moose::Util::TypeConstraints;

enum 'Slants' => (
    'normal', 'italic', 'oblique'
);

enum 'Weights' => (
    'normal', 'bold'
);

has 'face' => (
    is => 'rw',
    isa => 'Str',
    default => 'Sans'
);

has 'size' => (
    is => 'rw',
    isa => 'Num',
    default => 12
);

has 'slant' => (
    is => 'rw',
    isa => 'Slants',
    default => 'normal'
);

has 'weight' => (
    is => 'rw',
    isa => 'Weights',
    default => 'normal'
);

1;
__END__
=head1 NAME

Graphics::Primitive::Font

=head1 DESCRIPTION

Graphics::Primitive::Font represents the various options that are available
when rendering text.

=head1 SYNOPSIS

  use Graphics::Primitive::Font;

  my $font = Graphics::Primitive::Font->new({
    face => 'Sans',
    size => 12,
    slant => 'normal'
  });

=head1 METHODS

=head2 Constructor

=over 4

=item new

Graphics::Primitive::Font.

=back

=head2 Class Methods

=over 4

=item size

Set/Get the size of this text.

=item slant

Set/Get the slant of this text.  Valid values are normal, italic and oblique.

=item weight

Set/Get the weight of this text.  Value valies are normal and bold.

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