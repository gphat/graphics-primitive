package Graphics::Primitive::Paint::Gradient;
use Moose;
use Moose::Util::TypeConstraints;
use MooseX::AttributeHelpers;

# FIXME key should be <= 1

use Data::Dumper;

has colors => (
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

has type => (
    isa => 'Str',
    is  => 'rw',
    default => sub { 'linear' }
);

no Moose;
1;
__END__
=head1 NAME

Grahics::Primitive::Paint::Gradient

=head1 DESCRIPTION

Graphics::Primitive::Paint::Gradient is a

=head1 SYNOPSIS

  use Graphics::Primitive::Paint::Gradient;

  my $canvas = Graphics::Primitive::Gradient->new;

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitive::Gradient

=back

=head2 Instance Methods

=over 4

I<add_stop>

Adds a color stop at the specified position

=back

=head1 AUTHOR

Cory Watson <gphat@cpan.org>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

You can redistribute and/or modify this code under the same terms as Perl
itself.
