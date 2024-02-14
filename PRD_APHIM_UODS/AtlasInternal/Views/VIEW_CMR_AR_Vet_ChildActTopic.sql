﻿
Create View [AtlasInternal].[VIEW_CMR_AR_Vet_ChildActTopic] AS

 SELECT
 DV_AnimalReport.DVAI_RowID AS AI_ROWID,
 DV_AnimalReport.DVAI_AnimalReportID AS AI_AnimalReportID,
 ACTTOPIC.ID AS AI_VET_ACTTOPIC
 FROM DV_AnimalReport  (NOLOCK) 
 INNER JOIN A_Act ACTDOCBODY  (NOLOCK) ON ACTDOCBODY.Act_Parent_ID=DV_AnimalReport.DVAI_RowID AND  ACTDOCBODY.classCode='DOCBODY'
 INNER JOIN V_UnifiedCodeSet UCSFORMCODE  (NOLOCK) ON UCSFORMCODE.ID=ACTDOCBODY.code_ID AND UCSFORMCODE.conceptCode='InAnim'
 INNER JOIN A_Act ACTTOPIC  (NOLOCK) ON ACTTOPIC.Act_Parent_ID=ACTDOCBODY.ID  AND ACTTOPIC.statusCode='ACTIVE'
 INNER JOIN V_UnifiedCodeSet UCSTABCODE  (NOLOCK)ON UCSTABCODE.ID=ACTTOPIC.code_ID AND UCSTABCODE.conceptCode='ArVetr'

