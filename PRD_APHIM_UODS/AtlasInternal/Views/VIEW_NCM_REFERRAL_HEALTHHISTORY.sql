﻿CREATE VIEW [AtlasInternal].[VIEW_NCM_REFERRAL_HEALTHHISTORY]            
AS            
SELECT            
DBO.[MDF_ACT_GETSTRINGVALUE_ACT_BYPARACTIDMETAVALUETYPE]('HLTHHIST_PERTINENTHISTORY',ACTHISTORY.ID,'TEXT') AS [PERTINENT HISTORY],            
DBO.[MDF_ACT_GETSTRINGVALUE_ACT_BYPARACTIDMETAVALUETYPE]('HLTHHIST_ALLERGIES',ACTHISTORY.ID,'TEXT') AS ALLERGIES,            
CASE WHEN ACTHIV.MOODCODE = 'EVN' THEN 'DONE' ELSE 'NOT DONE' END AS [HIV TEST DONE],            
DV_SERVICE.DVSVC_ROWID AS [SVC_ID],            
DV_SERVICE.DVSVC_PATIENT_FK AS PAT_ID            
FROM DV_SERVICE (NOLOCK)
INNER JOIN A_ACTRELATIONSHIP (NOLOCK) ON A_ACTRELATIONSHIP.SOURCE_ID=DV_SERVICE.DVSVC_ROWID
INNER JOIN A_ACT (NOLOCK) DOCBODY ON DOCBODY.ID=A_ACTRELATIONSHIP.TARGET_ID AND DOCBODY.CLASSCODE='DOCBODY'
INNER JOIN A_ACT (NOLOCK) ACTHISTORY ON ACTHISTORY.ACT_PARENT_ID=DOCBODY.ID AND
ACTHISTORY.CLASSCODE='DOCSECT' AND ACTHISTORY.METACODE = 'HLTHHIST_ID' AND ACTHISTORY.STATUSCODE NOT IN ('NULLIFIED','TERMINATED')        
LEFT JOIN A_ACT (NOLOCK) ACTHIV ON ACTHIV.ACT_PARENT_ID = ACTHISTORY.[ID] AND ACTHIV.CLASSCODE = 'OBS' AND ACTHIV.METACODE = 'HLTHHIST_HIVTESTDONE' 

