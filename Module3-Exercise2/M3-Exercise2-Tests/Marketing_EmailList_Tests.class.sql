EXEC tSQLt.NewTestClass 'Marketing_EmailList_Tests';
GO

-- no user
CREATE PROCEDURE Marketing_EmailList_Tests.[test for no user]
AS
BEGIN
  INSERT INTO Booking.Customers(CustomerId, FirstName, LastName, Email,  OptIn)
  VALUES(1, 'FirstName1', 'LastName1', 'Email1', 0),
  (2, 'FirstName2', 'LastName2', 'Email2', 0),
  (3, 'FirstName3', 'LastName3', 'Email3', 0),
  (4, 'FirstName4', 'LastName4', 'Email4', 0);
  
  SELECT CustomerId, FirstName, LastName, Email,  OptIn INTO #Actual FROM Marketing.EmailList();
  
  EXEC tSQLt.AssertEmptyTable '#Actual';

END;
GO

-- one user
CREATE PROCEDURE Marketing_EmailList_Tests.[test for one user]
AS
BEGIN
  INSERT INTO Booking.Customers(CustomerId, FirstName, LastName, Email,  OptIn)
  VALUES(1, 'FirstName1', 'LastName1', 'Email1', 1)
  
  SELECT CustomerId, FirstName, LastName, Email,  OptIn INTO #Actual FROM Marketing.EmailList();
  
  SELECT * INTO #Expected FROM #Actual where 1 =2
    INSERT INTO #Expected
  VALUES(1, 'FirstName1', 'LastName1', 'Email1', 1);

  EXEC tSQLt.AssertEqualsTable '#Expected','#Actual';

END;
GO

-- multiple user
CREATE PROCEDURE Marketing_EmailList_Tests.[test for multiple user]
AS
BEGIN
  INSERT INTO Booking.Customers(CustomerId, FirstName, LastName, Email,  OptIn)
  VALUES(1, 'FirstName1', 'LastName1', 'Email1', 1),
  (2, 'FirstName2', 'LastName2', 'Email2', 0),
  (3, 'FirstName3', 'LastName3', 'Email3', 1),
  (4, 'FirstName4', 'LastName4', 'Email4', 0);
  
  SELECT CustomerId, FirstName, LastName, Email,  OptIn INTO #Actual FROM Marketing.EmailList();
  
  SELECT * INTO #Expected FROM #Actual where 1 =2
  
  INSERT INTO #Expected
  VALUES(1, 'FirstName1', 'LastName1', 'Email1', 1),(3, 'FirstName3', 'LastName3', 'Email3', 1);

  EXEC tSQLt.AssertEqualsTable '#Expected','#Actual';

END;
GO



