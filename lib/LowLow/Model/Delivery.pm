package LowLow::Delivery;

=head1 NAME

LowLow::Delivery - Role defining delivery methods.

=head1 SYNOPSIS

  package Foo {
    use Moo;
    with 'LowLow::Deliver';
    
    1;
  };

  my $foo = Foo->new();
  
  LowLow::Model::Delivery->new( 
    id       => L<LowLow::Model::Package>,
    expected => L<LowLow::Model::DateTime>,
    picker   => L<LowLow::Model::Picker>,
  );

  LowLow::Model::Delivery->new( 
    id           => L<LowLow::Model::Package>,
    expected     => L<LowLow::Model::DateTime>,
    picker       => L<LowLow::Model::Picker>,
    start_driver => L<LowLow::Model::Driver>,
    started      => L<LowLow::Model::DateTime>,
  );

  LowLow::Model::Delivery->new( 
    id            => L<LowLow::Model::Package>,
    expected      => L<LowLow::Model::DateTime>,
    picker        => L<LowLow::Model::Picker>,
    start_driver  => L<LowLow::Model::Driver>,
    started       => L<LowLow::Model::DateTime>,
    finished      => L<LowLow::Model::DateTime>,
    finish_driver => L<LowLow::Model::Driver>,
  );

=head1 DESCRIPTION

The delivery class knowing all about a specific package being delivered.

=cut

use Modern::Perl;

use Moo;
use namespace::clean;

=head2 id

The C<String> for the id of the package being delivered.

  my $id = $self->id();

return C<String>

=cut

has id => ( is => 'ro', required => 1 );

=head2 expected

The L<LowLow::Model::DateTime> for the package to be delivered.

  my $expected = $self->expected();

return L<LowLow::Model::DateTime>

=cut

has expected => ( is => 'ro', required => 1 );

=head2 picker

The L<LowLow::Model::Picker> for the designated source of the package
to be delivered.

  my $picker = $self->picker();

return L<LowLow::Model::Picker>

=cut

has picker => ( is => 'ro', required => 1 );


has start_driver  => ( is => 'ro', );
has finish_driver => ( is => 'ro', );
has started       => ( is => 'ro', );
has fiished       => ( is => 'ro', );

=head2 report

Produces a C<HashRef> with the details of the whole transation in the
following format: 

  my $hashref = $self->report();

  $hashref = {
    date    => C<String>,
    time    => C<String>,
    start_driver  => C<String>,
    finish_driver  => C<String>,
    id      => C<String>,
    picker  => C<String>,
    slot    => C<String>,
    status  => C<String>,
  };

return C<HashRef>

=cut

sub report {
  my ( $self ) = @_;

  return {
    date => $self->
  }
}

1;
__END__
