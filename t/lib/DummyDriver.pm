package # hide from the CPAN
    DummyDriver;
use Moose;

with 'Graphics::Primitive::Driver';

has 'drawn_components' => (
    traits => [qw(Array)],
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [] },
    handles => {
        'draw_component_called' => 'count',
        'add_drawn_component' => 'push'
    }
);

sub _do_fill { }

sub _do_stroke { }

sub _draw_arc { }

sub _draw_bezier { }

sub _draw_canvas { }

sub _draw_circle { }

sub _draw_component {
    my ($self, $comp) = @_;

    $self->add_drawn_component($comp);
    # $self->draw_component_called(
    #     $self->draw_component_called + 1
    # );
}

sub _draw_ellipse { }

sub _draw_line { }

sub _draw_path { }

sub _draw_polygon { }

sub _draw_rectangle { }

sub _draw_textbox { }

sub _finish_page { }

sub _resize { }

sub data { }

sub get_text_bounding_box { }

sub get_textbox_layout { }

sub reset { }

sub write { }

no Moose;
1;