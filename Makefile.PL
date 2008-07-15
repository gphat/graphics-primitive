use inc::Module::Install 0.75;

name     'Graphics-Primitive';
all_from 'lib/Graphics/Primitive.pm';
author   'Cory G Watson <gphat@cpan.org>';

build_requires 'Test::More';

test_requires 'Pod::Coverage::Moose';

requires 'Geometry::Primitive';
requires 'Graphics::Color';
requires 'Layout::Manager';
requires 'Moose';
requires 'MooseX::AttributeHelpers';

auto_install;

WriteAll;
