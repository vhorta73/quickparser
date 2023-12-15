package LowLow::Model::DateTime;

=head1 NAME

LowLow::Model::DateTime - Date Time class.

=head1 SYNOPSIS

  my $datetime = LowLow::Model::DateTime->new( C<String> );

  my $date = $datetime->date;
  my $time = $datetime->time;
  my $date_and_time = $datetime->dateDime();

=head1 DESCRIPTION

Validates date and time at instantiation and provides access to both or
either parts of date time.

=cut

use Modern::Perl;

use Moo;
use namespace::clean;

=head2 date

The C<String> for the C<YYYYMMDD>.

  my $date = $self->date();

return C<String>

=cut

has date => ( is => 'ro', required => 1 );

=head2 time

The C<String> for the C<HH:SS>.

  my $time = $self->time();

return C<String>

=cut

has time => ( is => 'ro', required => 1 );

=head2 date_time

The C<String> for the C<YYYY/MM/DD HH:SS>.

  my $date_time = $self->date_time();

return C<String>

=cut

has date_time => ( is => 'ro', required => 1 );

=head2 BUILDARGS

  LowLow::Model::DateTime->new( "01/12/2023 10:09:13" );

=cut

sub BUILDARGS {
  my ( $class, $datetime ) = @_;

  my ( $date, $time ) = $datetime =~ m{^
      (         # Date capture
        [0-9]+  # One more more numbers
        [^0-9]? # Optional non-digit character
        [0-9]+  # One more more numbers
        [^0-9]? # Optional non-digit character
        [0-9]+  # One more more numbers
      )
      \s+       # At least ome space
      (
        [0-9]{2} # Precisely two digits 
        : 
        [0-9]{2} # Precisely two digits 
        :
        [0-9]{2} # Precisely two digits 
      )
    $}x;

  return {
    date => $date,
    time => $time,
    date_time => "$date $time",
  };
}
1;
__END__
