package Pod::Weaver::Section::Role::WithStopWords;
use Moose::Role;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use Pod::Elemental::Element::Pod5::Command;

use namespace::autoclean;

requires 'stopwords_for';

before weave_section => sub ($self, $document, $input) {
  my @stopwords = $self->stopwords_for($input);
  return unless @stopwords;

  my $section = Pod::Elemental::Element::Pod5::Command->new({
    command => 'for',
    content => join(' ', 'stopwords', @stopwords),
  });

  push $document->children->@*, $section;
};

1;
