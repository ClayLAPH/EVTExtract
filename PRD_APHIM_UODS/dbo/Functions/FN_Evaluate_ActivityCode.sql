

CREATE FUNCTION [dbo].[FN_Evaluate_ActivityCode]  (@Code AS NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
DECLARE @FOUND BIT
SET @FOUND=0

DECLARE @intFlag INT
SET @intFlag = 1

WHILE (@intFlag < 12)
BEGIN

IF CHARINDEX(CONVERT(VARCHAR(10),@intFlag), @Code) > 0 
SET @FOUND=1;
SET @intFlag = @intFlag + 1
IF @intFlag = 7
SET @intFlag = 8
IF @FOUND = 1
BREAK;
END
RETURN @FOUND
END

