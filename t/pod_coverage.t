#!/usr/bin/perl

use Modern::Perl;
use Test::More;
use Test::Pod::Coverage;

plan tests => scalar ( all_modules() );

foreach my $module_name ( all_modules() ) {
  pod_coverage_ok( 
    $module_name,
    $module_name . " is covered",
  );
}

__END__
