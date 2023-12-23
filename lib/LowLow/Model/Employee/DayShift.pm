package LowLow::Model::Employee::DayShift;

=head1 NAME

LowLow::Model::Employee::DayShift - Class defining an employee's shift.

=head1 SYNOPSIS

  my $day_shoft = LowLow::Model::Employee::DayShift->new();

  $day_shift->startShift( L<LowLow::Model::DateTime> );
  $day_shift->startBreak( L<LowLow::Model::DateTime> );
  $day_shift->endBreak( L<LowLow::Model::DateTime> );
  $day_shift->endShift( L<LowLow::Model::DateTime> );

=head1 DESCRIPTION

An employee's day shift.

=cut

use Modern::Perl;

use Moo;
use namespace::clean;

=head2 start_shift

The L<LowLow::Model::DateTime> for the start of the shift.

  my $start = $self->start_shift();

return L<LowLow::Moder::DateTime>

=cut

has start_shift => ( is => 'rwp', required => 0 );

=head2 start_break

The L<LowLow::Model::DateTime> for the start of the break.

  my $start = $self->start_break();

return L<LowLow::Moder::DateTime>

=cut

has start_break => ( is => 'rwp', required => 0 );

=head2 end_break

The L<LowLow::Model::DateTime> for the end of the break.

  my $end = $self->end_break();

return L<LowLow::Moder::DateTime>

=cut

has end_break => ( is => 'rwp', required => 0 );

=head2 end_shift

The L<LowLow::Model::DateTime> for the end of the shift.

  my $end = $self->end_shift();

return L<LowLow::Moder::DateTime>

=cut

has end_shift => ( is => 'rwp', required => 0 );


=head2 startShiftAt

Givan a L<LowLow::Model::DateTime>, updates the shift time.

  $self->startShiftAt( L<LowLow::Model::DateTime> );

return Nothing

=cut

sub startShiftAt {
  my ( $self, $datetime ) = @_;

  return if $self->start_shift;

  $self->_set_start_shift( $datetime );

  return;
}

=head2 startBreakAt

Givan a L<LowLow::Model::DateTime>, updates the start break time.

  $self->startBreakAt( L<LowLow::Model::DateTime> );

return Nothing

=cut

sub startBreakAt {
  my ( $self, $datetime ) = @_;

  $self->_set_start_break( $datetime );

  return;
}

=head2 endBreakAt

Givan a L<LowLow::Model::DateTime>, updates the break ending time.

  $self->endBreakAt( L<LowLow::Model::DateTime> );

return Nothing

=cut

sub endBreakAt {
  my ( $self, $datetime ) = @_;

  $self->_set_end_break( $datetime );

  return;
}

=head2 endShiftAt

Givan a L<LowLow::Model::DateTime>, updates the end of shift time.

  $self->endShiftAt( L<LowLow::Model::DateTime> );

return Nothing

=cut

sub endShiftAt {
  my ( $self, $datetime ) = @_;

  $self->_set_end_shift( $datetime );

  return;
}


1;
__END__
