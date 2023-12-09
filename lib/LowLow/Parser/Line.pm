package LowLow::Parser::Line;

=head1 NAME

LowLow::Parser::Line - Recognises the standard parsing of a line into the standard sturcture.

=head1 SYNOPSIS

  my $parser = LowLow::Parser::Line->new();
  my $parsed = $parser->toHash( "Some text line." );

=head1 DESCRIPTION

=cut

use Modern::Perl;

use Moo;
use namespace::clean;

has columns => ( is => 'ro', required => 1 );

has header => ( 
  is => 'ro',
  builder => sub {
    my ( $self ) = @_;

    my @headers;
    foreach my $element ( @{ $self->columns } ) {
      my ( $field, $regex ) = each %$element;
      push @headers, $field;
    }

    return join( "|", @headers );
  },
);

=head2 toHash

Given a C<String>, returns the ..

=cut

sub toHash {
  my ( $self, $line ) = @_;

  my %hash;
  foreach my $element ( @{ $self->columns } ) {
    my ( $field ) = keys %$element;
    my ( $regex ) = values %$element;
    ( $hash{ $field } ) = $line =~ $regex; 
  }

  return \%hash;
}

sub toCSV {
  my ( $self, $parsed ) = @_;

  my @data;
  foreach my $element ( @{ $self->columns } ) {
    my ( $key ) = keys %{ $element };
    push @data, $parsed->{ $key };
  }

  return join ( "|", @data );
}

1;
__END__
