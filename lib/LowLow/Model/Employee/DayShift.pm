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

has start_shift => ( is => 'ro', required => 0 );

=head2 start_break

The L<LowLow::Model::DateTime> for the start of the break.

  my $start = $self->start_break();

return L<LowLow::Moder::DateTime>

=cut

has start_break => ( is => 'ro', required => 0 );

=head2 end_break

The L<LowLow::Model::DateTime> for the end of the break.

  my $end = $self->end_break();

return L<LowLow::Moder::DateTime>

=cut

has end_break => ( is => 'ro', required => 0 );

=head2 end_shift

The L<LowLow::Model::DateTime> for the end of the shift.

  my $end = $self->end_shift();

return L<LowLow::Moder::DateTime>

=cut

has end_shift => ( is => 'ro', required => 0 );


=head2 startShiftAt

Givan a L<LowLow::Model::DateTime>, returns a new instantiation
of L<LowLow::Model::Employee::DayShift> class with the shift
started at the time indicated.

  my $new_dalily_shift = $self->startShiftAt( L<LowLow::Model::DateTime> );

return L<LowLow::Model::Employee::DayShift>

=cut

sub startShiftAt {
  my ( $self, $datetime ) = @_;
  return LowLow::Model::Employee::DayShift->new(
    start_shift => $datetime,
    start_break => $self->start_break,
    end_break   => $self->end_break,
    end_shift   => $self->end_shift,
  );
}

=head2 startBreakAt

Givan a L<LowLow::Model::DateTime>, returns a new instantiation
of L<LowLow::Model::Employee::DayShift> class with the start break
set at the time indicated.

  my $new_dalily_shift = $self->startBreakAt( L<LowLow::Model::DateTime> );

return L<LowLow::Model::Employee::DayShift>

=cut

sub startBreakAt {
  my ( $self, $datetime ) = @_;
  return LowLow::Model::Employee::DayShift->new(
    start_shift => $self->start_shift,
    start_break => $datetime,
    end_break   => $self->end_break,
    end_shift   => $self->end_shift,
  );
}

=head2 endBreakAt

Givan a L<LowLow::Model::DateTime>, returns a new instantiation
of L<LowLow::Model::Employee::DayShift> class with the break
ending time.

  my $new_dalily_shift = $self->endBreakAt( L<LowLow::Model::DateTime> );

return L<LowLow::Model::Employee::DayShift>

=cut

sub endBreakAt {
  my ( $self, $datetime ) = @_;
  return LowLow::Model::Employee::DayShift->new(
    start_shift => $self->start_shift,
    start_break => $self->start_break,
    end_break   => $datetime,
    end_shift   => $self->end_shift,
  );
}

=head2 endShiftAt

Givan a L<LowLow::Model::DateTime>, returns a new instantiation
of L<LowLow::Model::Employee::DayShift> class with the end of
shift time.

  my $new_dalily_shift = $self->endShiftAt( L<LowLow::Model::DateTime> );

return L<LowLow::Model::Employee::DayShift>

=cut

sub endShiftAt {
  my ( $self, $datetime ) = @_;
  return LowLow::Model::Employee::DayShift->new(
    start_shift => $self->start_shift,
    start_break => $self->start_break,
    end_break   => $self->end_break,
    end_shift   => $datetime,
  );
}


1;
__END__
