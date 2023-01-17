package Pod::Weaver::Document::Role::Bare;
use Moose::Role;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use namespace::autoclean;

around as_pod_string => sub ($orig, $self, @rest) {
  my $string = $self->$orig(@rest);
  $string =~ s/\A\n*=pod\n\n+(=\w+)/$1/;
  $string =~ s/\n+=cut\n*\z/\n/;
  return $string;
};

1;
