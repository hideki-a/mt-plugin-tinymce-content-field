package TinyMCEContentField::App;

use strict;
use warnings;

use TinyMCEContentField;

sub field_html_params {
    my ( $app, $field_data ) = @_;
    my $options      = $field_data->{options};
    my $required     = $options->{required} ? 'data-mt-required="1"' : '';

    {   
        required       => $required,
    };
}

sub data_load_handler {
    my ( $app, $field_data ) = @_;

    my $field_id = $field_data->{id};
    return scalar $app->param("tinymce-field-$field_id");
}

1;
