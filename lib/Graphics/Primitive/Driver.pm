package Graphics::Primitive::Driver;
use Moose::Role;

requires qw(
    write _draw_canvas _draw_component _draw_line _draw_textbox
    _do_stroke get_text_bounding_box
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

# __PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__

=head1 NAME

Graphics::Primitive::Driver

=head1 DESCRIPTION



=head1 SYNOPSIS

  my $c = Graphics::Primitive::Component->new({
    origin => Geometry::Primitive::Point->new({
        x => $x, y => $y
    }),
    width => 500, height => 350
  });

=head1 METHODS

=over 4

=item I<data>

Retrieve the results of this driver's operations.

=item I<draw>

Draws the given Graphics::Primitive::Component.  If the component is a
container then all components therein are drawn, recursively.

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