package Graphics::Primitive;
use Moose;

=head1 NAME

Graphics::Primitive - Device and library agnostic graphics objects

=cut

our $VERSION = '0.02';

no Moose;
1;
__END__

=head1 SYNOPSIS

Graphics::Primitive is a device and library agnostic system for creating
and manipulating colors in various graphical elements such as Borders,
Fonts, Paths and the like.

    my $c = Graphics::Primitive::Container->new({
      layout => $layout_manager,
      width => 500, height => 350,
      border => 
    });

    use Graphics::Primitive;

    my $foo = Graphics::Primitive->new();
    ...

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 ACKNOWLEDGEMENTS

Many of the ideas here come from my experience using the Cairo library.

=head1 BUGS

Please report any bugs or feature requests to C<bug-geometry-primitive at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Geometry-Primitive>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.