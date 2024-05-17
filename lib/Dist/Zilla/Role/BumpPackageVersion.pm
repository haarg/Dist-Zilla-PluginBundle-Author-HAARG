package Dist::Zilla::Role::BumpPackageVersion;
use Moose::Role;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use version ();

use namespace::autoclean;

sub check_valid_version ($self, $version) {
  $self->log_fatal("only strict versions are allowed")
    unless version::is_strict($version);
  return;
}

sub assign_re ($self, $version = $version::STRICT) {
  return qr{^package\s+([\w:]+)(?:\s+($version))?\s*(\{|;)\s*(?:\#.*)?$}m;
}

sub matching_re ($self, $version) {
  $self->assign_re(quotemeta $version);
}

1;
