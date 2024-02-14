﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_VISIT_ACTIVITYCODE]
AS
SELECT 
	ACT_VISITDETAIL.ID AS VISITDTL_ID,
	ACT_ACTIVITYCODE.ID AS ACTCODE_ID,
	ACT_VISITDETAIL.EFFECTIVETIME_BEG AS ACTCODE_VISITDATE,
	ACT_ACTIVITYCODE.TITLE AS ACTCODE_ACTIVITYCODES,
	[DBO].[MDF_UCS_FULLNAME_ACTUCS_BYACTID](ACT_ASSOSVC.ID,'VALUECODE_ID') AS ACTCODE_ASSOCSERVICE
FROM 
	A_ACT ACT_ACTIVITYCODE (NOLOCK) 
	INNER JOIN A_ACT ACT_VISITDETAIL  (NOLOCK) ON ACT_VISITDETAIL.ID=ACT_ACTIVITYCODE.ACT_PARENT_ID AND ACT_VISITDETAIL.CLASSCODE='ENC' 
	LEFT JOIN A_ACT ACT_ASSOSVC (NOLOCK) ON ACT_ASSOSVC.ACT_PARENT_ID=ACT_ACTIVITYCODE.ID AND ACT_ASSOSVC.METACODE='ACTCODE_ASSOCSERVICE_FK' 
WHERE
	ACT_ACTIVITYCODE.METACODE='ACTCODE_ID' AND ACT_ACTIVITYCODE.STATUSCODE='ACTIVE'