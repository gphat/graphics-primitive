package Graphics::Primitive::Driver;
use Moose;

sub data {
    my ($self) = @_;
}

sub draw {
    my ($self, $comp) = @_;

    my $class = ref($comp);
    if($class eq 'Graphics::Primitive::Container') {
        if($comp->can('components')) {
            foreach my $subcomp (@{ $comp->components }) {
                $self->draw($subcomp->{component});
            }
        }
        $self->_draw_component($comp);
    } elsif($class eq 'Graphics::Primitive::Component') {
        $self->_draw_component($comp);
    }
}

sub write {
    my ($self, $filename) = @_;
}

no Moose;
1;
__END__

=head1 NAME

Graphics::Primitive::Driver

=head1 DESCRIPTION

A Component is an entity with a graphical representation.  This class
implements L<Layout::Manager::Component> for use with a layout manager.

=head1 SYNOPSIS

  my $c = Graphics::Primitive::Component->new({
    origin => Geometry::Primitive::Point->new({
        x => $x, y => $y
    }),
    width => 500, height => 350
  });

=head1 METHODS

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