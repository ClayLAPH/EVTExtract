﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_TUBERCULOSIS_CXR]
AS
SELECT
	VIEW_SUB_REFTUB.PATIENT_FK AS CXRHIST_PATIENT_FK,
	VIEW_SUB_REFTUB.SERVICE_FK AS CXRHIST_SERVICE_FK,
	VIEW_SUB_REFTUB.ACT_ID AS CXRHIST_ID,

	VIEW_SUB_REFTUB.ACT_EFFECTIVETIME_BEG AS CXRHIST_DATE,
	[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](A_OBSERVATION.INTERPRETATIONCODE_ID) AS CXRHIST_CXRRESULT,
	[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](VIEW_SUB_REFTUB.ACT_VALUECODE_ID) AS CXRHIST_CXRTYPE,
	[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](TVAL_CXRCOND.VALUECODE_ID) AS CXR_CONDITION,
	DBO.[MDF_ACT_GETDATEVALUE_ACTRELSRCACT_BYTRGACTIDMETACLASSMOODTYPEVALUETYPE](VIEW_SUB_REFTUB.ACT_ID, 'CXRHIST_NEXTDUEDATE', 'SEQL', 'EFFECTIVETIME_BEG') AS CXRHIST_NEXTDUEDATE,
	VIEW_SUB_REFTUB.ACT_TEXT AS CXRHIST_COMMENTS, 
	[DBO].[MDF_ATTR_GETSTRINGVALUE_ACTATTR_BYACTID](VIEW_SUB_REFTUB.ACT_ID, 'VALUESTRING', 'CXRHIST_WHERE') AS CXRHIST_WHERE
FROM   
	DBO.A_OBSERVATION (NOLOCK) 
	INNER JOIN [ATLASINTERNAL].[VIEW_SUB_REFERRAL_TUBERCULOSIS] VIEW_SUB_REFTUB ON VIEW_SUB_REFTUB.ACT_ID = A_OBSERVATION.ID 
				AND VIEW_SUB_REFTUB.ACT_CLASSCODE = 'OBS' AND VIEW_SUB_REFTUB.ACT_METACODE = 'CXRHIST_ID' 
	LEFT JOIN DBO.T_VALUE TVAL_CXRCOND (NOLOCK) ON  TVAL_CXRCOND.ACT_ID = VIEW_SUB_REFTUB.ACT_ID AND TVAL_CXRCOND.[TYPE] = 'CV' AND TVAL_CXRCOND.METACODE = 'CXRHIST_CXRCONDITION_FK'
	