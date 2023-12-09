use Modern::Perl;
use Data::Dumper;
use File::Find qw{ finddepth };
use Const::Fast;

use LowLow::Parser::Line;

const my $COLUMNS => [
  { date   => qr/\[([^,]+)/,                       },
  { time   => qr/,\s*([^\]]+)\]/,                  },
  { name   => qr/\][^a-zA-Z0-9]*([^:]+):/,                      },
  { id     => qr/\][^0-9]+[^0-9]{0,1}([0-9]{2,}+)/, },
  { picker => qr/[0-9]{5,6}\s*([^ \[]+)/,          },
  { original => qr/(.*)/,                          },
];
  # my ( $date        ) = $line =~ m/\[([^,]+)/;
  # my ( $time        ) = $line =~ m/,\s*([^\]]+)\]/;
  # my ( $name        ) = $line =~ m/\]([^:]+):/;
  # my ( $id          ) = $line =~ m/\][^0-9]+\s+([^0-9]{0,1}[0-9]+)/;
  # my ( $picker      ) = $line =~ m/[0-9]{5,6}\s*([^ \[]+)/;
  # my ( $picker_time ) = $line =~ m/([0-9]{2}:[0-9]{2})[^:]*$/;

my @files;

finddepth(
  sub {
    return if ( $_ eq '.' || $_ eq '..' );
    my $file = $File::Find::name;
    next unless $file =~ ".txt";
    push @files, $File::Find::name;
  },
  '.',
);

my @lines;
foreach my $file ( @files ) {
  open( my $FH, $file );
  my @prev_lines;
  while ( my $line = <$FH> ) {
    chomp( $line );
    # if ( lineStart( $line ) ) {
    #   push @lines, join ('', @prev_lines ) if @prev_lines;
    #   @prev_lines = ();
    #   push @prev_lines, $line;
    # }
    # else {
      # push @prev_lines, $line;
    # }
    push @lines, $line;
  }
  push @lines, join( ' ', @prev_lines ) if @prev_lines;
  close $FH;
}
sub lineStart {
  my ( $line ) = @_;
  return $line =~ /^\[([^]]+)\]/ ? 1 : 0;
}


my $parse_line = LowLow::Parser::Line->new( columns => $COLUMNS );
open( my $OUT, ">", "lowlow.csv");
print $OUT join( "|", $parse_line->header ) . "\n";
foreach my $line ( @lines ) {
  my $parsed = $parse_line->toHash( $line );
  my $csv_line = $parse_line->toCSV( $parsed );
  print $OUT $csv_line . "\n";
}
close $OUT;


1;
__END__
