﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_CASEFLOW_TBSITELOC]
AS
SELECT
	DVSVC.DVSVC_ROWID AS SERVICE_FK,
	DVSVC.DVSVC_PATIENT_FK AS PATIENT_FK,
	TBSITELOC.ID AS TBSITELOC_ID,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('TBSITELOC_ISMAJORSITE',TBSITELOC.ID,'VALUEBOOL')
	AS TBSITELOC_ISMAJORSITE,
	[DBO].[MDF_UCS_FULLNAME_ACTUCS_BYACTID](TBSITELOC.ID,'CODE_ID')
	AS TBSITELOC_SITE_TEXT
FROM 
	DV_SERVICE DVSVC (NOLOCK)
	INNER JOIN A_ACT DOCBODY (NOLOCK) ON DOCBODY.ACT_PARENT_ID=DVSVC.DVSVC_ROWID AND DOCBODY.CLASSCODE='DOCBODY' 
	INNER JOIN A_ACT ACT_TBSITE (NOLOCK) ON ACT_TBSITE.ACT_PARENT_ID=DOCBODY.ID AND ACT_TBSITE.METACODE='TBSITE_ID' 
	LEFT JOIN A_ACT TBSITELOC (NOLOCK) ON TBSITELOC.ACT_PARENT_ID=ACT_TBSITE.ID AND TBSITELOC.METACODE='TBSITELOC_ID'
