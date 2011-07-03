use inc::Module::Install;
name 'HTML-Barcode-DataMatrix';
license 'perl';
all_from 'lib/HTML/Barcode/DataMatrix.pm';

requires 'HTML::Barcode'       => '0.09';
requires 'Any::Moose'          => '0.15';
requires 'Barcode::DataMatrix' => '0.01';

tests 't/*.t';

test_requires 'Test::More';
githubmeta;
auto_include;
auto_install;
WriteAll;
