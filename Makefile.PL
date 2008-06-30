use inc::Module::Install;

name     'Graphics-Primitive';
all_from 'lib/Graphics/Primitive.pm';
author   'Cory G Watson <cory.watson@iinteractive.com>';

build_requires 'Test::More';

test_requires 'Pod::Coverage::Moose';

requires 'Geometry::Primitive';
requires 'Graphics::Color';
requires 'Moose';
requires 'MooseX::AttributeHelpers';

auto_install;

WriteAll;
