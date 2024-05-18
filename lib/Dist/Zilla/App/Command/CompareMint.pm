package Dist::Zilla::App::Command::CompareMint;
use strict;
use warnings;
use Dist::Zilla::App -command;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use namespace::autoclean;

sub command_names { 'compare-mint' }

sub opt_spec {
  [ 'profile|p=s',  'name of the profile to use' ],
  [ 'provider|P=s', 'name of the profile provider to use' ],
}

sub execute ($self, $opt, $arg) {
  my $global_stash = $self->app->_build_global_stashes;
  my $zilla = $self->zilla;

  my $global_mint_stash = $global_stash->{'%Mint'};
  my $dist_mint_stash = $zilla->stash_named('%Mint');

  my $provider
    = $opt->provider
    // ($dist_mint_stash && $dist_mint_stash->provider)
    // ($global_mint_stash && $global_mint_stash->provider)
    // 'Default';

  my $profile
    = $opt->profile
    // ($dist_mint_stash && $dist_mint_stash->profile)
    // ($global_mint_stash && $global_mint_stash->profile)
    // 'Default';

  require Dist::Zilla::Dist::Minter;
  my $minter = Dist::Zilla::Dist::Minter->_new_from_profile(
    [ $provider, $profile ],
    {
      chrome  => $self->app->chrome,
      name    => $self->zilla->name,
      _global_stashes => $global_stash,
    },
  );

  $_->gather_files       for @{ $minter->plugins_with(-FileGatherer) };
  $_->set_file_encodings for @{ $minter->plugins_with(-EncodingProvider) };
  $_->prune_files        for @{ $minter->plugins_with(-FilePruner) };
  $_->munge_files        for @{ $minter->plugins_with(-FileMunger) };

  require Text::Diff;

  for my $file ($minter->files->@*) {
    my $name = $file->name;
    next
      if $name =~ m{/} || $name eq 'Changes';

    my $disk_file = $self->zilla->root->child($file->name);
    my $disk_content = $disk_file->slurp_raw;
    my $mint_content = $file->encoded_content;

    my $diff = Text::Diff::diff(\$disk_content, \$mint_content, {
      STYLE => 'Unified',
      FILENAME_A => $name,
      FILENAME_B => $name,
    });

    next
      if !defined $diff;

    print $diff;
  }
}

1;
__END__

=encoding UTF-8

=head1 NAME

Dist::Zilla::App::Command::CompareMint - Compare files to what a minting profile produces

=head1 SYNOPSIS

  $ dzil comparemint

=head1 DESCRIPTION

Displays a diff of the current dist with what would be created by minting a
dist with the same name.

New files and hunks that only add lines will be excluded from the output.

While the output is produced using unified diff format, it is only meant to be
interpreted by a human.
