﻿CREATE VIEW [AtlasInternal].[VIEW_NCM_VISIT_CURRENT_PLAN]
AS 

SELECT	
	VW_PATFOLDER.PATIENT_ID AS VISITPLAN_PATIENT_ID,
	ACT_VISITPLAN.ID AS VISITPLAN_ID,
	ACT_VISITPLAN.TEXT AS VISITPLAN_CURRENTPLAN
FROM
	A_ACT ACT_VISITPLAN (NOLOCK)
	INNER JOIN A_ACT ACT_DOCBODY (NOLOCK) ON ACT_DOCBODY.ID=ACT_VISITPLAN.ACT_PARENT_ID AND ACT_DOCBODY.CLASSCODE='DOCBODY' 
	INNER JOIN VIEW_CMN_PATIENTFOLDER VW_PATFOLDER (NOLOCK) ON VW_PATFOLDER.ACT_FOLDER_ID=ACT_DOCBODY.ACT_PARENT_ID
WHERE  
	ACT_VISITPLAN.METACODE='PLAN_ID'

