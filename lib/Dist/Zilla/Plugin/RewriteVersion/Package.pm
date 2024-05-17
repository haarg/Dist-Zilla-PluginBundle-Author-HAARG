package Dist::Zilla::Plugin::RewriteVersion::Package;
use Moose;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use namespace::autoclean;

extends qw(Dist::Zilla::Plugin::RewriteVersion);
with qw(Dist::Zilla::Role::BumpPackageVersion);

sub rewrite_version ($self, $file, $version) {
  my $content = $file->content;

  my $extra = '';
  $extra .= " # TRIAL" if $self->zilla->is_trial;

  if ( $self->add_tarball_name ) {
    my $tarball = $self->zilla->archive_filename;
    $extra .= ( $self->zilla->is_trial ? "" : " #" ) . " from $tarball";
  }

  my $assign_regex = $self->assign_re;
  if (
    $self->global
      ? ( $content =~ s{$assign_regex}{package $1 $version $2$extra}g )
      : ( $content =~ s{$assign_regex}{package $1 $version $2$extra} )
  ) {
    $file->content($content);
    return !!1;
  }

  return !!0;
}

1;
__END__

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::RewriteVersion::Package - RewriteVersion but declare the version on the package line
