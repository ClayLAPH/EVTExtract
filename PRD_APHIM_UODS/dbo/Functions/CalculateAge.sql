
CREATE FUNCTION [dbo].[CalculateAge](@DOB AS DateTime, @Type AS Varchar(10)='YEARS')
RETURNS INT
AS
BEGIN
	DECLARE @FromDate AS DateTime
	SET @FromDate =  GETDATE()
	IF DATEDIFF(DAY,@DOB,@FromDate ) > 0 
	BEGIN
	  IF @Type = 'YEARS' 
		BEGIN
			If Month(@DOB) < MONTH(@FromDate) OR Month(@DOB) = MONTH(@FromDate) AND DAY(@DOB) < DAY(@FromDate) 
				BEGIN
				   Return YEAR(@FromDate) - Year(@DOB)
				END
				Return YEAR(@FromDate) - Year(@DOB) - 1
		 END
	  ELSE IF @Type = 'MONTHS' 
		 BEGIN
		  If Month(@DOB) > MONTH(@FromDate) OR Month(@DOB) = MONTH(@FromDate) AND DAY(@DOB) > DAY(@FromDate) 
				BEGIN
				If DAY(@DOB) > DAY(@FromDate) 
				 Return MONTH(@FromDate) - MONTH(@DOB) + 11 
				 ELSE
				 Return MONTH(@FromDate) - MONTH(@DOB) + 12 
				END
				If DAY(@DOB) > DAY(@FromDate) 
				   Return MONTH(@FromDate) - MONTH(@DOB) -1 
				ELSE
				  Return MONTH(@FromDate) - MONTH(@DOB) 
		  END
	ELSE IF @Type = 'DAYS'
		BEGIN
		If DAY(@DOB) > DAY(@FromDate) 
			BEGIN
			   Return DAY(@FromDate) - DAY(@DOB) + DAY(dateadd(mm,datediff(mm,-1,@FromDate),-1))
			END
			Return   DAY(@FromDate) - DAY(@DOB)
		END
	END
	Return 0
END
