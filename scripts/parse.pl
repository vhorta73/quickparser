#!/usr/bin/perl

use Modern::Perl;
use Data::Dumper;
use File::Find qw{ finddepth };
use Const::Fast;

use LowLow::Parser::LineToHash;
use LowLow::Utils::Interactive qw{ yes };

const my $COLUMNS => [
  { date   => qr/\[([^,]+)/,                          },
  { time   => qr/,\s*([^\]]+)\]/,                     },
  { name   => qr/\][^a-zA-Z0-9]*([^:]+):/,            },
  { id     => qr/\][^0-9]+[^0-9]{0,1}([0-9]{2,}+)/,   },
  { picker => qr/[0-9]{5,6}\s*([^ \[]+)/,             },
  { original => qr/(.*)/,                             },
];

my @files;

finddepth(
  sub {
    return if ( $_ eq '.' || $_ eq '..' );
    my $file = $File::Find::name;
    return if $file =~ m/\.pl$/;
    push @files, $File::Find::name;
  },
  '.',
);

unless ( @files ) {
  print "No files found to process. Please drop files .txt in this folder and try again...\n";
  exit( 0 );
};

print "Found these files to process: \n";
foreach my $file ( @files ) {
  print $file . "\n";
}
if ( yes( "Proceed?" ) ) {

}
else {
  print "Exiting...\n\n";
  exit( 0 );
}
exit ( 0 );
foreach my $file ( @files ) {

}

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


my $line_to_hash = LowLow::Parser::LineToHash->new( columns => $COLUMNS );
# open( my $OUT, ">", "lowlow.csv");
# print $OUT join( "|", $parse_line->header ) . "\n";
foreach my $line ( @lines ) {
  my $hash = $line_to_hash->getHashFromLine( $line );
  use Data::Dumper;
  die Data::Dumper::Dumper { hash => $hash };
#   my $parsed = $parse_line->toHash( $line );
#   my $csv_line = $parse_line->toCSV( $parsed );
#   print $OUT $csv_line . "\n";
}
# close $OUT;


1;
__END__
