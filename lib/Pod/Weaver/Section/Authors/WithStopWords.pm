package Pod::Weaver::Section::Authors::WithStopWords;
use Moose;
use experimental qw(signatures);

use namespace::autoclean;

extends 'Pod::Weaver::Section::Authors';
with 'Pod::Weaver::Section::Role::WithStopWords';

sub stopwords_for ($self, $input) {
  return unless $input->{authors};

  return map s/\s+<\S+@.*//r, $input->{authors}->@*;
}

1;
