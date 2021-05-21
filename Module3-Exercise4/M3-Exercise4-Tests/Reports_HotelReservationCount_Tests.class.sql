
EXEC tSQLt.NewTestClass 'Reports_HotelReservationCount_Tests';
GO

--no rows empty set
CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test no records return reservation by no hotel] 
AS
BEGIN
  exec tSQLt.FakeTable 'Vendors.Hotels';
  select * into #actual from Reports.HotelReservationCount;

  EXEC tSQLt.AssertEmptyTable '#actual';
END;
GO

--single hotel with no reservation
CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test one hotel but no reservation] 
AS
BEGIN
  exec tSQLt.FakeTable 'Vendors.Hotels';
  insert into Vendors.Hotels (HotelId, Name, HotelState, CostPerNight)values (1, 'Hotel1', 'A', 100);


  select HotelId, Name, HotelState, ReservationCount 
  into #actual  
  from Reports.HotelReservationCount;

  select * into #Expected from #actual where 1 =2

  EXEC tSQLt.AssertEqualsTable  '#Expected', '#actual';
END;
GO

--multiple hotels with no reservations
CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test multiple hotel with no reservations] 
AS
BEGIN
  exec tSQLt.FakeTable 'Vendors.Hotels';
  insert into Vendors.Hotels (HotelId, Name, HotelState, CostPerNight)values (1, 'Hotel1', 'A', 100);
  insert into Vendors.Hotels (HotelId, Name, HotelState, CostPerNight)values (2, 'Hotel2', 'B', 200);

  exec tSQLt.FakeTable 'Booking.Reservations';


  select HotelId, Name, HotelState, ReservationCount 
  into #actual  
  from Reports.HotelReservationCount;

  select * into #Expected from #actual where 1 =2


  EXEC tSQLt.AssertEqualsTable  '#Expected', '#actual';
END;
GO

-- multiple hotels with differing reservation counts
CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test multiple hotel with differing reservation counts] 
AS
BEGIN
  exec tSQLt.FakeTable 'Vendors.Hotels';
  insert into Vendors.Hotels (HotelId, Name, HotelState, CostPerNight)values (1, 'Hotel1', 'A', 100);
  insert into Vendors.Hotels (HotelId, Name, HotelState, CostPerNight)values (2, 'Hotel2', 'B', 200);

  exec tSQLt.FakeTable 'Booking.Reservations';
  insert into Booking.Reservations (ReservationId, CustomerId, HotelId) values (1,10,1);
  insert into Booking.Reservations (ReservationId, CustomerId, HotelId) values (2,20,1);
  insert into Booking.Reservations (ReservationId, CustomerId, HotelId) values (3,30,2);

  select HotelId, Name, HotelState, ReservationCount 
  into #actual  
  from Reports.HotelReservationCount;

  select * into #Expected from #actual where 1 =2
  insert into #Expected values (1, 'Hotel1', 'A', 2)
  insert into #Expected values (2, 'Hotel2', 'B', 1)

  EXEC tSQLt.AssertEqualsTable  '#Expected', '#actual';
END;
GO

--one additional row for all erservations with null hotelid
CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test multiple hotel with with null hotelid] 
AS
BEGIN
  exec tSQLt.FakeTable 'Vendors.Hotels';
  insert into Vendors.Hotels (HotelId, Name, HotelState, CostPerNight)values (1, 'Hotel1', 'A', 100);
  insert into Vendors.Hotels (HotelId, Name, HotelState, CostPerNight)values (2, 'Hotel2', 'B', 200);

  exec tSQLt.FakeTable 'Booking.Reservations';
  insert into Booking.Reservations (ReservationId, CustomerId, HotelId) values (1,10,1);
  insert into Booking.Reservations (ReservationId, CustomerId, HotelId) values (2,20,1);
  insert into Booking.Reservations (ReservationId, CustomerId, HotelId) values (3,30,2);
  insert into Booking.Reservations (ReservationId, CustomerId, HotelId) values (4,40,null);

  select HotelId, Name, HotelState, ReservationCount 
  into #actual  
  from Reports.HotelReservationCount;

  select * into #Expected from #actual where 1 =2
  insert into #Expected values (1, 'Hotel1', 'A', 2)
  insert into #Expected values (2, 'Hotel2', 'B', 1)

  EXEC tSQLt.AssertEqualsTable  '#Expected', '#actual';
END;
GO

