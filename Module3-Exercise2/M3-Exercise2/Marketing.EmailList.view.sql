CREATE or alter FUNCTION Marketing.EmailList ()
RETURNS TABLE
AS
RETURN
  SELECT   CustomerId, FirstName, LastName, Email,  OptIn
    FROM Booking.Customers
    where OptIn = 1;
GO
