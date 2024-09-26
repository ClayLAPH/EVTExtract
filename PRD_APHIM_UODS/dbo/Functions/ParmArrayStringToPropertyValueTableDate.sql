﻿CREATE FUNCTION [DBO].[ParmArrayStringToPropertyValueTableDate] (@SECTIONVALPMARY VARCHAR(MAX))
RETURNS @SECTIONVAL TABLE (INTVAL INT, DATEVAL VARCHAR(MAX))
AS
BEGIN
	DECLARE 
	@CHARPOSITION INT,
	@CHARLENTH INT,
	@TXT VARCHAR(MAX),
	@INTVAL INTEGER,
	@DATEVAL VARCHAR(MAX),
	@UPDATED BIT 

	SET @TXT = ''
	SET @UPDATED = 1
	SET @CHARLENTH = LEN(@SECTIONVALPMARY)
	SET @CHARPOSITION = 1
	SET @INTVAL=0
	IF RIGHT(@SECTIONVALPMARY,1) = ';'
	SET @SECTIONVALPMARY = SUBSTRING(@SECTIONVALPMARY, 0,LEN(@SECTIONVALPMARY))

	WHILE @CHARPOSITION <= @CHARLENTH + 1
		BEGIN
			IF SUBSTRING(@SECTIONVALPMARY,@CHARPOSITION,1) NOT IN(',',';') AND @CHARPOSITION < @CHARLENTH + 1
				BEGIN
					SET @TXT = @TXT + SUBSTRING(@SECTIONVALPMARY,@CHARPOSITION,1)
					SET @UPDATED = 0
				END
			ELSE
				BEGIN
					IF @UPDATED = 0
						BEGIN
							IF @INTVAL=0
								BEGIN
									SET @INTVAL = CAST(@TXT AS INT)
								END
							ELSE
								BEGIN
									SET @DATEVAL = CAST(@TXT AS VARCHAR(MAX))
									INSERT INTO @SECTIONVAL (INTVAL, DATEVAL) VALUES(@INTVAL,@DATEVAL)
									SET @INTVAL=0
								END
							SET @TXT = ''
							SET @UPDATED = 1
						END
				END

			SET @CHARPOSITION  = @CHARPOSITION + 1
		END
	RETURN
END
