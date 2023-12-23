package LowLow::Processor;

=head1 NAME

LowLow::Processor - Processor factory class.

=head1 SYNOPSIS

  my $processor = LowLow::Processor->new();

  $processor->processWhatsappLines( \@lines );

=head1 DESCRIPTION

TBD

=cut

use Modern::Perl;
use Const::Fast;
use Module::Load;
use Ref::Util qw{ is_blessed_ref };

use LowLow::Parser::LineToHash;
use LowLow::Processor::DefaultStore;
use LowLow::Processor::Driver;

use Moo;
use namespace::clean;


my $COLUMNS = [
  { 
    date     => qr/\[([^,]+)/,
    cleanup  => sub {
      my ( $date ) = @_;
      my ( $day, $month, $year ) = split ( '/', $date );
      return sprintf("%04d%02d%02d", "20$year", $month, $day );
    },
  },
  { 
    time     => qr/,\s*([^\]]+)\]/,
  },
  {
    name     => qr/\][^a-zA-Z]+([^:]+)/,
    cleanup  => sub {
      my ( $name ) = @_;
      return join ( ' ', map { ucfirst } split( ' ', $name ) );
    },
  },
  { 
    id          => qr/\][^0-9]+([0-9]{2,}+)\s*[^0-9]+/,
  },
  { 
    picker      => qr/[0-9]+\s+([a-zA-Z]+)\s+[0-9]{2}:[0-9]{2}$/,
  },
  { 
    slot        => [
      qr/[0-9]+\s+[a-zA-Z]+\s+([0-9]{2}:{1,}[0-9]{2})$/,
      qr/[^:0-9]+([0-9]{2}:[0-9]{2})[^:0-9]+/,
    ],
  },
  { 
    in_delivery => [ qr/[0-9]+\s+[a-zA-Z]+\s+[0-9]{2}:{1,}[0-9]{2}$/, ],
  },
  { 
    delivered   => [ qr/[0-9]+\s+[a-zA-Z]+$/, qr/[0-9]+\s+[a-zA-Z]+\s+[a-zA-Z]{2}$/ ],
  },
  { 
    hour        => qr/\b([0-9]{2}:[0-9]{2})\b[^0-9]+$/,
  },
  { 
    original    => qr/(.*)/,
  },
];


=head2 driver_processor

The L<LowLow::Processor::Driver> instantiation.

  my $driver_processor = $self->driver_processor;

return L<LowLow::Processor::Driver>

=cut

has driver_processor => ( 
  is       => 'ro',
  init_arg => undef,
  default  => sub { return LowLow::Processor::Driver->new() },
);

=head2 processWhatsappLines

Given a C<ArrayRef> of C<String> lines from whatsapp,
process these onto data structures for further processing.

  $self->processWhatsappLines( [ C<String>,.. ] );

return Nothing

=cut

sub processWhatsappLines {
  my ( $self, $lines ) = @_;

  my $line_to_hash = LowLow::Parser::LineToHash->new( columns => $COLUMNS );

  $self->driver_processor->processDriver( 
    $line_to_hash->getHashFromLine( $_ )
  ) for grep { $_ =~ m/Claudio/ } @$lines;

  $self->driver_processor->processDeliveries();

  return;
}

1;
__END__
