﻿	
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_VISIT_INTERVENTION_LIST]
AS
SELECT  
	ACT_VISITDETAIL.ID AS VISITDTL_ID,
	ACT_INTERVENTIONLIST.ID AS INETERVENTION_ID,
	DBO.MDF_UCS_FULLNAME_ATTRUCS_BYACTID(ACT_INTERVENTIONLIST.ID ,'VALUECODE_ID','INTALL_INTERVENTION_FK') AS INTERVENTIONLIST_INTERVENTION,
	DBO.MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID('INTALL_INTERVENTIONCATEGORY_FK',ACT_INTERVENTIONLIST.ID,'VALUECODE_ID') AS INTERVENTIONLIST_INTERVENTIONCATEGORY,
	ACT_INTERVENTIONLIST.ACTIVITYTIME_BEG AS INTERVENTIONLIST_DATEPLANNED,
	ACT_INTERVENTIONLIST.EFFECTIVETIME_BEG AS INTERVENTIONLIST_DATEINTERVENED,
	DBO.MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID('INTALL_ASSOCSERVICE_FK',ACT_INTERVENTIONLIST.ID,'VALUECODE_ID') AS INTERVENTIONLIST_ASSOCIATEDSERVICE,
	DBO.MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID('INTALL_ASSOCCONCERN_FK',ACT_INTERVENTIONLIST.ID,'VALUECODE_ID') AS INTERVENTIONLIST_ASSOCIATEDCONCERN,
	ACT_INTERVENTIONLIST.TEXT AS INTERVENTIONLIST_INTERVENTIONDETAILS,
	ACT_INTERVENTIONFOLLOWUP.TEXT AS INTERVENTIONLIST_INTERVENTIONFOLLOWUP,
	ACT_INTERVENTIONFOLLOWUP.EFFECTIVETIME_BEG AS INTERVENTIONLIST_INTERVENTIONFOLLOWUPDATE,
	DBO.MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID('INTALL_DISPOSITION_FK',ACT_INTERVENTIONLIST.ID,'VALUECODE_ID') AS INTERVENTIONLIST_DISPOSITION
FROM
	A_ACT ACT_INTERVENTIONLIST (NOLOCK) 
	INNER JOIN A_ACT ACT_VISITDETAIL (NOLOCK) ON ACT_VISITDETAIL.ID=ACT_INTERVENTIONLIST.ACT_PARENT_ID AND ACT_VISITDETAIL.CLASSCODE='ENC' 
	LEFT JOIN A_ACT ACT_INTERVENTIONFOLLOWUP (NOLOCK) ON ACT_INTERVENTIONLIST.ID=ACT_INTERVENTIONFOLLOWUP.ACT_PARENT_ID AND ACT_INTERVENTIONFOLLOWUP.METACODE='INTALL_FOLLOWUP'
WHERE 
	ACT_INTERVENTIONLIST.METACODE='INTALL_ID' 