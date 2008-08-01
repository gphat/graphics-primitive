package Graphics::Primitive::Driver;
use Moose::Role;

requires qw(
    _draw_canvas _draw_component _draw_line _draw_path _draw_textbox
    _do_fill _do_stroke data get_text_bounding_box write
);

sub data {
    my ($self) = @_;
}

sub draw {
    my ($self, $comp) = @_;

    die('Components must be objects.') unless ref($comp);
    # The order of this is important, since isa will return true for any
    # superclass...
    if($comp->isa('Graphics::Primitive::Canvas')) {
        $self->_draw_canvas($comp);
    } elsif($comp->isa('Graphics::Primitive::TextBox')) {
        $self->_draw_textbox($comp);
    } elsif($comp->isa('Graphics::Primitive::Component')) {
        $self->_draw_component($comp);
    }

    if($comp->isa('Graphics::Primitive::Container')) {
        if($comp->can('components')) {
            foreach my $subcomp (@{ $comp->components }) {
                $self->draw($subcomp->{component});
            }
        }
    }
}

sub write {
    my ($self, $filename) = @_;
}

no Moose;
1;
__END__

=head1 NAME

Graphics::Primitive::Driver - Role for driver implementations

=head1 DESCRIPTION

What good is a library agnostic intermediary representation of graphical
components if you can't feed them to a library specific implementation that
turns them into drawings? Psht, none!

To write a driver for Graphics::Primitive implemeent this role.  

=head1 SYNOPSIS

  my $c = Graphics::Primitive::Component->new({
    origin => Geometry::Primitive::Point->new({
        x => $x, y => $y
    }),
    width => 500, height => 350
  });

=head1 CANVASES

When a path is added to the internal list via I<do>, it is stored in the
I<paths> attribute as a hashref.  The hashref has two keys: B<path> and B<op>.
The path is, well, the path.  The op is the operation provided to I<do>.  As
canvases are just lists of paths you should consult the next section as well.

=head1 PATHS AND HINTING

Paths are lists of primitives.  Primitives are all descendants of
L<Geometry::Shape> and therefore have I<point_start> and I<point_end>.  These
two attributes allow the chaining of primitives.  To draw a path you should
iterate over the primitives, drawing each.

When you pull each path from the arrayref you should pull it's accompanying
hints via I<get_hint> (the indexes match).  The hint may provide you with
additional information:

=over 4

=item I<contiguous>

True if this primitive is contiguous with the previous one.  Example: Used to
determine if a new sub-path is needed for the Cairo driver.

=back

=head1 WARNING

Only this class or the driver itself should call methods starting with an
underscore, as this interface may change.

=head1 METHODS

=over 4

=item I<_do_stroke>

Perform a stroke.

=item I<_do_fill>

Perform a fill.

=item I<_draw_canvas>

Draw a canvas.

=item I<_draw_component>

Draw a component.

=item I<_draw_line>

Draw a line.

=item I<_draw_arc>

Draw an arc.

=item I<_draw_textbox>

Draw a textbox.

=item I<data>

Retrieve the results of this driver's operations.

=item I<draw>

Draws the given Graphics::Primitive::Component.  If the component is a
container then all components therein are drawn, recursively.

=item I<get_text_bounding_box>

Given a L<Font|Graphics::Primitive::Font> and a string, returns a bounding box
of the rendered text.

=item I<write>

Write out the results of this driver's operations to the specified file.

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