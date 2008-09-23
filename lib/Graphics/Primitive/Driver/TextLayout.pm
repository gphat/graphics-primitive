package Graphics::Primitive::Driver::TextLayout;
use Moose::Role;

has 'component' => (
    is => 'rw',
    isa => 'Graphics::Primitive::TextBox',
    required => 1
);
has 'height' => (
    is => 'rw',
    isa => 'Num',
    default => sub { -1 }
);
has 'width' => (
    is => 'rw',
    isa => 'Num',
    lazy => 1,
    default => sub { my ($self) = @_; $self->component->width }
);

no Moose;
1;
__END__;
=head1 NAME

Graphics::Primitive::Driver::TextLayout - TextLayout role

=head1 DESCRIPTION

Graphics::Primitive::Driver::TextLayout is a role for Driver text layout
engines.

=head1 SYNOPSIS

    package MyLayout;
    use Moose;

    with 'Graphics::Primitive::Driver::TextLayout';

    ...

=head1 METHODS

=over 4

=item I<component>

Set/Get the component from which to draw layout information.

=item I<height>

Set/Get this layout's height

=item I<width>

Set/Get this layout's width.  Defaults to the width of the component supplied.

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