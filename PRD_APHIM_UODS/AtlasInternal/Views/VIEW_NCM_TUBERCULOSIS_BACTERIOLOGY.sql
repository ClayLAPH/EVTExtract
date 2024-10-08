﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_TUBERCULOSIS_BACTERIOLOGY]
AS
SELECT 
	VIEW_SUB_REFTUB.PATIENT_FK AS BACTHIST_PATIENT_FK,
	VIEW_SUB_REFTUB.SERVICE_FK AS BACTHIST_SERVICE_FK,
	VIEW_SUB_REFTUB.ACT_ID AS BACTHIST_ID,
	
	VIEW_SUB_REFTUB.ACT_EFFECTIVETIME_BEG AS BACTHIST_DATE,
	[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](ENT_PLYR.CODE_ID) AS BACTHIST_SPECIMENTYPE,
	ENT_PLYR.QUANTITY AS BACTHIST_NUMBERTAKEN,
	[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](OBS_SMEAR.INTERPRETATIONCODE_ID) AS BACTHIST_SMEAR,
	[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](A_OBSERVATION.INTERPRETATIONCODE_ID) AS BACTHIST_CULTURE,
	[DBO].[MDF_ACT_GETDATEVALUE_ACTRELSRCACT_BYTRGACTIDMETACLASSMOODTYPEVALUETYPE](VIEW_SUB_REFTUB.ACT_ID, 'BACTHIST_NEXTDUEDATE', 'SEQL', 'EFFECTIVETIME_BEG') AS BACTHIST_NEXTDUEDATE,
	VIEW_SUB_REFTUB.ACT_TEXT AS BACTHIST_COMMENTS
FROM   
	DBO.A_OBSERVATION (NOLOCK) 
	INNER JOIN [ATLASINTERNAL].[VIEW_SUB_REFERRAL_TUBERCULOSIS] VIEW_SUB_REFTUB  (NOLOCK) ON VIEW_SUB_REFTUB.ACT_ID = A_OBSERVATION.ID 
				AND VIEW_SUB_REFTUB.ACT_CLASSCODE = 'OBS' AND VIEW_SUB_REFTUB.ACT_METACODE = 'BACTHIST_ID' 
	
	LEFT JOIN P_PARTICIPATION (NOLOCK) ON P_PARTICIPATION.ACT_ID = VIEW_SUB_REFTUB.ACT_ID AND P_PARTICIPATION.TYPECODE = 'SPC'
	LEFT JOIN R_ROLE (NOLOCK) ON R_ROLE.ID = P_PARTICIPATION.ROLE_ID AND R_ROLE.CLASSCODE = 'SPEC'  AND R_ROLE.CODE_ID = [DBO].[MDF_UCS_GETID_UCSVDOMAIN_BYDOMAINOIDCONCEPTCODE]('2.16.840.1.113883.5.111', 'P')

	LEFT JOIN E_ENTITY ENT_PLYR (NOLOCK) ON ENT_PLYR.ID = R_ROLE.PLAYER_ID AND ENT_PLYR.CLASSCODE = 'MAT'

	LEFT JOIN A_ACT ACT_BACTHIST (NOLOCK) ON ACT_BACTHIST.ACT_PARENT_ID = VIEW_SUB_REFTUB.ACT_ID AND ACT_BACTHIST.METACODE = 'BACTHIST_SMEAR_FK'	
	LEFT JOIN A_OBSERVATION OBS_SMEAR (NOLOCK) ON OBS_SMEAR.ID = ACT_BACTHIST.ID

