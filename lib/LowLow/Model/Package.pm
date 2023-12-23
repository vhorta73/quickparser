package LowLow::Model::Package;

=head1 NAME

LowLow::Model::Package - Class defining a package to deliver.

=head1 SYNOPSIS

  LowLow::Model::Package->new( id => '61430' );

=head1 DESCRIPTION

Defines a package.

=cut

use Modern::Perl;

use Moo;
use namespace::clean;


=head2 id

The C<String> id of the pakage.

  my $id = $self->id();

return C<String>

=cut

has id => ( is => 'ro', required => 1 );

=head2 slot

The C<String> for the delivery estimated time slot.

  my $slot = $self->slot();

return C<String> or undef

=cut

has slot => ( is => 'rwp', required => 0 ); 

=head2 picked

The C<LowLow::Model::DateTime> for the picked time.

  my $picked = $self->picked();

return L<LowLow::Model::DateTime> or undef

=cut

has picked => ( is => 'rwp', required => 0 ); 

=head2 picker

The C<LowLow::Model::Picker>.

  my $picker = $self->picker();

return L<LowLow::Model::Picker> or undef

=cut

has picker => ( is => 'rwp', required => 0 ); 

=head2 delivered

The L<LowLow::Model::DateTime> for the delived time.

  my $delivered = $self->delivered();

return C<LowLow::Model::DateTime> or undef

=cut

has delivered => ( is => 'rwp', required => 0 ); 

=head2 estimatedAt

Given a C<String> for time, sets this as the slot.

  $self->estimatedAt( C<String> );

return Nothing

=cut

sub estimatedAt {
  my ( $self, $time ) = @_;

  $self->_set_slot( $time );

  return;
}

=head2 pickedAt

Given a C<LowLow::Model::DateTime>, sets this as picked
unless picked is already set.

  $self->pickedAt( C<LowLow::Model::DateTime> );

return Nothing

=cut

sub pickedAt {
  my ( $self, $datetime ) = @_;

  return if $self->picked;

  $self->_set_picked( $datetime );

  return;
}

=head2 setPicker

Given a C<LowLow::Model::Picker>, sets this as picker
unless picker is already set.

  $self->setPicker( C<LowLow::Model::Picker> );

return Nothing

=cut

sub setPicker {
  my ( $self, $picker ) = @_;

  return if $self->picker;

  $self->_set_picker( $picker );

  return;
}

=head2 deliveredAt

Given a C<LowLow::Model::DateTime>, sets this as delivered
date time.

  $self->deliveredAt( C<LowLow::Model::DateTime> );

return Nothing

=cut

sub deliveredAt {
  my ( $self, $datetime ) = @_;

  $self->_set_delivered( $datetime );

  return;
}


1;
__END__
