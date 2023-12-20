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

sub startShift {
  my ( $self, $data, $datetime ) = @_;

  my $date = $datetime->date;
  my $time = $datetime->time;

  my $day_shift = $self->{_day_shift}->{ $date } //= LowLow::Model::Employee::DayShift->new();
  $self->{_day_shift}->{ $date }= $day_shift->startShiftAt( $datetime );

  return;
}

sub startBreak {
  my ( $self, $data, $datetime ) = @_;

  my $date = $datetime->date;
  my $time = $datetime->time;

  my $day_shift = $self->{_day_shift}->{ $date } //= LowLow::Model::Employee::DayShift->new();
  $self->{_day_shift}->{ $date } = $day_shift->startBreakAt( $datetime );

  return;
}

sub endBreak {
  my ( $self, $data, $datetime ) = @_;

  my $date = $datetime->date;
  my $time = $datetime->time;

  my $day_shift = $self->{_day_shift}->{ $date } //= LowLow::Model::Employee::DayShift->new();
  $self->{_day_shift}->{ $date } = $day_shift->endBreakAt( $datetime );

  return;
}

sub endShift {
  my ( $self, $data, $datetime ) = @_;

  my $date = $datetime->date;
  my $time = $datetime->time;

  my $day_shift = $self->{_day_shift}->{ $date } //= LowLow::Model::Employee::DayShift->new();
  $self->{_day_shift}->{ $date } = $day_shift->endShiftAt( $datetime );

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
      next unless $data->{id};

      my $datetime = LowLow::Model::DateTime->new( "$data->{date} $data->{time}" );
      my $picker   = LowLow::Model::Picker->new( name => $data->{picker} );
      my $package  = $self->getPackage( $data->{id} );

      $self->updatePackage( $package->estimatedAt( $data->{slot} ) ) if $data->{slot};
      $self->updatePackage( $package->pickedAt( $datetime ) )        if $data->{in_delivery};
      $self->updatePackage( $package->deliveredAt( $datetime ) )     if $data->{delivered};

  print $data->{original} . "\n";  
      if ( $original_line =~ m/cio\s+do\s+turno\b/i ) {
        $self->startShift( $data, $datetime );
      }
  
      if ( $original_line =~ m/\bfim\b.*\bturno\b/i  ) {
        $self->endBreak( $data, $datetime );
      }
  
      if ( $original_line =~ m/\bintervalo\b/i ) {
        $self->startBreak( $data, $datetime );
      }
    }
  }

  $self->{_raw_data} = undef;
  # die Data::Dumper::Dumper { a => $self };

  return;
}

sub getPackage {
  my ( $self, $id ) = @_;
  return $self->{_packages}->{ $id } //= LowLow::Model::Package->new( id => $id );
}
sub updatePackage {
  my ( $self, $package ) = @_;
  return $self->{_packages}->{ $package->id } = $package;
}

1;
__END__
