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

sub template_output_edit_content_data {
    my ($cb, $app, $tmpl_str_ref, $param, $tmpl) = @_;
    my $old = '\s+}\);\n\s+}\n\s+editor_strategy.prototype._setWithHeight \= function\(app, id, height\){';
    my $new = <<EOS;

        if (jQuery('#' + this).hasClass('tinymce-content-field')) {
          var editor = app.editors[this];
          app.editors[this]['setFormat'] = function(format) {
            setFormat.apply(editor, [format]);
          };
        }
    });
  }
  editor_strategy.prototype._setWithHeight = function(app, id, height){
EOS

    $$tmpl_str_ref =~ s!$old!$new!;


    $old = '\s+app.editors\[this\] \= new MT\.EditorManager\(this, {';
    $new = <<EOS;

        format = format.replace('-full', '');
        app.editors[this] = new MT.EditorManager(this, {
EOS

    $$tmpl_str_ref =~ s!$old!$new!;
}

1;
