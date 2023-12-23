package LowLow::Model::Driver;

=head1 NAME

LowLow::Model::Driver - Class defining the driver delivering picked package.

=head1 SYNOPSIS

  LowLow::Model::Driver->new( 'Claudio' );

=head1 DESCRIPTION

Defines a driver.

=cut

use Modern::Perl;

use LowLow::Model::DateTime;
use LowLow::Model::Package;
use LowLow::Model::Picker;
use LowLow::Model::Employee::DayShift;

use LowLow::Utils::Interactive qw{ promptComplex };

use Moo;
use namespace::clean;

=head2 name

The C<String> name of the driver.

  my $name = $self->name();

return C<String>

=cut

has name => ( is => 'ro', required => 1 );

=head2 startShift

Given a L<LowLow::Model::DateTime>, sets the start of the shift
for this driver at the given date.

  $self->startShift( L<LowLow::Model::DateTime> );

return Nothing

=cut

sub startShift {
  my ( $self, $datetime ) = @_;

  my $date = $datetime->date;
  my $time = $datetime->time;

  my $day_shift = $self->{_day_shift}->{ $date } //= LowLow::Model::Employee::DayShift->new();

  $day_shift->startShiftAt( $datetime );

  return;
}

=head2 startShift

Given a L<LowLow::Model::DateTime>, sets the start of the break
for this driver at the given date.

  $self->startBreak( L<LowLow::Model::DateTime> );

return Nothing

=cut

sub startBreak {
  my ( $self, $datetime ) = @_;

  my $date = $datetime->date;
  my $time = $datetime->time;

  my $day_shift = $self->{_day_shift}->{ $date } //= LowLow::Model::Employee::DayShift->new();

  $day_shift->startBreakAt( $datetime );

  return;
}

=head2 endBreak

Given a L<LowLow::Model::DateTime>, sets the end of the break
for this driver at the given date.

  $self->endBreak( L<LowLow::Model::DateTime> );

return Nothing

=cut

sub endBreak {
  my ( $self, $datetime ) = @_;

  my $date = $datetime->date;
  my $time = $datetime->time;

  my $day_shift = $self->{_day_shift}->{ $date } //= LowLow::Model::Employee::DayShift->new();

  $day_shift->endBreakAt( $datetime );

  return;
}

=head2 endShift

Given a L<LowLow::Model::DateTime>, sets the end of the shift
for this driver at the given date.

  $self->endShift( L<LowLow::Model::DateTime> );

return Nothing

=cut

sub endShift {
  my ( $self, $datetime ) = @_;

  my $date = $datetime->date;
  my $time = $datetime->time;

  my $day_shift = $self->{_day_shift}->{ $date } //= LowLow::Model::Employee::DayShift->new();

  $day_shift->endShiftAt( $datetime );

  return;
}

=head2 prepData

Given a C<HashRef>, preapes it for calculation.

  $self->prepData( L<HashRef> );

return Nothing

=cut

sub prepData {
  my ( $self, $data ) = @_;

  push @{ $self->{_raw_data}->{ $data->{date} } }, $data;

  return;
}

=head2 process

Processes all deliveries loaded.

  $self->process();

return nothing

=cut

sub process {
  my ( $self ) = @_;

  foreach my $date ( sort { $a cmp $b } keys %{ $self->{_raw_data} } ) {
    my @deliveries_for_date = 
      sort { $a->{time} cmp $b->{time} } 
        @{ $self->{_raw_data}->{ $date } };

    foreach my $data ( @deliveries_for_date ) { 
      my $original_line = $data->{original};
      next unless $data->{date} =~ m/20231201/;

      my $datetime = LowLow::Model::DateTime->new( "$data->{date} $data->{time}" );

      $self->startShift( $datetime ) if $original_line =~ m/cio\s+do\s+turno\b/i;
      $self->endBreak(   $datetime ) if $original_line =~ m/\bfim\b.*\bturno\b/i;
      $self->startBreak( $datetime ) if $original_line =~ m/\bintervalo\b/i;

      next unless $data->{id};

      my $package  = $self->getPackage( $data->{id} );
      $package->estimatedAt( $data->{slot} ) if $data->{slot};
      $package->pickedAt(    $datetime     ) if $data->{in_delivery} || $data->{slot};
      $package->deliveredAt( $datetime     ) if $data->{delivered};
      $package->setPicker( LowLow::Model::Picker->new( name => $data->{picker} ) ) if $data->{picker};
    }
  }

  $self->{_raw_data} = undef;

  return;
}

=head2 getPackage

Given a C<String> for a package id, returns the L<LowLow::Model::Package> if
already instantiated in cache or a new instantiation with the supplied id. 
Dies when no id supplied.

  my $package = $self->getPackage( C<String> );

return L<LowLow::Moder::Package>

=cut

sub getPackage {
  my ( $self, $id ) = @_;

  die "No id supplied" unless $id;

  return $self->{_packages}->{ $id } //= LowLow::Model::Package->new( id => $id );
}

1;
__END__
