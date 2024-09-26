
CREATE FUNCTION [dbo].[FN_DiseaseGroups_ID] (@ID INT)
	RETURNS VARCHAR(2048)
AS
BEGIN
	DECLARE @str VARCHAR(2048)
	DECLARE @group_ID AS INT
	DECLARE @COUNT AS INT
	SET @COUNT=0
	
	DECLARE DiseaseGroup_cursor CURSOR FOR 	
		SELECT DISTINCT V_CodeProperty.subjCode_ID 
		FROM 	V_CodeProperty 
		WHERE V_CodeProperty.valueCode_ID = @ID AND V_CodeProperty.property = 'GRPD_DiseaseDR'			
	OPEN DiseaseGroup_cursor

	FETCH NEXT FROM DiseaseGroup_cursor 
	INTO @group_ID

		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @group_ID > 0
			BEGIN
				IF @COUNT = 0
				BEGIN
					SET @str = CONVERT(VARCHAR(10), @group_ID) + ', '
					SET @COUNT = 1
				END
				ELSE
				BEGIN
					SET @str = @str + CONVERT(VARCHAR(10), @group_ID) + ', '
				END
			END
			FETCH NEXT FROM DiseaseGroup_cursor 
			INTO @group_ID
		END
	CLOSE DiseaseGroup_cursor
   	DEALLOCATE DiseaseGroup_cursor

	RETURN @str
END
