CREATE FUNCTION Marketing.GetGreeting (
@FirstName Varchar (10) ,@LastName Varchar (10))
RETURNS NVARCHAR (20) 
AS
BEGIN
	declare @RETURNS NVARCHAR (20) 
	set @RETURNS = 'Dear '+ LEFT(@FirstName, 1) + '. ' + trim (@LastName)
	Return @RETURNS
END
GO

