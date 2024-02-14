﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_PATIENTDATA_INCOMEVERIFICATION]
AS
SELECT 
	ACT_PATIV.[ID] AS [PATIV_ID], 
	VPATIENTFOLDER.PATIENT_ID AS [PATIV_PATIENT_FK],
	[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](ACT_PATIV.VALUECODE_ID) AS [PATIV_NUMBERINHOUSEHOLD],
	ACT_PATIV.VALUESTRING_TXT AS [PATIV_MONTHLYINCOMELEVELDESC],
	ACT_PATIV.VALUETS AS [PATIV_DATEVERIFIED]
FROM
	DBO.A_ACT ACT_PATIV (NOLOCK)
	INNER JOIN [VIEW_CMN_PATIENTFOLDER] VPATIENTFOLDER (NOLOCK) ON ACT_PATIV.ACT_PARENT_ID = VPATIENTFOLDER.ACT_FOLDER_ID
WHERE 
	ACT_PATIV.METACODE='PATIV_ID' AND ACT_PATIV.STATUSCODE = 'ACTIVE'