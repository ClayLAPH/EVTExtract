﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_VISIT_MENTALHEALTHSYMPTOM]
AS
SELECT 
	ACT_VISITDETAIL.ID AS VISITDTL_ID,
	ACT_MENTSX.ID AS MENTSX_ID,
	ACT_MENTSX.EFFECTIVETIME_BEG AS MENTSX_DATE,
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(ACT_MENTSX.CODE_ID) AS MENTSX_SYMPTOM,
	DBO.MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID('MENTSX_DIAGNOSISREPORT_FK',ACT_MENTSX.ID,'VALUECODE_ID') AS MENTSX_DIAGNOSISREPORT,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('MENTSX_INCOUNSELING', ACT_MENTSX.ID, 'VALUEBOOL') AS MENTSX_INCOUNSELING,ACT_MENTSX.TEXT AS MENTSX_COMMENTS
FROM 
	A_ACT ACT_MENTSX (NOLOCK) 
	INNER JOIN A_ACT ACT_VISITDETAIL (NOLOCK) ON ACT_VISITDETAIL.ID=ACT_MENTSX.ACT_PARENT_ID AND ACT_VISITDETAIL.CLASSCODE='ENC' 
WHERE 
	ACT_MENTSX.METACODE='MENTSX_ID' AND ACT_MENTSX.STATUSCODE='ACTIVE'
