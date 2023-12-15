package LowLow::Model::Package;

=head1 NAME

LowLow::Model::Package - Class defining a package to deliver.

=head1 SYNOPSIS

  LowLow::Model::Package->new( '61430' );

=head1 DESCRIPTION

Defines a package.

=cut

use Modern::Perl;

use Moo;
use namespace::clean;

=head2 id

The C<String> id of the pakager.

  my $id = $self->id();

return C<String>

=cut

has id => ( is => 'ro', required => 1 );

=head2 BUILDARGS

  LowLow::Model::Package->new( "61430" );

  LowLow::Moder::Picker->new( id => "61430" );

=cut

sub BUILDARGS {
  my ( $class, @args ) = @_;

  if ( @args == 1 ) {
    return { id => $args[0] };
  }
  else {
    return { @args };
  }
}

1;
__END__
