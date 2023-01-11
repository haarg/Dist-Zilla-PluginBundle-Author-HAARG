package Pod::Weaver::Section::Legal::WithStopWords;
use Moose;
use experimental qw(signatures);

use namespace::autoclean;

extends 'Pod::Weaver::Section::Legal';
with 'Pod::Weaver::Section::Role::WithStopWords';

sub stopwords_for ($self, $input) {
  return unless $input->{license};

  return $input->{license}->holder;
}

1;
