package LowLow::Processor::Role;

=head1 NAME

LowLow::Processor::Role - Role defining the requirements for processor classes.

=head1 SYNOPSIS

  package Foo {
    use Modern::Perl;
    use Moo;
    use namespace::clean;

    with 'LowLow::Processor::Role';

    sub process { ...

    1;
  };

=head1 DESCRIPTION

Defines the attributes required instantiation for processor roles.

=cut

use Modern::Perl;
use LowLow::Processor::DefaultStore;

use Moo::Role;
use namespace::clean;

requires qw{
  store
};

=head2 store

The L<LowLow::Process::Role::Storable> implementation.

  my $store = $self->store;

return L<LowLow::Processor::Role::Storable>

=cut

has store => ( is => 'ro', default => sub { return LowLow::Processor::DefaultStore->new() } );

1;
__END__
