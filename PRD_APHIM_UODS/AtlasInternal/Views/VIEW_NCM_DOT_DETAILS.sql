﻿
CREATE VIEW [AtlasInternal].[VIEW_NCM_DOT_DETAILS]
AS
SELECT 
	DVSVC.DVSVC_ROWID AS SVC_ID,
	DVSVC.DVSVC_PATIENT_FK AS DOTDTL_PATIENT_FK,
	ACT_DOT.ID AS DOTDTL_ID,
	--WE NEED TO SHOW ACTIVE AND INACTIVE DOTS AS WE SHOW IT IN UI LEVEL ALSO. THIS IS EXCEPTION FOR DOT ONLY
	CASE WHEN ACT_DOT.STATUSCODE = 'ACTIVE' THEN 1 ELSE 0 END AS DOTDTL_ACTIVE,
	
	CASE WHEN CHARINDEX('DW1',ACT_DOT.[EFFECTIVETIME_TXT])=0 THEN 0 ELSE 1 END AS [DOTDTL_MONDAY], 
	CASE WHEN CHARINDEX('DW2',ACT_DOT.[EFFECTIVETIME_TXT])=0 THEN 0 ELSE 1 END AS [DOTDTL_TUESDAY], 
	CASE WHEN CHARINDEX('DW3',ACT_DOT.[EFFECTIVETIME_TXT])=0 THEN 0 ELSE 1 END AS [DOTDTL_WEDNESDAY], 
	CASE WHEN CHARINDEX('DW4',ACT_DOT.[EFFECTIVETIME_TXT])=0 THEN 0 ELSE 1 END AS [DOTDTL_THURSDAY], 
	CASE WHEN CHARINDEX('DW5',ACT_DOT.[EFFECTIVETIME_TXT])=0 THEN 0 ELSE 1 END AS [DOTDTL_FRIDAY], 
	ACT_DOT.EFFECTIVETIME_BEG AS DOTDTL_DATEBEGUN,
	ACT_DOT.EFFECTIVETIME_END AS DOTDTL_DATECOMPLETED,ACT_DOT.EFFECTIVETIME_DUR AS DOTDTL_WEEKS,
	CMN_CASEMGR.NAMECOMBINED AS DOTDTL_CASEMANAGER,ATTRIBUTE_CASEMGR.VALUESTRING AS DOTDTL_CMINITIALS,
	CMN_CASEMGR.FULLNAME AS DOTDTL_CMLICENSE,
	[DBO].[MDF_ATTR_GETDATEVALUE_ACTATTR_BYACTID](ACT_DOT.ID,'VALUETSEND','DOTDTL_DATEENDED') AS DOTDTL_DATEENDED,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDTL_BEGINACUITYLEFT_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDTL_BEGINACUITYLEFT,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDTL_BEGINACUITYRIGHT_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDTL_BEGINACUITYRIGHT,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDTL_BEGINACUITYBOTH_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDTL_BEGINACUITYBOTH,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDTL_BEGINCOLORVISION_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDTL_BEGINCOLORVISION,
	DBO.[MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETACLASSVALUETYPE]('DOTDTL_BEGINWEIGHT',ACT_DOT.ID,'VALUENUMERATOR') AS DOTDTL_BEGINWEIGHT,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDTL_BEGINHEARINGLEFT_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDTL_BEGINHEARINGLEFT,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDTL_BEGINHEARINGRIGHT_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDTL_BEGINHEARINGRIGHT,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDTL_BEGINBALANCE_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDTL_BEGINBALANCE,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDTL_BEGINLIVERFUNCTION_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDTL_BEGINLIVERFUNCTION,
	ACT_DOT.ACTIVITYTIME_END AS DOTDTL_ESTIMATEDCOT
FROM 
	DV_SERVICE DVSVC (NOLOCK)
	INNER JOIN A_ACT DOCBODY (NOLOCK) ON DOCBODY.ACT_PARENT_ID=DVSVC.DVSVC_ROWID AND DOCBODY.CLASSCODE='DOCBODY' 
	INNER JOIN A_ACT ACT_DOT (NOLOCK) ON ACT_DOT.ACT_PARENT_ID=DOCBODY.ID AND ACT_DOT.CLASSCODE='ENC' AND ACT_DOT.MOODCODE='INT' 
	AND ACT_DOT.METACODE='DOTDTL_ID' 
	LEFT JOIN [ATLASINTERNAL].[VIEW_CMN_PARTICIPATION_ROLE_ENTITY] CMN_CASEMGR  (NOLOCK) ON CMN_CASEMGR.ACT_ID=ACT_DOT.ID
	LEFT JOIN T_ATTRIBUTE ATTRIBUTE_CASEMGR  (NOLOCK) ON ATTRIBUTE_CASEMGR.ROLE_ID=CMN_CASEMGR.ROLEID AND ATTRIBUTE_CASEMGR.NAME='USER_INITIALS'
