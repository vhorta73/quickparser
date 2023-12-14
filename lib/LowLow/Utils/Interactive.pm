package LowLow::Utils::Interactive;

=head1 NAME

LowLow::Utils::Insteractive - Provides static methods for interactive interactions.

=head1 SYNOPSIS

  use LowLow::Utils::Interactive qw{
    prompt
  };

  if ( prompt( ..

=head1 DESCRIPTION

Supplies static methods for interactive interactions.

=cut

use Modern::Perl;

use Exporter 'import';

our @EXPORT_OK = (qw{
  prompt
});


=head2 prompt

Given a C<String> for the question to promtp and the C<ArrayRef> for
all the possible and acceptable answers, returns one of the elements
of the possible answers, or undef if the answer did not meet the 
criteria.

  my $selected_answer_or_undef = promt( C<String>, [ C<String>, C<String>, ..] );

return C<String> or undef

=cut

sub prompt {
  my ( $question, $answers ) = @_;

  print "$question [" . join( "|", @$answers ) . "] : ";

  my $answer = _getInput();

  foreach my $possible_answer ( @$answers ) {
    next unless $possible_answer eq $answer;
    return $answer;
  }

  return;
}

=head2 _getInput

PRIVATE

Reads a line from terminal.

  my $line = _getInput();

return C<String>

=cut

sub _getInput { my $answer = <STDIN>; chomp( $answer ); return $answer }

1;
__END__
