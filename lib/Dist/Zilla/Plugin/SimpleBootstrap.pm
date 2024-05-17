package Dist::Zilla::Plugin::SimpleBootstrap;
use Moose;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use File::ShareDir ();

use namespace::autoclean;

with qw(
  Dist::Zilla::Role::Plugin
  Dist::Zilla::Role::BeforeBuild
);

has lib => (
  is => 'ro',
  default => 'lib',
);

has share => (
  is => 'ro',
  default => 'share',
);

# called when reading dist.ini. @INC is localized while reading dist.ini, so
# this won't last after reading.
after register_component => sub ($class, $name, $arg, $section) {
  my $zilla = $section->sequence->assembler->zilla;
  my $self = $zilla->plugins->[-1];
  $self->install_lib;
};

# reinstall into @INC before building, so anything loaded by plugins will have
# our lib dir.
sub before_build ($self) {
  $self->install_lib;
}

sub install_lib ($self) {
  my $zilla = $self->zilla;
  my $root = $zilla->root->absolute;

  my $lib = $root->child($self->lib)->stringify;

  unshift @INC, $lib
    unless grep $_ eq $lib, @INC;

  my $share = $root->child($self->share);
  if (-d $share) {
    $File::ShareDir::DIST_SHARE{$zilla->name} //= $share;
  }
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::SimpleBootstrap - Bootstrap a Dist::Zilla library
