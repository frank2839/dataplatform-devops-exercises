create or alter view Reports.HotelReservationCount as
select  h.HotelId, h.Name, h.HotelState, count(ReservationId) as ReservationCount
from Vendors.Hotels h join Booking.Reservations r on h.HotelId = r.HotelId
group by h.HotelId, h.Name, h.HotelState