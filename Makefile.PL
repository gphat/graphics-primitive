use inc::Module::Install 0.75;

name     'Graphics-Primitive';
all_from 'lib/Graphics/Primitive.pm';
author   'Cory G Watson <gphat@cpan.org>';

build_requires 'Test::More';

requires 'Geometry::Primitive' => '0.09';
requires 'Graphics::Color' => '0.12';
requires 'Moose' => '0.54';
requires 'MooseX::Clone' => '0.03';
requires 'MooseX::AttributeHelpers' => '0.12';
requires 'Forest' => '0.02';
requires 'Text::Flow' => '0.01';

auto_install;

WriteAll;
