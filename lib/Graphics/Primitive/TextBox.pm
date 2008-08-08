package Graphics::Primitive::TextBox;
use Moose;

extends 'Graphics::Primitive::Component';

with 'MooseX::Clone';

use Graphics::Primitive::Font;
use Text::Flow;

has 'angle' => (
    is => 'rw',
    isa => 'Num'
);
has 'font' => (
    is => 'rw',
    isa => 'Graphics::Primitive::Font',
    default => sub { Graphics::Primitive::Font->new }
);
has 'line_height' => (
    is => 'rw',
    isa => 'Num'
);
has 'lines' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [] }
);
has 'text' => (
    is => 'rw',
    isa => 'Str',
);
has 'text_bounding_box' => (
    is => 'rw',
    isa => 'Geometry::Primitive::Rectangle'
);

override('pack', sub {
    my ($self, $driver) = @_;

    super;

    unless(scalar(@{ $self->lines })) {
        $self->layout_text($driver);
    }
});

override('prepare', sub {
    my ($self, $driver) = @_;

    super;

    if($self->width && $self->height) {
        $self->layout_text($driver);
    } else {
        my @lines = split("\n", $self->text);
        foreach my $line (@lines) {
            my ($bb, $tb)  = $driver->get_text_bounding_box(
                $self->font, $self->text, $self->angle
            );

            $self->text_bounding_box($tb);
            $self->minimum_height($self->minimum_height + $bb->height);
            $self->minimum_width($self->minimum_width + $bb->width);
            push(@{ $self->lines }, { text => $line, box => $tb });
        }
    }
});

sub layout_text {
    my ($self, $driver) = @_;

    # TODO Set a minimum size if we don't need the whole thing

    my $flow = Text::Flow->new(
        check_height => sub {
            my $paras = shift;

            my $lh = $self->line_height;
            $lh = $self->font->size unless(defined($lh));

            my $size = 0;
            foreach my $p (@{ $paras }) {
                if(defined($lh)) {
                    # use Data::Dumper;
                    # print Dumper($p);
                    $size += $lh * scalar(@{ $p });
                # } else {
                    # map(
                    #     {
                            # my ($cb, $tb) = $driver->get_text_bounding_box(
                            #     $self->font, $_
                            # );
                            # print $tb->origin->y." ".$cb->height."\n";
                            # $size += abs($tb->origin->y);
                    #     } @{ $p }
                    # );
                }
            }
            # print "#### $size ".$self->inside_height."\n";
            if(($size + $lh) >= $self->inside_height) {
                return 0;
            }
            return 1;
        },
        wrapper => Text::Flow::Wrap->new(
            check_width => sub {
                my $str = shift;
                my $r = $driver->get_text_bounding_box(
                    $self->font, $str
                );
                if($r->width > $self->inside_width) {
                    return 0;
                }
                return 1;
            }
        )
    );

    my @text = $flow->flow($self->text);

    # use Data::Dumper;
    # print Dumper(\@text);

    # foreach my $para (@text) {
        my $para = $text[0];
        # print "XXXX\n";
        my @lines = split(/\n/, $para);
        foreach my $line (@lines) {
            my ($cb, $tb) = $driver->get_text_bounding_box($self->font, $line);
            push(@{ $self->lines }, {
                text => $line,
                box => $cb
            });
        }
    # }
}

__PACKAGE__->meta->make_immutable;

1;
__END__
=head1 NAME

Graphics::Primitive::TextBox - Text component

=head1 DESCRIPTION

Graphics::Primitive::TextBox is a Componet with text.

=head1 SYNOPSIS

  use Graphics::Primitive::Font;
  use Graphics::Primitive::TextBox;

  my $tx = Graphics::Primitive::TextBox->new(
      font => Graphics::Primitive::Font->new(
          face => 'Myriad Pro',
          size => 12
      ),
      text => 'I am a textbox!'
  );

=head1 WARNING

This component is likely to change drastically.  Here be dragons.

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Primitive::TextBox.

=back

=head2 Instance Methods

=over 4

=item I<font>

Set this textbox's font

=item I<text>

Set this textbox's text.

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