﻿
CREATE VIEW [AtlasPublic].[VIEW_CMR_AR_Vet_SuspExpSource] AS
SELECT
AI_ROWID AS AI_SUSEXP_AnimalRowId,
AI_AnimalReportID AS AI_SUSEXP_AnimalID,
UCSSUSEXP.FULLNAME as AI_SUSEXP_SuspExpSource
FROM A_Act ACTSUSEXP (NOLOCK)
INNER JOIN [AtlasInternal].VIEW_CMR_AR_Vet_ChildActTopic ON AI_VET_ACTTOPIC=ACTSUSEXP.Act_Parent_ID
INNER JOIN V_UnifiedCodeSet UCSSUSEXP  (NOLOCK) ON UCSSUSEXP.ID=ACTSUSEXP.valueCode_ID WHERE ACTSUSEXP.metaCode='ARSES_RowID'  AND ACTSUSEXP.statusCode='ACTIVE'
