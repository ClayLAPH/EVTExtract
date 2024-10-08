﻿
CREATE VIEW [AtlasInternal].[VIEW_NCM_ENCOUNTER_COUNTYOFCASEMANAGEMENT_LIST]
AS
SELECT 
	VPATIENTFOLDER.PATIENT_ID AS PATIENT_ID,
	ACT_COUNTYOFCASEMANAGEMENT.EFFECTIVETIME_BEG AS MGMTCNTY_ASOFDATE,
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(ACT_COUNTYOFCASEMANAGEMENT.CODE_ID) AS MGMTCNTY_COUNTYNAME_TEXT,
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(ACT_COUNTYOFCASEMANAGEMENT.VALUECODE_ID) AS MGMTCNTY_STATE_TEXT
FROM 
[ATLASINTERNAL].[VIEW_CMN_PATIENTFOLDER] VPATIENTFOLDER  (NOLOCK)
INNER JOIN DBO.A_ACT ACT_DOCBODY (NOLOCK) ON ACT_DOCBODY.ACT_PARENT_ID=VPATIENTFOLDER.ACT_FOLDER_ID AND ACT_DOCBODY.CLASSCODE='DOCBODY'
INNER JOIN A_ACT ACT_COUNTYOFCASEMANAGEMENT (NOLOCK) ON ACT_COUNTYOFCASEMANAGEMENT.ACT_PARENT_ID=ACT_DOCBODY.ID AND ACT_COUNTYOFCASEMANAGEMENT.METACODE = 'MGMTCNTY_ID' AND ACT_COUNTYOFCASEMANAGEMENT.STATUSCODE = 'ACTIVE' 


