package LowLow::Parser::LineToHash;

=head1 NAME

LowLow::Parser::LineToHash - Converts a String line to Hash based on regex config.

=head1 SYNOPSIS

  # Single result per data point:

  my $line_to_hash = LowLow::Parser::LineToHash->new(
    columns => [
      { column_name => qr/some regex from line to match this field data/ },
      ...
    ],
  );

  # Multiple result per data point:

  my $line_to_hash = LowLow::Parser::LineToHash->new(
    columns => [
      { column_name => [ qr/some regex from line to match this field data/, qr/another/, .. ] },
      ...
    ],
  );

  my $hash_ref = $line_to_hash->getHashFromLine( "Some text line." );

=head1 DESCRIPTION

Converts a C<String> to C<HashRef>, based on a regex criteria defined for
each of the field names.

=cut

use Modern::Perl;
use Ref::Util qw{ is_arrayref };

use Moo;
use namespace::clean;

=head2 columns

The C<HashRef> of for the column names as keys and regex as values.

  my $columns = $self->columns();

return C<HashRef>

=cut

has columns => ( is => 'ro', required => 1 );

=head2 getHashFromLine

Given a C<String>, returns the C<HashRef> based on the regex criteria
initially supplied. If a regex finds no value, it is set undef.

  my $hash_ref = $self->getHashFromLine( C<String> );

return C<HashRef>

=cut

sub getHashFromLine {
  my ( $self, $line ) = @_;

  # A line must be supplied.
  return {} unless defined $line;

  # It must have at least one character.
  return {} unless length( $line );

  my %hash;
  foreach my $element ( @{ $self->columns } ) {
    while ( my ( $field, $regex ) = each %$element ) {
      my $regexes = is_arrayref( $regex ) ? $regex : [ $regex ];

      # No field and no regexes, is skipped.
      next unless $field and scalar @$regexes;

      my @results;
      foreach my $rx ( @$regexes ) {
        # No results are skipped.
        my ( $result ) = $line =~ $rx;

        next unless defined $result;

        push @results, $result;
      }
        
      # Data is saved when all criteria is met.
      if ( @results ) {
        $hash{ $field } = @results > 1 ? \@results : $results[0];
      }
    }
  }

  return \%hash;
}

1;
__END__
