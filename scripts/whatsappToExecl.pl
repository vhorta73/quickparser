#!/usr/bin/perl

use Modern::Perl;
use Data::Dumper;
use File::Find qw{ finddepth };
use Const::Fast;

use LowLow::Parser::LineToHash;
use LowLow::Utils::Interactive qw{ prompt };

const my $COLUMNS => [
  { date   => qr/\[([^,]+)/,                          },
  { time   => qr/,\s*([^\]]+)\]/,                     },
  { name   => qr/\][^a-zA-Z0-9]*([^:]+):/,            },
  { id     => qr/\][^0-9]+[^0-9]{0,1}([0-9]{2,}+)/,   },
  { picker => qr/[0-9]{5,6}\s*([^ \[]+)/,             },
  { original => qr/(.*)/,                             },
];

# If a file is given, take that.
my $filename = $ARGV[0];
unless ( $filename ) {
  print "Please supply the file name to parse..\n";
  exit( 0 );
};

my @files_found;
finddepth(
  sub {
    return if ( $_ eq '.' || $_ eq '..' );
    my $file = $File::Find::name;
    return unless $file =~ qr/$filename/;
    push @files_found, $File::Find::name;
  },
  '.',
);

unless ( @files_found ) {
  print "No files found to process. Please drop files .txt in this folder and try again...\n";
  exit( 0 );
};

my @files_to_process;
foreach my $file ( @files_found ) {
  my $selected_action = prompt( "Process file $file?", [qw{y n q}] );

  while ( not $selected_action ) {
    $selected_action = prompt( "Invalid answer, please select one from these:", [qw{y n q}] );
  };

  next if $selected_action eq 'n';
  print "Exiting application...\n" and exit( 0 )
    if $selected_action eq 'q';

  push @files_to_process, $file;
}

# TODO : look this differently
my @lines;
foreach my $file ( @files_to_process ) {
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


use Excel::Writer::XLSX;
 
# Create a new Excel workbook
my $workbook = Excel::Writer::XLSX->new( 'perl.xlsx' );
 
# Add a worksheet
my $worksheet = $workbook->add_worksheet();
 
#  Add and define a format
my $format = $workbook->add_format();
$format->set_bold();
$format->set_color( 'red' );
$format->set_align( 'center' );
 
# Write a formatted and unformatted string, row and column notation.
my $col = 0;
my $row = 0;
$worksheet->write( $row, $col, 'Hi Excel!', $format );
$worksheet->write( 1, $col, 'Hi Excel!' );
 
# Write a number and a formula using A1 notation
$worksheet->write( 'A3', 1.2345 );
$worksheet->write( 'A4', '=SIN(PI()/4)' );
 
$workbook->close();

exit(0);

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
