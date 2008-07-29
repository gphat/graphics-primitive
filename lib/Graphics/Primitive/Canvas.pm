package Graphics::Primitive::Canvas;
use Moose;
use MooseX::AttributeHelpers;

extends 'Graphics::Primitive::Component';

use Graphics::Primitive::Path;

has path => (
    isa => 'Graphics::Primitive::Path',
    is  => 'rw',
    default =>  sub { Graphics::Primitive::Path->new },
    handles => [ 'current_point', 'line_to', 'move_to', 'rel_line_to' ]
);

has paths => (
    metaclass => 'Collection::Array',
    isa => 'ArrayRef',
    is  => 'rw',
    default =>  sub { [] },
    provides => {
        push => 'add_path',
        count=> 'path_count'
    }
);

has saved_paths => (
    metaclass => 'Collection::Array',
    isa => 'ArrayRef',
    is  => 'rw',
    default =>  sub { [] },
    provides => {
        push => 'push_path',
        pop  => 'pop_path',
        count => 'saved_path_count'
    }
);

sub do {
    my ($self, $op) = @_;

    $self->add_path({ op => $op, path => $self->path });
    $self->path(Graphics::Primitive::Path->new);
}

sub save {
    my ($self) = @_;

    $self->push_path($self->path->clone);
}

sub restore {
    my ($self) = @_;

    return if($self->saved_path_count < 1);

    $self->path($self->pop_path);
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__
=head1 NAME

Grahics::Primitive::Canvas

=head1 DESCRIPTION

Graphics::Primitive::Canvas is a component for drawing arbitrary things.  It
holds L<Paths|Graphics::Primitive::Path> and
L<Operations|Graphics::Primitive::Operation>.

=head1 SYNOPSIS

  use Graphics::Primitive::Canvas;

  my $canvas = Graphics::Primitive::Canvas->new;

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitive::Canvas

=back

=head2 Instance Methods

=over 4

I<do>

Given an operation, pushes the current path onto the path stack.

  FIXME: Example

I<path>

The current path this canvas is using.



=back

=head1 AUTHOR

Cory Watson <gphat@cpan.org>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

You can redistribute and/or modify this code under the same terms as Perl
itself.