﻿

CREATE FUNCTION [dbo].[FN_GetOutbreakTypesByPRID] (@PRID INT)
	RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @OBTypes VARCHAR(MAX)

	SELECT @OBTypes = dbo.STRCONCAT(ISNULL(OBType.fullName,'')) FROM  A_ActRelationship AR_OB (NOLOCK)
	INNER JOIN DV_Outbreak OB (NOLOCK) On OB.DVOB_RowID = AR_OB.Source_ID
	LEFT JOIN V_UnifiedCodeSet OBType (NOLOCK) ON OB.DVOB_OutbreakTypeCode_ID = OBType.ID
	WHERE AR_OB.Target_ID = @PRID AND AR_OB.METACODE = 'PR_OutbreakDR'
	
	RETURN 	@OBTypes
END
