package Dist::Zilla::Plugin::SimpleBootstrap;
use Moose;
use experimental qw(signatures);

use File::ShareDir ();

use namespace::autoclean;

with qw(
  Dist::Zilla::Role::Plugin
  Dist::Zilla::Role::BeforeBuild
);

# called when reading dist.ini
after register_component => sub ($class, $name, $arg, $section) {
  my $zilla = $section->sequence->assembler->zilla;
  my $self = $zilla->plugins->[-1];
  $self->install_lib;
};

# @INC is localized when register_component is called, so re-add our lib dir
# whe build starts
sub before_build ($self) {
  $self->install_lib;
}

sub install_lib ($self) {
  my $zilla = $self->zilla;
  my $root = $zilla->root->absolute;

  my $lib = $root->child('lib')->stringify;

  unshift @INC, $lib
    unless grep $_ eq $lib, @INC;

  my $share = $root->child('share');
  if (-d $share) {
    $File::ShareDir::DIST_SHARE{$zilla->name} //= $share;
  }
}

__PACKAGE__->meta->make_immutable;

# hack to allow this plugin to bootstrap itself
if (my $self_boot = $INC{'lib/Dist/Zilla/Plugin/SimpleBootstrap.pm'}) {
  if ($self_boot eq __FILE__) {
    $INC{'Dist/Zilla/Plugin/SimpleBootstrap.pm'} //= __FILE__;
    local $@;
    eval q{
      package lib::Dist::Zilla::Plugin::SimpleBootstrap;
      use Moose;
      extends qw(Dist::Zilla::Plugin::SimpleBootstrap);
      __PACKAGE__->meta->make_immutable;
      1;
    } or die $@;
  }
}
1;
