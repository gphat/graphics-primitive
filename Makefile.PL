use inc::Module::Install 0.75;

name     'Graphics-Primitive';
all_from 'lib/Graphics/Primitive.pm';
author   'Cory G Watson <gphat@cpan.org>';

build_requires 'Test::More';

test_requires 'Pod::Coverage::Moose';

requires 'Geometry::Primitive' => '0.05';
requires 'Graphics::Color' => '0.06';
requires 'Moose' => '0.54';
requires 'MooseX::Clone' => '0.03';
requires 'MooseX::AttributeHelpers' => '0.12';
requires 'Tree::Simple' => '1.18';

auto_install;

WriteAll;
