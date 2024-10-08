﻿CREATE VIEW [AtlasInternal].[VIEW_NCM_REFERRAL_SERVICE]          
AS       
SELECT           
	DV_SERVICE.DVSVC_ROWID AS [SVC_ID],          
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(SVC.CODE_ID) AS [INITIAL SERVICE],          
	DV_SERVICE.DVSVC_INITIALDATE AS [INITIAL SERVICE DATE],          
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(DV_SERVICE.DVSVC_CURRENTSERVICECODE_ID) AS [CURRENT SERVICE],          
	SVC.EFFECTIVETIME_BEG AS [CURRENT SERVICE DATE],          
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(DV_SERVICE.DVSVC_STATUSCODE_ID) AS STATUS,          
	PHCASE.DXDATE AS [STATUS CHANGED DATE],          
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(SVC.PRIORITYCODE_ID) AS COUNTRY,          
	DV_SERVICE.DVSVC_PATIENT_FK AS PAT_ID 
FROM 
	DV_SERVICE (NOLOCK)
	INNER JOIN A_ACT SVC (NOLOCK) ON SVC.ID=DV_SERVICE.DVSVC_ROWID
	INNER JOIN A_PUBLICHEALTHCASE PHCASE (NOLOCK) ON PHCASE.ID=DV_SERVICE.DVSVC_ROWID 

