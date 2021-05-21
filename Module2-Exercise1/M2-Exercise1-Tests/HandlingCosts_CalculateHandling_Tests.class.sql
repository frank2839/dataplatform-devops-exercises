EXEC tSQLt.NewTestClass 'HandlingCosts_Tests';
GO

CREATE PROCEDURE HandlingCosts_Tests.[test customer has more than 10000]
AS
BEGIN
	DECLARE @ExpectedHandlingCost INT;
	DECLARE @ActualHandlingCost INT;

	SELECT @ActualHandlingCost = (SELECT HandlingCosts.CalculateHandling(20000));

	SET @ExpectedHandlingCost = 0;

	EXEC tSQLt.AssertEquals @ExpectedHandlingCost, @ActualHandlingCost;
END
GO

CREATE PROCEDURE HandlingCosts_Tests.[test customer has less than 10000]
AS
BEGIN
	DECLARE @ExpectedHandlingCost INT;
	DECLARE @ActualHandlingCost INT;

	SELECT @ActualHandlingCost = (SELECT HandlingCosts.CalculateHandling(500));

	SET @ExpectedHandlingCost = 37;

	EXEC tSQLt.AssertEquals @ExpectedHandlingCost, @ActualHandlingCost;
END
GO

-- test for 10000
CREATE PROCEDURE HandlingCosts_Tests.[test customer equal to 10000]
AS
BEGIN
	DECLARE @ExpectedHandlingCost INT;
	DECLARE @ActualHandlingCost INT;

	SELECT @ActualHandlingCost = (SELECT HandlingCosts.CalculateHandling(10000));

	SET @ExpectedHandlingCost = 37;

	EXEC tSQLt.AssertEquals @ExpectedHandlingCost, @ActualHandlingCost;
END
GO