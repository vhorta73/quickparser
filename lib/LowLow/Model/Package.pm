package LowLow::Model::Package;

=head1 NAME

LowLow::Model::Package - Class defining a package to deliver.

=head1 SYNOPSIS

  LowLow::Model::Package->new(
    id => '61430',
    slot => '12:00',
  );

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

has slot => ( is => 'ro', required => 0 ); 

=head2 picked

The C<LowLow::Model::DateTime> for the picked time.

  my $picked = $self->picked();

return L<LowLow::Model::DateTime> or undef

=cut

has picked => ( is => 'ro', required => 0 ); 

=head2 delivered

The L<LowLow::Model::DateTime> for the delived time.

  my $delivered = $self->delivered();

return C<LowLow::Model::DateTime> or undef

=cut

has delivered => ( is => 'ro', required => 0 ); 

sub estimatedAt {
  my ( $self, $time ) = @_;
  return LowLow::Model::Package->new(
    slot => $time,
    id => $self->id,
    picked => $self->picked,
    delivered => $self->delivered,
  );
}
sub pickedAt {
  my ( $self, $datetime ) = @_;
  return LowLow::Model::Package->new(
    slot => $self->slot,
    id => $self->id,
    picked => $datetime,
    delivered => $self->delivered,
  );
}
sub deliveredAt {
  my ( $self, $datetime ) = @_;
  return LowLow::Model::Package->new(
    slot => $self->slot,
    id => $self->id,
    picked => $self->picked,,
    delivered => $datetime,
  );
}
1;
__END__
