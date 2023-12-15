package LowLow::Model::Picker;

=head1 NAME

LowLow::Model::Picker - Class defining a picker source of packages to delivery.

=head1 SYNOPSIS

  LowLow::Model::Picker->new( 'Fernando' );

=head1 DESCRIPTION

Defines a picker.

=cut

use Modern::Perl;

use Moo;
use namespace::clean;

=head2 name

The C<String> name of the picker.

  my $name = $self->name();

return C<String>

=cut

has name => ( is => 'ro', required => 1 );

=head2 BUILDARGS

  LowLow::Model::Piker->new( "Picker Name" );

  LowLow::Moder::Picker->new( name => "Picker Name" );

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
