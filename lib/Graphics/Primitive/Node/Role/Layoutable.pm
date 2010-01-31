package Graphics::Primitive::Node::Role::Layoutable;
use Moose::Role;

has 'layout_manager' => (
    is => 'rw',
    isa => 'Layout::Manager',
    handles => [ 'do_layout' ],
    predicate => 'has_layout_manager'
);

1;

__END__

=head1 NAME

Graphics::Primitive::Node::Role::Layoutable - A node suitable for layout

=head1 DESCRIPTION

Adds dimensions, margins and padding to a node.

=head1 ATTRIBUTES

=head2 layout_manager

The layout manager used by this node.

=head1 AUTHOR

Cory G Watson, C<< <gphat at cpan.org> >>

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2010 Cold Hard Code, LLC.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.