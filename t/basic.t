use strict;
use warnings;

use Test::More;

use Dist::Zilla::Plugin::SimpleBootstrap;
use Dist::Zilla::PluginBundle::Author::HAARG;
use Dist::Zilla::MintingProfile::Author::HAARG;
use Pod::Weaver::Section::Authors::WithStopWords;
use Pod::Weaver::Document::Role::Bare;
use Pod::Weaver::Section::Legal::WithStopWords;
use Pod::Weaver::Plugin::BarePod;
use Pod::Weaver::Section::Role::WithStopWords;

ok 1, 'all modules loaded';

done_testing;
