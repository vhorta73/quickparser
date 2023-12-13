package LowLow::Utils::Interactive;

=head1 NAME

LowLow::Utils::Insteractive - Provides static methods for interactive interactions.

=head1 SYNOPSIS

  use LowLow::Utils::Interactive qw{
    yesno
  };

  if ( yesno("Proceed?") ) { ..

=head1 DESCRIPTION

Supplies multiple static methods for interactive interactions.

=cut

use Modern::Perl;
use Const::Fast;

use Exporter 'import';

$|=1;

our @EXPORT_OK = (qw{
  yes
});

sub yes {
  my ( $question ) = @_;

  $question //= "";
  print "$question [Y/N] : ";
  my $answer = <STDIN>;
  chomp $answer;

  unless ( $answer && $answer =~ m{^(?:y|yes|n|no)$}i ) {
    print "Not a valid answer. Please supply Y/N: ";
    return yes( $answer );
  };

  return 1 if $answer =~ m{^(?:y|yes)$}i;

  return 0;
}
1;
__END__
