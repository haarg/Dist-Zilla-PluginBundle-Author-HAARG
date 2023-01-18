use strict;
use warnings;

use Test::More;

use {{ $dist->name =~ s/-/::/gr }};

ok 1, 'Modules loaded properly';

done_testing;
