﻿CREATE  FUNCTION [dbo].[FN_SpecimenTypes] (@ID INT, @OPTION INT)
	RETURNS VARCHAR(2048)
AS
BEGIN
	DECLARE @str VARCHAR(2048)
	DECLARE @fullName AS VARCHAR(100)
	DECLARE @COUNT AS INT
	SET @COUNT=0
	IF @OPTION = 0
	BEGIN
		DECLARE OBS_cursor CURSOR FOR 
			SELECT DISTINCT UCS.fullName from A_Observation OBS 
			INNER JOIN A_ACT ACTOBS ON ACTOBS.[ID] = OBS.[ID]			
			LEFT JOIN  dbo.V_UnifiedCodeSet UCS ON OBS.targetSiteCode_ID = UCS.ID
			WHERE CLASSCODE = 'OBS' AND METACODE = 'SPEC_RowID' AND ACTOBS.[ACT_PARENT_ID] =@ID
	END
	ELSE
	BEGIN	
		DECLARE OBS_cursor CURSOR FOR 	
			SELECT DISTINCT UCS.fullName FROM A_Observation OBS INNER JOIN A_ACT ACTOBS ON ACTOBS.[ID] = OBS.[ID]			
			LEFT JOIN  dbo.V_UnifiedCodeSet UCS 
			ON OBS.targetSiteCode_ID = UCS.ID 
			WHERE ACTOBS.CLASSCODE = 'OBS' AND (ACTOBS.METACODE = 'SPEC_RowID' OR ACTOBS.metaCode='DIST_RowID') 
			AND ACTOBS.[ACT_PARENT_ID] = @ID			
	END
	OPEN OBS_cursor

	FETCH NEXT FROM OBS_cursor 
	INTO @fullName

		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @fullName<>''
			BEGIN
				IF @COUNT = 0
				BEGIN
					SET @str = @fullName
					SET @COUNT = 1
				END
				ELSE
				BEGIN
					SET @str = @str + ', ' + @fullName
				END
			END
			FETCH NEXT FROM OBS_cursor 
			INTO @fullName
		END
	CLOSE OBS_cursor
   	DEALLOCATE OBS_cursor

	RETURN @str
END

