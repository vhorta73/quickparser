#!/usr/bin/perl

use Modern::Perl;
use Test::More;

require_ok( 'LowLow::Model::DateTime' );


=head2 test_date_time_1

Confirming C<String> with date time parses correctly.

=cut

sub test_date_time_1 {
  my $date_time = LowLow::Model::DateTime->new( "2023-12-15 10:00:00" );

  is_deeply( '2023-12-15', $date_time->date, "Test Date matches." );
  is_deeply( '10:00:00', $date_time->time, "Test Time matches." );
  is_deeply( '2023-12-15 10:00:00', $date_time->date_time, "Test Date and Time matches." );
}

test_date_time_1();

=head2 test_date_time_2

Confirming C<String> with date time parses correctly.

=cut

sub test_date_time_2 {
  my $date_time = LowLow::Model::DateTime->new( "20231215 10:00:00" );

  is_deeply( '20231215', $date_time->date, "Test Date matches." );
  is_deeply( '10:00:00', $date_time->time, "Test Time matches." );
  is_deeply( '20231215 10:00:00', $date_time->date_time, "Test Date and Time matches." );
}

test_date_time_2();

=head2 test_date_time_3

Confirming C<String> with date time parses correctly.

=cut

sub test_date_time_3 {
  my $date_time = LowLow::Model::DateTime->new( "15/12/23 10:00:00" );

  is_deeply( '15/12/23', $date_time->date, "Test Date matches." );
  is_deeply( '10:00:00', $date_time->time, "Test Time matches." );
  is_deeply( '15/12/23 10:00:00', $date_time->date_time, "Test Date and Time matches." );
}

test_date_time_3();

=head2 test_date_time_4

Confirming C<String> with date time parses correctly.

=cut

sub test_date_time_4 {
  my $date_time = LowLow::Model::DateTime->new( "12/30/23 10:00:00" );

  is_deeply( '12/30/23', $date_time->date, "Test Date matches." );
  is_deeply( '10:00:00', $date_time->time, "Test Time matches." );
  is_deeply( '12/30/23 10:00:00', $date_time->date_time, "Test Date and Time matches." );
}

test_date_time_4();



done_testing();

__END__
