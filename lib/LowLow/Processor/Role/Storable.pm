package LowLow::Processor::Role::Storable;

=head1 NAME

LowLow::Storable - Role defining methods for processor storing.

=head1 SYNOPSIS

  package Foo {
    use Modern::Perl;

    use moo;
    use namespace::clean;

    with 'LowLow::Processor::Role::Storable';

    1;
  }

=head1 DESCRIPTION

Interface defining the requirements for Processor to process.

=head2 create

Given a C<HashRef>, creates a record.

  $self->create( \%hash )l

return Nothing

=head2 read

Given a C<HashRef>, reads from store based on details given.

  $self->read( \%hash )l

return Nothing

=head2 update

Given a C<HashRef>, updates store with the details supplied.

  $self->update( \%hash )l

return Nothing

=head2 delete

Given a C<HashRef>, deletes store with the details supplied.

  $self->delete( \%hash )l

return Nothing

=cut

use Modern::Perl;

use Moo::Role;
use namespace::clean;

requires qw{
  create
  read
  update
  delete
};

1;
__END__
