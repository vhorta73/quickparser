#!/usr/bin/perl

use Modern::Perl;
use Test::More;

require_ok( 'LowLow::Parser::LineToHash' );


=head2 test_no_columns

Confirming no columns supplied produces no result but still
a C<HashRef> is returned.

=cut

sub test_no_columns {
  my $line_to_hash = LowLow::Parser::LineToHash->new(
    columns => []
  );

  my $result = $line_to_hash->getHashFromLine( "" );
  my %hash;

  is_deeply( \%hash, $result, "Test No Columns." );
}

test_no_columns();

=head2 test_one_column_match

Confirming when one column is matched, if the result produces
a C<HashRef> with the matched data.

=cut

sub test_one_column_match {
  my $line_to_hash = LowLow::Parser::LineToHash->new(
    columns => [
      { 'column_name' => qr/(this)/ },
    ],
  );

  my $result = $line_to_hash->getHashFromLine( "matching this string" );
  my %hash = ( 
    column_name => 'this',
  );

  is_deeply( \%hash, $result, "Test One Column Match." );
}

test_one_column_match();

=head2 test_one_column_no_match

Confirming when one column is given without a match, if the
result produces a C<HashRef> with no results.

=cut

sub test_one_column_no_match {
  my $line_to_hash = LowLow::Parser::LineToHash->new(
    columns => [
      { 'column_name' => qr/(this)/ },
    ],
  );

  my $result = $line_to_hash->getHashFromLine( "matching that string" );
  my %hash = ();

  is_deeply( \%hash, $result, "Test One Column No Match." );
}

test_one_column_no_match();

=head2 test_many_column_match

Confirming when many columns are matched, if the result produces
a C<HashRef> with the matched data.

=cut

sub test_many_column_match {
  my $line_to_hash = LowLow::Parser::LineToHash->new(
    columns => [
      { 'column_this' => qr/(this)/ },
      { 'column_that' => qr/(that)/ },
    ],
  );

  my $result = $line_to_hash->getHashFromLine( "matching this and also that string" );
  my %hash = ( 
    column_this => 'this',
    column_that => 'that',
  );

  is_deeply( \%hash, $result, "Test Many Column Match." );
}

test_many_column_match();

=head2 test_many_column_no_match

Confirming when many columns are given without a match, if the
result produces a C<HashRef> with no results.

=cut

sub test_many_column_no_match {
  my $line_to_hash = LowLow::Parser::LineToHash->new(
    columns => [
      { 'column_this' => qr/(this)/ },
      { 'column_that' => qr/(that)/ },
    ],
  );

  my $result = $line_to_hash->getHashFromLine( "matching those or the other string" );
  my %hash = ();

  is_deeply( \%hash, $result, "Test Many Column No Match." );
}

test_many_column_no_match();

=head2 test_mix_column_match

Confirming matching an not matching columns produce the correct
result.

=cut

sub test_mix_column_no_match {
  my $line_to_hash = LowLow::Parser::LineToHash->new(
    columns => [
      { 'column_this' => qr/(this)/ },
      { 'column_that' => qr/(that)/ },
    ],
  );

  my $result = $line_to_hash->getHashFromLine( "matching this string only" );
  my %hash = (
    column_this => 'this',
  );

  is_deeply( \%hash, $result, "Test Mix Column No Match." );
}

test_mix_column_no_match();

=head2 test_multiple_results

Confirming matching an not matching columns produce the correct
result.

=cut

sub test_multiple_results {
  my $line_to_hash = LowLow::Parser::LineToHash->new(
    columns => [
      { 'column_this' => [ qr/(this)/, qr/(this)/, ] },
      { 'column_that' => qr/(that)/ },
    ],
  );

  my $result = $line_to_hash->getHashFromLine( "matching this string and this string only" );
  my %hash = (
    column_this => [ 'this', 'this' ],
  );

  is_deeply( \%hash, $result, "Test Multiple Results." );
}

test_multiple_results();



done_testing();

__END__
