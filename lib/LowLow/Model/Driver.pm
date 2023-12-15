package LowLow::Model::Driver;

=head1 NAME

LowLow::Model::Driver - Class defining the driver delivering picked package.

=head1 SYNOPSIS

  LowLow::Model::Driver->new( 'Claudio' );

=head1 DESCRIPTION

Defines a driver.

=cut

use Modern::Perl;

use Moo;
use namespace::clean;

=head2 name

The C<String> name of the driver.

  my $name = $self->name();

return C<String>

=cut

has name => ( is => 'ro', required => 1 );

=head2 BUILDARGS

  LowLow::Model::Driver->new( "Driver Name" );

  LowLow::Moder::Driver->new( name => "Driver Name" );

=cut

sub BUILDARGS {
  my ( $class, @args ) = @_;

  if ( @args == 1 ) {
    return { name => $args[0] };
  }
  else {
    return { @args };
  }
}


1;
__END__
