use inc::Module::Install 0.75;

name     'Graphics-Primitive';
all_from 'lib/Graphics/Primitive.pm';
author   'Cory G Watson <gphat@cpan.org>';

build_requires 'Test::More';

test_requires 'Pod::Coverage::Moose';

requires 'Geometry::Primitive' => '0.04';
requires 'Graphics::Color' => '0.04';
requires 'Layout::Manager' => '0.08';
requires 'Moose' => '0.54';
requires 'MooseX::AttributeHelpers' => '0.12';

auto_install;

WriteAll;
