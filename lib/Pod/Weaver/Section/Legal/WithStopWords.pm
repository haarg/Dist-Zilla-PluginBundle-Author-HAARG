package Pod::Weaver::Section::Legal::WithStopWords;
use Moose;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use namespace::autoclean;

extends 'Pod::Weaver::Section::Legal';
with 'Pod::Weaver::Section::Role::WithStopWords';

sub stopwords_for ($self, $input) {
  return unless $input->{license};

  return $input->{license}->holder;
}

__PACKAGE__->meta->make_immutable;
1;
