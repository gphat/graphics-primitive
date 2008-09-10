package Graphics::Primitive::Font;
use Moose;
use MooseX::Storage;
use Moose::Util::TypeConstraints;

with 'MooseX::Clone';
with Storage (format => 'JSON', io => 'File');

enum 'Graphics::Primitive::Font::Slants' => (
    'normal', 'italic', 'oblique'
);
enum 'Graphics::Primitive::Font::Variants' => (
    'normal', 'small-caps'
);
enum 'Graphics::Primitive::Font::Weights' => (
    'normal', 'bold'
);

has 'family' => (
    is => 'rw',
    isa => 'Str',
    default => 'Sans'
);
has 'size' => (
    is => 'rw',
    isa => 'Num',
    default => sub { 12 }
);
has 'slant' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Font::Slants',
    default => 'normal'
);
has 'variant' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Font::Variants',
    default => 'normal'
);
has 'weight' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Font::Weights',
    default => 'normal'
);

__PACKAGE__->meta->alias_method('face' => __PACKAGE__->can('family'));

sub derive {
    my ($self, $args) = @_;

    return unless ref($args) eq 'HASH';
    my $new = $self->clone;
    foreach my $key (keys %{ $args }) {
        $new->$key($args->{$key}) if($new->can($key));
    }
    return $new;
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__
=head1 NAME

Graphics::Primitive::Font - Text styling

=head1 DESCRIPTION

Graphics::Primitive::Font represents the various options that are available
when rendering text.  The options here may or may not have an effect on your
rendering.  They represent a cross-section of the features provided by
various drivers.  Setting them should B<not> break anything, but may not
have an effect if the driver doesn't understand the option.

=head1 SYNOPSIS

  use Graphics::Primitive::Font;

  my $font = Graphics::Primitive::Font->new({
    family => 'Arial',
    size => 12,
    slant => 'normal'
  });

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitive::Font.

=back

=head2 Instance Methods

=over 4

=item I<derive>

Clone this font but change one or more of it's attributes by passing in a
hashref of options:

  my $new = $font->derive({ attr => $newvalue });
  
The returned font will be identical to the cloned one, save the attributes
specified.

=item I<family>

Set this font's family.

=item I<size>

Set/Get the size of this font.

=item I<slant>

Set/Get the slant of this font.  Valid values are normal, italic and oblique.

=item I<variant>

Set/Get the variant of this font.  Valid values are normal or small-caps.

=item I<weight>

Set/Get the weight of this font.  Value valies are normal and bold.

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