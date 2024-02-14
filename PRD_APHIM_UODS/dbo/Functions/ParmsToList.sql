
CREATE FUNCTION [dbo].[ParmsToList] (@Parameters varchar(MAX))
	RETURNS @result TABLE (Value varchar(50))
AS 
BEGIN
 DECLARE @TempList TABLE
 (
	Value varchar(50)
 )

 DECLARE @Value varchar(50), @Pos int

 SET @Parameters = LTRIM(RTRIM(@Parameters))+ ','
 SET @Pos = CHARINDEX(',', @Parameters, 1)

 BEGIN --BLK_Spil_String_to_List
	 IF REPLACE(@Parameters, ',', '') <> ''
	 BEGIN
		 WHILE @Pos > 0
		 BEGIN
			SET @Value = LTRIM(RTRIM(LEFT(@Parameters, @Pos - 1)))
			IF @Value <> ''
			BEGIN
				INSERT INTO @TempList (Value) VALUES (@Value) --Use Appropriate conversion
			END
			SET @Parameters = RIGHT(@Parameters, LEN(@Parameters) - @Pos)
			SET @Pos = CHARINDEX(',', @Parameters, 1)
		 END
	 END  
 END

 INSERT @result
 SELECT value FROM @TempList
 RETURN
END 
