use inc::Module::Install 0.75;

name     'Graphics-Primitive';
all_from 'lib/Graphics/Primitive.pm';
author   'Cory G Watson <gphat@cpan.org>';

build_requires 'Test::More';

requires 'Geometry::Primitive' => '0.12';
requires 'Graphics::Color' => '0.14';
requires 'Moose' => '0.54';
requires 'MooseX::Clone' => '0.03';
requires 'MooseX::AttributeHelpers' => '0.12';
requires 'MooseX::Storage' => '0.14';
requires 'Forest' => '0.04';
requires 'Text::Flow' => '0.01';

auto_install;

WriteAll;
