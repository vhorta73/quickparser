#!/usr/bin/perl

use Modern::Perl;
use Data::Dumper;
use File::Find qw{ finddepth };
use Const::Fast;

use LowLow::Parser::LineToHash;
use LowLow::Utils::Interactive qw{ prompt };
use LowLow::Processor;
use LowLow::Model::Driver;



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
    if ( $line =~ m/^\[/ ) {
      # New line, add previously completed line up and clear.
      push @lines, join ( ' ', @prev_lines ) 
        if @prev_lines;

      @prev_lines = ();
      push @prev_lines, $line;
    }
    else {
      # Not the start of a new one, add it to the sequence.
      $line =~ s/[\n\r]+//g;
      push @prev_lines, $line;
    }
  }
  push @lines, join ( ' ', @prev_lines ) 
    if @prev_lines;
  close $FH;
}

# my $line_to_hash     = LowLow::Parser::LineToHash->new( columns => $COLUMNS );
my $processor = LowLow::Processor->new();
$processor->processWhatsappLines( \@lines );

# die Data::Dumper::Dumper { p => $processor };

# my $line_to_hash = LowLow::Parser::LineToHash->new( columns => $COLUMNS );
# foreach my $line ( @lines ) {
#   my $hash = $line_to_hash->getHashFromLine( $line );
  
#   use Data::Dumper;
#   die Data::Dumper::Dumper { hash => $hash };
# }

# use Excel::Writer::XLSX;
 
# Create a new Excel workbook
# my $workbook = Excel::Writer::XLSX->new( 'perl.xlsx' );
 
# Add a worksheet
# my $worksheet = $workbook->add_worksheet();
 
#  Add and define a format
# my $bold_format = $workbook->add_format();
# $bold_format->set_bold();
# $bold_format->set_align( 'left' );
# my $format = $workbook->add_format();
# $format->set_align( 'left' );
# my @test = (qw{
#   date
#   time
#   name
#   id
#   picker
#   slot
#   estado
#   hour
#   original
# });
# my $row = 0;
# $worksheet->write( $row, 0, 'Data', $bold_format );
# $worksheet->write( $row, 1, 'Hora', $bold_format );
# $worksheet->write( $row, 2, 'Driver', $bold_format );
# $worksheet->write( $row, 3, 'ID', $bold_format );
# $worksheet->write( $row, 4, 'Picker', $bold_format );
# $worksheet->write( $row, 5, 'Slot', $bold_format );
# $worksheet->write( $row, 6, 'Estado', $bold_format );
# $worksheet->write( $row, 7, 'Horario', $bold_format );
# $worksheet->write( $row, 8, 'Inicio Turno', $bold_format );
# $worksheet->write( $row, 9, 'Inicio Pausa', $bold_format );
# $worksheet->write( $row, 10, 'Fim Pausa', $bold_format );
# $worksheet->write( $row, 11, 'Fim Turno', $bold_format );
# $worksheet->write( $row, 12, 'Horas Trab', $bold_format );
# $worksheet->write( $row, 13, 'Loja', $bold_format );

# # my $driver = LowLow::Model::Driver->new( "Vasco" );
# # my $driver_processor = LowLow::Processor->newProcessor( $driver );
# #   $driver_processor->process( %$hash );

#   next unless $hash->{date};
#   next unless $hash->{name};
#   next if $hash->{name} =~ m/[0-9]+/;
#   next unless $hash->{id};
#   my $col = 0;
#   $row++;
#   foreach my $t ( @test ) {
#     $worksheet->write( $row, $col++, $hash->{ $t }, $format );
#   }

# # Write a number and a formula using A1 notation
# $worksheet->write( 'A3', 1.2345 );
# $worksheet->write( 'A4', '=SIN(PI()/4)' );
 
# $workbook->close();

exit(0);









1;
__END__
