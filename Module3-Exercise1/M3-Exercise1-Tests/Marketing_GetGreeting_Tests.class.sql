EXEC tSQLt.NewTestClass 'Marketing_GetGreeting_Tests';
GO

CREATE PROCEDURE Marketing_GetGreeting_Tests.[test salutation for customers]
AS
BEGIN
	DECLARE @ExpectedGreeting NVARCHAR (20) ;
	DECLARE @ActualGreeting NVARCHAR (20) ;

	SELECT @ActualGreeting = (SELECT Marketing.GetGreeting('John', 'Smith'));

	SET @ExpectedGreeting = 'Dear J. Smith';

	EXEC tSQLt.AssertEquals @ExpectedGreeting, @ActualGreeting;
END
GO

