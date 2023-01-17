package inc::lib;
use Moose;
use experimental qw(signatures);

use namespace::autoclean;

with qw(
  Dist::Zilla::Role::Plugin
  Dist::Zilla::Role::BeforeBuild
);

has lib => (
  is      => 'rw',
  writer  => '_set_lib',
);

# called when reading dist.ini
after register_component => sub ($class, $name, $arg, $section) {
  my $zilla = $section->sequence->assembler->zilla;
  my $self = $zilla->plugins->[-1];
  $self->_set_lib($zilla->root->child('lib')->absolute);
  $self->install_lib;
};

# @INC is localized when register_component is called, so re-add our lib dir
# whe build starts
sub before_build ($self) {
  $self->install_lib;
}

sub install_lib ($self) {
  my $lib = $self->lib->stringify;

  unshift @INC, $lib
    unless grep $_ eq $lib, @INC;
}

1;
