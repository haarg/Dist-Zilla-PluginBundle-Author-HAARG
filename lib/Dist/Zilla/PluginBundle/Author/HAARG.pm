package Dist::Zilla::PluginBundle::Author::HAARG;
use Moose;
use experimental qw(signatures);

our $VERSION = 'v0.1.0';

use namespace::autoclean;

with qw(Dist::Zilla::Role::PluginBundle);

sub bundle_config ($class, $section) {
  return ();
}

__PACKAGE__->meta->make_immutable;
1;

__END__

=encoding UTF-8

=head1 NAME

Dist::Zilla::PluginBundle::Author::HAARG - A bundle of Dist::Zilla modules for haarg

=head1 DESCRIPTION

This is a collection of Dist::Zilla plugins for doing releases the way haarg
does.

Unlike most PluginBundles, this is not meant to be used in a F<dist.ini>.
Instead, it just serves as documentation for this group of modules.

If used as a bundle, it will do nothing.

=head1 Dist::Zilla Plugins

=head2 L<[SimpleBootstrap]|Dist::Zilla::Plugin::SimpleBootstrap>

A simple bootstrapping module to allow a local version of a Dist::Zilla plugin
to be loaded. Allows modules in F<lib> to be loaded, and sets up F<share> as a
dist share dir.

In comparison to other bootstrapping modules, this also works for modules
loaded after the initial configuration, such as Pod::Weaver plugins.

=head1 Pod::Weaver Plugins

=head2 L<[-BarePod]|Pod::Weaver::Plugin::BarePod>

Removes the C<=pod> prelude to the generated pod.

=head2 L<[Authors::WithStopWords]|Pod::Weaver::Section::Authors::WithStopWords>

Like the L<[Authors]|Pod::Weaver::Section::Authors> section, but includes the
author names in a C<=for stopwords> section. This is placed immediately before
the author section. It is an alternative to the plugin
L<[-Stopwords]|Pod::Weaver::Plugin::Stopwords>, which places the stopwords at
the top of the pod.

=head2 L<[Legal::WithStopWords]|Pod::Weaver::Section::Legal::WithStopWords>

Like the L<[Legal]|Pod::Weaver::Section::Legal> section, but includes the
copyright holder in a C<=for stopwords> section. This is placed immediately
before the legal notice. It is an alternative to the plugin
L<[-Stopwords]|Pod::Weaver::Plugin::Stopwords>, which places the stopwords at
the top of the pod.
