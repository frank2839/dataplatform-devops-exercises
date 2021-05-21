EXEC tSQLt.NewTestClass 'Reports_StateYearReservationCount_Tests';
GO

--no rows found
CREATE or alter PROCEDURE Reports_StateYearReservationCount_Tests.[test no reservation and no rows found] 
AS
BEGIN
  exec tSQLt.FakeTable 'Booking.Reservations';
  select * into #actual from Reports.StateYearReservationCount;

  EXEC tSQLt.AssertEmptyTable '#actual';
END;
GO

--One reservation
CREATE PROCEDURE Reports_StateYearReservationCount_Tests.[test one reservation in the reservation table and return reservation count one] 
AS
BEGIN

  exec tSQLt.FakeTable 'Booking.Reservations';
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (1,2021, 'A');


  select ReservationYear, ReservationState, ReservationCount
  into #actual  
  from Reports.StateYearReservationCount;

  select * into #Expected from #actual where 1 =2
  insert into #Expected values (2021, 'A', 1)


  EXEC tSQLt.AssertEqualsTable  '#Expected', '#actual';
END;
GO

--multiple reservation
--first one  for multiple reservations
CREATE PROCEDURE Reports_StateYearReservationCount_Tests.[test multiple reservations in same year and ReservationState and return correct count] 
AS
BEGIN

  exec tSQLt.FakeTable 'Booking.Reservations';
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (1,2021, 'A');
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (2,2021, 'A');
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (0,2021, 'A');
   
  select ReservationYear, ReservationState, ReservationCount
  into #actual  
  from Reports.StateYearReservationCount;

  select * into #Expected from #actual where 1 =2
  insert into #Expected values (2021, 'A', 3)


  EXEC tSQLt.AssertEqualsTable  '#Expected', '#actual';
END;
GO


--second for group by for year
CREATE PROCEDURE Reports_StateYearReservationCount_Tests.[test multiple reservations in group correctly by year and ReservationState and return correct count] 
AS
BEGIN

  exec tSQLt.FakeTable 'Booking.Reservations';
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (1,2021, 'A');
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (2,2021, 'A');
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (0,2021, 'A');
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (3,2022, 'A');
   
  select ReservationYear, ReservationState, ReservationCount
  into #actual  
  from Reports.StateYearReservationCount;

  select * into #Expected from #actual where 1 =2
  insert into #Expected values (2021, 'A', 3)
  insert into #Expected values (2022, 'A', 1)


  EXEC tSQLt.AssertEqualsTable  '#Expected', '#actual';
END;
GO




-- third for group by state

CREATE PROCEDURE Reports_StateYearReservationCount_Tests.[test multiple reservations in the reservation table and return group by ReservationYear and State] 
AS
BEGIN

  exec tSQLt.FakeTable 'Booking.Reservations';
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (1,2021, 'A');
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (2,2021, 'U');
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (3,2021, 'A');
  insert into Booking.Reservations (ReservationId, ReservationYear, ReservationState) values (4,2020, 'A');



  select ReservationYear, ReservationState, ReservationCount
  into #actual  
  from Reports.StateYearReservationCount;

  select * into #Expected from #actual where 1 =2
  insert into #Expected values (2021, 'A', 2)
  insert into #Expected values (2021, 'U', 1)
  insert into #Expected values (2020, 'A', 1)

  EXEC tSQLt.AssertEqualsTable  '#Expected', '#actual';
END;
GO