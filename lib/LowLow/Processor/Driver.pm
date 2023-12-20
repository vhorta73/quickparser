package LowLow::Processor::Driver;

=head1 NAME

LowLow::Processor::Driver - Processes driver activities.

=head1 SYNOPSIS

=head1 DESCRIPTION

Executes driver activities.

=cut

use Modern::Perl;

use LowLow::Utils::Interactive qw{
  prompt
  promptComplex
};

use Moo;
use namespace::clean;


with (
  'LowLow::Processor::Role',
);

=head2 processDriver

Processing driver's data.

  $self->processDriver( C<HashRef> );

return L<LowLow::Moder::Driver> or undef

=cut

sub processDriver {
  my ( $self, $data ) = @_;

  # First things first...
  return unless $data->{name};
  my $name_raw = $data->{name};
  $name_raw =~ s/^\s*//g;
  $name_raw =~ s/\s*$//g;
  my $driver_name = $self->{_equivalent_drivers}->{ $name_raw } // $name_raw;

  # Nothing to do if already done..
  my $existing_driver = $self->store->read( $driver_name );
  if ( $existing_driver ) {
    $existing_driver->prepData( $data );
    return $existing_driver;
  };
  
  # If already marked as not a driver, nothing else to do.
  return if $self->{_not_drivers}->{ $driver_name };

  # We have a driver name that is not added and has not yet been
  # marked as not being one. Need to ask.
  my $answer;
  until ( 
    $answer = promptComplex( "Is [$driver_name] a driver ?", [
      { label => '[y]es',    regex => qr/^y$/i, },
      { label => '[n]o',     regex => qr/^n$/,  },
      { label => '[r]ename', regex => qr/^r$/i, },
      { label => '[l]ist',   regex => qr/^l$/,  },
      { label => '[q]uit',   regex => qr/^q$/i, },
    ] )
  ) { print "Please select a valid option\n" };

  # Ensure consistency.
  $answer = lc( $answer );

  exit( 0 ) if $answer eq 'q';

  # Easy one first.
  if ( $answer eq 'n' ) {
    $self->{_not_drivers}->{ $driver_name } = 1;
    return;
  }

  # It is a driver and we do not have it.
  if ( $answer eq 'y' ) {
    my $drivero = LowLow::Model::Driver->new( name => $driver_name );
    $drivero->prepData( $data );
    return $self->store->create( $driver_name, $drivero );
  }

  # Rename driver.
  if ( $answer eq 'r' ) {
    my $new_name = promptComplex( "Please enter new name:", [ { label => 'name', regex => qr/.*/, }, ] );

    $self->{_equivalent_drivers}->{ $driver_name } = $new_name;

    my $drivero = $self->store->read( $new_name )
      || $self->store->create( $new_name, LowLow::Model::Driver->new( $new_name ) );

    $drivero->prepData( $data );

    return $drivero;
  }
  
  return;
}

=head2 processDeliveries

Processes all driver's deliveries after being loaded.

  $self->processDeliveries();

returns nothing

=cut

sub processDeliveries {
  my ( $self ) = @_;

  foreach my $driver ( @{ $self->store->read('*') } ) {
    $driver->process();
  }

  return;
}

sub report {
  my ( $self ) = @_;
  die Data::Dumper::Dumper { self => $self };
}

1;
__END__
