package Dist::Zilla::PluginBundle::Author::HAARG;
use Moose;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use namespace::autoclean;

with qw(Dist::Zilla::Role::PluginBundle);

sub bundle_config {
  die 'This is not a real plugin bundle, but just a collection of modules.';
}

1;

__END__

=encoding UTF-8

=head1 NAME

Dist::Zilla::PluginBundle::Author::HAARG - A bundle of Dist::Zilla modules for haarg
