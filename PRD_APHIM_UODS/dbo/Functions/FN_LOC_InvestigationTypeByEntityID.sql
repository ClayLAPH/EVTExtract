
CREATE   FUNCTION [dbo].[FN_LOC_InvestigationTypeByEntityID] (@ID INT)
	RETURNS VARCHAR(2048)
AS
BEGIN
	DECLARE @str VARCHAR(2048)
	DECLARE @fullName AS VARCHAR(100)
	DECLARE @COUNT AS INT
	SET @COUNT=0
	
	DECLARE ATT_cursor CURSOR FOR 	
		SELECT DISTINCT UCS.fullName 
		FROM  T_Attribute Att (NOLOCK)
		INNER JOIN [V_UnifiedCodeSet] UCS (nolock) ON  UCS.[ID]=Att.[valueCode_ID] AND Att.[name] = 'LOC_InvestigationTypeDR' AND Att.[type] = 'bl' 
		AND ATT.VALUEBOOL=1 AND Att.ENTITY_ID=@ID
	OPEN ATT_cursor

	FETCH NEXT FROM ATT_cursor 
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
			FETCH NEXT FROM ATT_cursor 
			INTO @fullName
		END
	CLOSE ATT_cursor
   	DEALLOCATE ATT_cursor
	
	RETURN @str
END

