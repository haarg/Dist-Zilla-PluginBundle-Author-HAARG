package Pod::Weaver::Plugin::BarePod;
use Moose;
use experimental qw(signatures);

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
