create or alter view Reports.StateYearReservationCount as
select  ReservationYear, ReservationState,  count(ReservationId) as ReservationCount
from Booking.Reservations r
group by ReservationYear, ReservationState

-- where ReservationYear, ReservationState come from?