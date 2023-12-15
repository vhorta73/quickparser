use strict;
use warnings;
use Module::Build;

use 5.032;

my $build = Module::Build->new( 
  module_name     => 'LowLow',
  license         => 'perl',
  dist_author     => 'Vasco Horta <vhorta73@github.com>',
  requires => {
    'Const::Fast'          => 0.014,
    'Modern::Perl'         => 1.2,
    'Moo'                  => 2.0,
    'Moo::Role'            => 2.0,
    'Ref::Util'            => 0.204,
    'namespace::clean'     => 0.27,
  },
  test_files      => [
    't/LowLow/Parser',
    't/LowLow/Model',
  ],
  build_requires => {
    'Test::Exception'      => 0.43,
    'Test::More'           => 0.47,
    'Test::Pod::Coverage'  => 1.10,
    'Test::MockModule'     => 0.177,
  }
);

$build->dispatch( 'build' );
$build->dispatch( 'test', verbose => 0 );
$build->dispatch( 'install' );

$build->create_build_script();

__END__
