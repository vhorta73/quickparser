package LowLow::Processor::DefaultStore;

=head1 NAME

LowLow::Processor::DefaultStore - Processes default styore for processing.

=head1 SYNOPSIS

  my $default_store = LowLow::Processor::DefaultStore->new();

=head1 DESCRIPTION

The Default Store class for procssor logic.

=cut

use Modern::Perl;
use Data::Dumper;

use Moo;
use namespace::clean;

with 'LowLow::Processor::Role::Storable';

has _store => ( is => 'ro', default => sub { { } } );

sub create {
  my ( $self, $key, $data ) = @_;
  die "No key supplied." unless $key;
  return $self->_store->{ $key } = $data;
}
sub read {
  my ( $self, $key ) = @_;

  if ( $key eq '*' ) {
    return [ values %{ $self->_store } ];
  }
  return $self->_store->{ $key };
}
sub update {
  my ( $self, $key, $data ) = @_;
  return $self->_store->{ $key } = $data;
}
sub delete {
  my ( $self, $key ) = @_;
  return delete $self->_store->{ $key };
}


1;
__END__
