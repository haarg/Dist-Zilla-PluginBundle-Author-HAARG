package Dist::Zilla::MintingProfile::Author::HAARG;
use Moose;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use File::ShareDir ();
use Path::Tiny qw(path);
use Carp qw(confess);

use namespace::autoclean;

with qw(Dist::Zilla::Role::MintingProfile);

sub profile_dir ($self, $profile_name) {
  my $dist_name = 'Dist-Zilla-PluginBundle-Author-HAARG';
  my $profile_dir = path(File::ShareDir::dist_dir($dist_name))->child('profiles', $profile_name);
  return $profile_dir if -d $profile_dir;

  confess "Can't find profile $profile_name via $self: it should be in $profile_dir";
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=encoding UTF-8

=head1 NAME

Dist::Zilla::MintingProfile::Author::HAARG - Mint a dist like haarg

=head1 SYNOPSIS

  $ dzil new -P Author::HAARG

  $ dzil new -P Author::HAARG -p distar
