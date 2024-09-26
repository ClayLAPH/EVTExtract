
CREATE   FUNCTION [dbo].[FN_ExposureTypes] (@ID INT)
	RETURNS VARCHAR(2048)
AS
BEGIN
	DECLARE @str VARCHAR(2048)
	DECLARE @fullName AS VARCHAR(100)
	DECLARE @COUNT AS INT
	SET @COUNT=0
	
	DECLARE ACT_cursor CURSOR FOR 	
		SELECT DISTINCT UCS.fullName 
		FROM  A_ACT ACT 
		LEFT JOIN  dbo.V_UnifiedCodeSet UCS ON ACT.code_id=UCS.ID
		INNER JOIN A_ActRelationship ON ACT.[ID] = dbo.A_ActRelationship.target_ID AND ACT.metaCode = 'DEE_RowID' 
		AND ACT.classcode = 'INC' AND A_ActRelationship.source_ID=@ID
	OPEN ACT_cursor

	FETCH NEXT FROM ACT_cursor 
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
			FETCH NEXT FROM ACT_cursor 
			INTO @fullName
		END
	CLOSE ACT_cursor
   	DEALLOCATE ACT_cursor
	
	RETURN @str
END
