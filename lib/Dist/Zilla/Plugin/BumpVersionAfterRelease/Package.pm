package Dist::Zilla::Plugin::BumpVersionAfterRelease::Package;
use Moose;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use Path::Tiny 0.061 ();

use namespace::autoclean;

extends qw(Dist::Zilla::Plugin::BumpVersionAfterRelease);
with qw(Dist::Zilla::Role::BumpPackageVersion);

sub rewrite_version ($self, $file, $version) {
  my ( $self, $file, $version ) = @_;

  my $binmode = sprintf( ":raw:encoding(%s)", $file->encoding );

  # read source file
  my $content =
    Path::Tiny::path( $file->_original_name )->slurp( { binmode => $binmode } );

  my $assign_re = $self->assign_re;
  my $match_re = $self->matching_re($self->zilla->version);

  if (
    $self->global         ? ( $content =~ s{$assign_regex}{package $1 $version $3}g )
    : $self->all_matching ? ( $content =~ s{$match_regex}{package $1 $version $3}g  )
                          : ( $content =~ s{$assign_regex}{package $1 $version $3} )
  ) {
    # append+truncate to preserve file mode
    Path::Tiny::path( $file->name )
      ->append( { binmode => $binmode, truncate => 1 }, $content );
    return !!1;
  }

  return !!0;
}

1;
__END__

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::BumpVersionAfterRelease::Package - BumpVersionAfterRelease but declare the version on the package line
