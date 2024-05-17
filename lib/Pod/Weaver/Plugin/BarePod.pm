package Pod::Weaver::Plugin::BarePod;
use Moose;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use Moose::Util;
use Pod::Weaver::Document::Role::Bare;

use namespace::autoclean;

with 'Pod::Weaver::Role::Finalizer';

sub finalize_document ($self, $document, $input) {
  Moose::Util::apply_all_roles($document, 'Pod::Weaver::Document::Role::Bare');
  return;
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=encoding UTF-8

=head1 NAME

Pod::Weaver::Plugin::BarePod - Remove leading =pod and trailing =cut

=head1 OVERVIEW

Most Pod documents start with a C<=word> command, so a leading C<=pod> is not
needed. Similarly, most Pod documents end at the end of the file, so a trailing
C<=cut> is not needed.

By default, L<Pod::Weaver> will always include those extraneous commands. This
plugin will remove them.
