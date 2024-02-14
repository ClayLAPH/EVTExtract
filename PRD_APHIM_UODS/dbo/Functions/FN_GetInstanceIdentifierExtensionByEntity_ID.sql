﻿
CREATE FUNCTION [dbo].[FN_GetInstanceIdentifierExtensionByEntity_ID](@Entity_ID as INT, @ROOT VARCHAR(100))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @EXTENSION VARCHAR(50)
	SELECT @EXTENSION=EXTENSION FROM T_InstanceIdentifier(NOLOCK) WHERE [root]=@ROOT and Entity_ID=@Entity_ID
	RETURN @EXTENSION
END
