﻿
CREATE FUNCTION [dbo].[FN_GetOutbreakIDsByPRID] (@PRID INT)
	RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @OBIDs VARCHAR(MAX)
	
	SELECT @OBIDs = dbo.STRCONCAT(AR_OB.Source_ID) FROM  A_ActRelationship AR_OB (NOLOCK)		
	WHERE AR_OB.Target_ID = @PRID AND AR_OB.METACODE = 'PR_OutbreakDR'

	RETURN 	@OBIDs
END

