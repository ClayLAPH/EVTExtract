﻿
CREATE VIEW  [AtlasPublic].[VIEW_CMR_AR_VET_VACCINATION]
AS
SELECT  
	ARACT.ID AS AI_VACC_ANIMALROWID, 
	TOPIC.AI_AnimalReportID AS AI_VACC_ANIMALID, 
	ARACT.effectiveTime_Beg AS AI_DATEOFVACCINATION, 
	dbo.FN_GetUCSFullName(ARACT.code_ID) AS AI_VACCINATION, 
	ARACT.[text] AS AI_VACCINATIONCOMMENT
FROM  [AtlasInternal].VIEW_CMR_AR_Vet_ChildActTopic TOPIC
	INNER JOIN A_Act ARACT(nolock) ON ARACT.ACT_PARENT_ID= TOPIC.AI_VET_ACTTOPIC AND ARACT.classCode='SBADM' AND ARACT.moodCode='EVN' AND ARACT.metaCode='ARV_ROWID' AND ARACT.statusCode = 'active'
