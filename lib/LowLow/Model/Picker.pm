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

return C<String> or undef

=cut

has name => ( is => 'ro', required => 0 );

1;
__END__
