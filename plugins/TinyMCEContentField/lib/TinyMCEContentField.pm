package TinyMCEContentField;

use strict;
use warnings;

our @EXPORT = qw( plugin translate );
use base qw(Exporter);

sub translate {
    MT->component('TinyMCEContentField')->translate(@_);
}

sub plugin {
    MT->component('TinyMCEContentField');
}

1;
