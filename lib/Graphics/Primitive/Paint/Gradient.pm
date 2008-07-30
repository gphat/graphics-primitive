package Graphics::Primitive::Paint::Gradient;
use Moose;
use Moose::Util::TypeConstraints;
use MooseX::AttributeHelpers;

# FIXME key should be <= 1

use Data::Dumper;

has color_stops => (
    metaclass => 'Collection::Hash',
    isa => 'HashRef',
    is  => 'rw',
    default =>  sub { {} },
    provides => {
        count => 'stop_count',
        keys => 'stops',
        get  => 'get_stop',
        set  => 'add_stop'
    }
);

enum 'Graphics::Primitive::Paint::Gradient::Styles' => qw(radial linear);

has style => (
    isa => 'Graphics::Primitive::Paint::Gradient::Styles',
    is  => 'rw',
    default => sub { 'linear' }
);

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__
=head1 NAME

Grahics::Primitive::Paint::Gradient

=head1 DESCRIPTION

Graphics::Primitive::Paint::Gradient is a

=head1 SYNOPSIS

  use Graphics::Primitive::Paint::Gradient;

  my $gradient = Graphics::Primitive::Gradient->new;

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitive::Gradient

=back

=head2 Instance Methods

=over 4

=item I<add_stop>

Adds a color stop at the specified position

=item I<colors>

Hashref of colors and their stops.  The stops are the keys.

=item I<stop_count>

Count of stops added to this Gradient.

=item I<stops>

Get the keys of all color stops.

=item I<style>

Get/Set the style of this Gradient.

=back

=head1 AUTHOR

Cory Watson <gphat@cpan.org>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

You can redistribute and/or modify this code under the same terms as Perl
itself.
