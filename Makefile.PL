use inc::Module::Install 0.75;

name     'Graphics-Primitive';
all_from 'lib/Graphics/Primitive.pm';
author   'Cory G Watson <gphat@cpan.org>';

build_requires 'Test::More';

requires 'Geometry::Primitive' => '0.13';
requires 'Graphics::Color' => '0.20';
requires 'Moose' => '0.74';
requires 'MooseX::Clone' => '0.03';
requires 'MooseX::AttributeHelpers' => '0.17';
requires 'MooseX::Storage' => '0.17';
requires 'Forest' => '0.06';

WriteAll;
