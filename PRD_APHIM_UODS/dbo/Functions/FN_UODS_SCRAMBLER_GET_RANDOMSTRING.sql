﻿
CREATE FUNCTION [dbo].[FN_UODS_SCRAMBLER_GET_RANDOMSTRING](@NAME VARCHAR(4000))
RETURNS VARCHAR(4000)
AS
BEGIN
IF @NAME IS NOT NULL
BEGIN --Get Random String
	DECLARE @VALIDCHARACTERS VARCHAR(255)
	SET @VALIDCHARACTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	DECLARE @VALIDCHARACTERSLENGTH INT
	SET @VALIDCHARACTERSLENGTH = LEN(@VALIDCHARACTERS)

	DECLARE @VALIDINT VARCHAR(255)
	SET @VALIDINT = '0123456789'
	DECLARE @VALIDINTLENGTH INT
	SET @VALIDINTLENGTH = LEN(@VALIDINT)


	DECLARE @COUNTER INT
	DECLARE @LENGTH INT
	DECLARE @FINALNAME VARCHAR(4000)
	SET @FINALNAME = ''
	DECLARE @RANDOMNUMBER FLOAT
	SET @RANDOMNUMBER = 0
	DECLARE @RANDOMNUMBERINT INT
	DECLARE @CURRENTCHARACTER VARCHAR(1)
	SET @CURRENTCHARACTER = ''
	SET @RANDOMNUMBERINT = 0
	SET @LENGTH = LEN(@NAME)
	SET @COUNTER = 1


	WHILE @COUNTER < (@LENGTH + 1)
	BEGIN
		IF CHARINDEX(SUBSTRING(@NAME, @COUNTER, 1), @VALIDCHARACTERS) > 0 
		BEGIN 
				SELECT @RANDOMNUMBER = RANDOMNUMBER FROM [ATLASINTERNAL].[VIEW_UODS_SCRAMBLER_GET_RAND]

				SET @RANDOMNUMBERINT = CONVERT(TINYINT, ((@VALIDCHARACTERSLENGTH - 1) * @RANDOMNUMBER + 1))
				SELECT @CURRENTCHARACTER = SUBSTRING(@VALIDCHARACTERS, @RANDOMNUMBERINT, 1)
		END 
		ELSE
		BEGIN
			IF CHARINDEX(SUBSTRING(@NAME, @COUNTER, 1), @VALIDINT) > 0 
			BEGIN
				SELECT @RANDOMNUMBER = RANDOMNUMBER FROM [ATLASINTERNAL].[VIEW_UODS_SCRAMBLER_GET_RAND]
				SET @RANDOMNUMBERINT = CONVERT(TINYINT, ((@VALIDINTLENGTH - 1) * @RANDOMNUMBER + 1))
				SELECT @CURRENTCHARACTER = SUBSTRING(@VALIDINT, @RANDOMNUMBERINT, 1)
			END
			ELSE
			BEGIN
				SET @CURRENTCHARACTER = SUBSTRING(@NAME, @COUNTER, 1)
			END
		END
		SET @COUNTER = @COUNTER + 1
		SET @FINALNAME = @FINALNAME + @CURRENTCHARACTER

	END
END
ELSE 
BEGIN 
	SET @FINALNAME = NULL
END
		RETURN @FINALNAME	
END

