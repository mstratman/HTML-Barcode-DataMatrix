package HTML::Barcode::DataMatrix;
use Any::Moose;
extends 'HTML::Barcode::2D';

use Any::Moose '::Util::TypeConstraints';
use Barcode::DataMatrix;

our $VERSION = '0.01';

has '+module_size' => ( default => '3px' );
has 'encoding_mode' => (
    is       => 'ro',
    isa      => enum('HTMLBCDM_EncodingMode', qw[ ASCII C40 TEXT BASE256 NONE AUTO ]),
    required => 1,
    default  => 'AUTO',
    documentation => 'The encoding mode for the data matrix. Can be one of: ASCII C40 TEXT BASE256 NONE AUTO',
);
has 'process_tilde' => (
    is       => 'ro',
    isa      => 'Bool',
    required => 1,
    default  => 0,
    documentation => 'Set to true to indicate the tilde character "~" is being used to recognize special characters.',
);
has '_datamatrix' => (
    is      => 'ro',
    lazy    => 1,
    builder => '_build_datamatrix',
);
sub _build_datamatrix {
    my $self = shift;
    return Barcode::DataMatrix->new(
        encoding_mode => $self->encoding_mode,
        process_tilde => $self->process_tilde,
    );
}

sub barcode_data {
    my ($self) = @_;
    # Its barcode() methods returns an AoA just like we need it.
    return $self->_datamatrix->barcode($self->text);
}

=head1 NAME

HTML::Barcode::DataMatrix - Generate HTML representations of Data Matrix barcodes

=head1 SYNOPSIS

  my $barcode = HTML::Barcode::DataMatrix->new(text => 'http://search.cpan.org');
  print $code->render;

=head1 DESCRIPTION

This class allows you easily create HTML representations of Data Matrix
barcodes.

=begin html

<p>Here is an example of a barcode rendered with this module:</p>

=end html

You can read more about Data Matrix barcodes online
(e.g. L<http://en.wikipedia.org/wiki/Data_Matrix>)

=head1 METHODS

=head2 new (%attributes)

Instantiate a new HTML::Barcode::DataMatrix object. The C<%attributes> hash
requires the L</text> attribute, and can take any of the other
L<attributes|/ATTRIBUTES> listed below.

=head2 render

This is a convenience routine which returns C<< <style>...</style> >> tags
and the rendered barcode.

If you are printing multiple barcodes or want to ensure your C<style> tags
are in your HTML headers, then you probably want to output the barcode
and style separately with L</render_barcode> and
L</css>.

=head2 render_barcode

Returns only the rendered barcode.  You will need to provide stylesheets
separately, either writing them yourself or using the output of L</css>.

=head2 css

Returns CSS needed to properly display your rendered barcode.  This is
only necessary if you are using L</render_barcode> instead of the
easier L</render> method.

=head1 ATTRIBUTES

These attributes can be passed to L<new|/"new (%attributes)">, or used
as accessors.

=head2 text

B<Required> - The information to put into the barcode.

=head2 encoding_mode

The encoding mode for the data matrix. Can be one of:
C<AUTO> (default), C<ASCII>, C<C40>, C<TEXT>, C<BASE256>, or C<NONE>.

=head2 process_tilde

Set to true to indicate the tilde character "~" is being used to recognize
special characters. See this page for more information:
L<http://www.idautomation.com/datamatrixfaq.html>

=head2 foreground_color

A CSS color value (e.g. '#000' or 'black') for the foreground. Default is '#000'.

=head2 background_color

A CSS color value background. Default is '#fff'.

=head2 module_size

A CSS value for the width and height of an individual module (a dot) in the
code. Default is '3px'.

=head2 css_class

The value for the C<class> attribute applied to any container tags
in the HTML (e.g. C<table> or C<div>).
C<td> tags within the table will have either css_class_on or css_class_off
classes applied to them.

For example, if css_class is "barcode", you will get C<< <table class="barcode"> >> and its cells will be either C<< <td class="barcode_on"> >> or
C<< <td class="barcode_off"> >>.

=head2 embed_style

Rather than rendering CSS stylesheets, embed the style information
in HTML C<style> attributes.  You should not use this option without
good reason, as it greatly increases the size of the generated markup,
and makes it impossible to override with stylesheets.

=head1 AUTHOR

Mark A. Stratman, C<< <stratman@gmail.com> >>

=head1 SOURCE REPOSITORY

L<http://github.com/mstratman/HTML-Barcode-DataMatrix>

=head1 SEE ALSO

L<Barcode::DataMatrix>

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Mark A. Stratman.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

no Any::Moose;
1;
