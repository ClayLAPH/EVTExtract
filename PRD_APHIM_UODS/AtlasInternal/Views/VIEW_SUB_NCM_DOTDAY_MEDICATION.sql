﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_SUB_NCM_DOTDAY_MEDICATION]
AS
SELECT 
	ACT_DOT.ID,
	ACT_MED.METACODE,
	ATTR_MED_PERBW.[NAME],
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(ACT_MED.CODE_ID) AS DOTDAY_MED,
	ACT_MED.EFFECTIVETIME_END,
	SUBADM_MED.DOSEQUANTITY_LO,
	SUBADM_MED.DOSEQUANTITY_ALT_HI,
	SUBADM_MED.DOSECHECKQUANTITY_NMR,
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(ACT_MED.EFFECTIVETIME_FRQ_ID) AS DOTDAY_MEDFREQ,
	ATTR_MED_PERBW.VALUEBOOL,
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(RES_MED.REASONCODE_ID) AS DOTDAY_MEDREASONSTOPPED,
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(SUBADM_MED.ROUTECODE_ID) AS DOTDAY_MEDROUTE,
	DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(SUBADM_MED.DOSEQUANTITY_ALT_UNIT_ID) AS DOTDAY_MEDUNIT,
	CASE ACT_MED.STATUSCODE WHEN 'COMPLETED' THEN 1 WHEN 'HELD' THEN 0 ELSE NULL END AS DOTDAY_MEDWASTAKEN
FROM  
	A_ACT ACT_DOT (NOLOCK) 
	INNER JOIN A_ACT ACT_MED (NOLOCK) ON  ACT_MED.[ACT_PARENT_ID] = ACT_DOT.ID AND ACT_MED.CLASSCODE='SBADM' AND ACT_MED.METACODE LIKE 'DOTDAY_MED%' 
	INNER JOIN A_SUBSTANCEADMINISTRATION SUBADM_MED (NOLOCK) ON  SUBADM_MED.[ID] = ACT_MED.[ID] 
	LEFT JOIN T_ACTREASON RES_MED (NOLOCK) ON  RES_MED.ACT_ID = ACT_MED.[ID]
	LEFT JOIN T_ATTRIBUTE ATTR_MED_PERBW (NOLOCK) ON  ATTR_MED_PERBW.ACT_ID = ACT_MED.[ID] AND ATTR_MED_PERBW.[NAME] LIKE 'DOTDAY_MED%'
WHERE
	ACT_DOT.CLASSCODE='ENC' AND ACT_DOT.METACODE='DOTDAY_ID' 
