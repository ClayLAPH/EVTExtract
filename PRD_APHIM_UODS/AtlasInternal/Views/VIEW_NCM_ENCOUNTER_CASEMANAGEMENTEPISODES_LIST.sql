﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_ENCOUNTER_CASEMANAGEMENTEPISODES_LIST]
AS
SELECT 
	VPATIENTFOLDER.PATIENT_ID AS PATIENT_ID,
	ENCOUNTERCASEMANAGER.NAMECOMBINED AS MGMTEPISD_CASEMANAGER_TEXT,
	ACT_CASEMANAGEMENTEPISODE.EFFECTIVETIME_END AS MGMTEPISD_CASEMGMTCLOSED,  
	ACT_CASEMANAGEMENTEPISODE.EFFECTIVETIME_BEG AS MGMTEPISD_CASEMGMTOPENED 
FROM 
	[VIEW_CMN_PATIENTFOLDER] VPATIENTFOLDER  (NOLOCK)
	INNER JOIN DBO.A_ACT ACT_DOCBODY (NOLOCK) ON ACT_DOCBODY.ACT_PARENT_ID=VPATIENTFOLDER.ACT_FOLDER_ID AND ACT_DOCBODY.CLASSCODE='DOCBODY' 
	INNER JOIN DBO.A_ACT ACT_CASEMANAGEMENTEPISODE (NOLOCK) ON ACT_CASEMANAGEMENTEPISODE.ACT_PARENT_ID=ACT_DOCBODY.ID AND ACT_CASEMANAGEMENTEPISODE.CLASSCODE='PCPR' AND ACT_CASEMANAGEMENTEPISODE.STATUSCODE = 'ACTIVE' 
	LEFT JOIN VIEW_CMN_PARTICIPATION_ROLE_ENTITY ENCOUNTERCASEMANAGER (NOLOCK) ON ACT_CASEMANAGEMENTEPISODE.ID=ENCOUNTERCASEMANAGER.ACT_ID AND ENCOUNTERCASEMANAGER.TYPECODE='PPRF' AND ENCOUNTERCASEMANAGER.USECODE = 'L'
WHERE
	ACT_CASEMANAGEMENTEPISODE.METACODE = 'MGMTEPISD_ID'
