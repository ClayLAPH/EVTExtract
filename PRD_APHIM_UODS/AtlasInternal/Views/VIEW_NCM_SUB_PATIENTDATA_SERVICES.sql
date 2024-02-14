﻿
CREATE  VIEW [AtlasInternal].[VIEW_NCM_SUB_PATIENTDATA_SERVICES]
AS
SELECT 
	[DBO].DV_SERVICE.DVSVC_ROWID AS SVC_SERVICEID, 
	ACT_PHCASE.CODE_ID as SVC_CODE_ID,
	[DBO].DV_SERVICE.DVSVC_PATIENT_FK AS SVC_PATIENTID,
	[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](ACT_PHCASE.CODE_ID) AS SVC_INITIALSERVICE,
	[DBO].DV_SERVICE.DVSVC_CURRENTSERVICECODE_ID AS SVC_CURRENTSERVICE_UCSID,
	[DBO].DV_SERVICE.DVSVC_INITIALDATE AS SVC_INITIALSERVICEDATE, 
	ACT_PHCASE.EFFECTIVETIME_BEG AS SVC_CURRENTSERVICEDATE,
	[DBO].DV_SERVICE.DVSVC_STATUSCODE_ID AS SVC_STATUS_UCSID,
	[DBO].DV_SERVICE.DVSVC_JURISDICTIONCODE_ID AS SVC_JURISDICTIONCODEID,
	DVSVC_CASEMANAGER_FK
FROM 
	DV_SERVICE (NOLOCK) 
	INNER JOIN DBO.A_ACT ACT_PHCASE (NOLOCK) ON ACT_PHCASE.ID = DV_SERVICE.DVSVC_ROWID AND ACT_PHCASE.METACODE = 'SVC_ID' 

