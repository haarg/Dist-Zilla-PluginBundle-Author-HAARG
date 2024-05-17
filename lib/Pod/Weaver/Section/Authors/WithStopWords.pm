package Pod::Weaver::Section::Authors::WithStopWords;
use Moose;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use namespace::autoclean;

extends 'Pod::Weaver::Section::Authors';
with 'Pod::Weaver::Section::Role::WithStopWords';

sub stopwords_for ($self, $input) {
  return unless $input->{authors};

  return map s/\s+<\S+@.*//r, $input->{authors}->@*;
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=encoding UTF-8

=head1 NAME

Pod::Weaver::Section::Authors::WithStopWords - Place C<=for stopwords> for author section next to author section

=head1 OVERVIEW

The standard L<[-StopWords]|Pod::Weaver::Plugin::StopWords> plugin places all of
stopwords in a single block at the top of the Pod document. This will cause a
larger difference between the source document and the final document.

Instead, this section works the same as the standard
L<[Author]|Pod::Weaver::Section::Authors> section, but also places any relevant
stopwords for the author section immediately before it.
