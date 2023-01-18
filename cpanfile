requires 'perl' => 'v5.20';

requires 'Carp';
requires 'File::ShareDir';
requires 'Moose';
requires 'Moose::Role';
requires 'Moose::Util';
requires 'Path::Tiny';
requires 'Pod::Elemental::Element::Pod5::Command';
requires 'namespace::autoclean';

on test => sub {
  requires 'Test::More';
};
