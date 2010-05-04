use inc::Module::Install 0.75;

name     'Graphics-Primitive';
all_from 'lib/Graphics/Primitive.pm';
author   'Cory G Watson <gphat@cpan.org>';

build_requires 'Test::More';

requires 'Geometry::Primitive' => '0.21';
requires 'Graphics::Color' => '0.20';
requires 'Moose' => '0.90';
requires 'MooseX::Aliases' => '0.08';
requires 'MooseX::Clone' => '0.04';
requires 'MooseX::Storage' => '0.17';
requires 'MooseX::Types' => '0.21';
requires 'Forest' => '0.06';
requires 'Scene::Graph' => '0.02';

repository 'git://github.com/gphat/graphics-primitive.git';

WriteAll;
