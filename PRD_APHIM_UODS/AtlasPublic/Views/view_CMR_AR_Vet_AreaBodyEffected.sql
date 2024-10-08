﻿
CREATE VIEW [AtlasPublic].[view_CMR_AR_Vet_AreaBodyEffected]    
AS      
SELECT
AI_ROWID AS AI_ABE_ANIMALROWID,
AI_ANIMALREPORTID AS AI_ABE_ANIMALID,
UCSANMBODYEFF.FULLNAME AS AI_ABE_AREABODYEFF
FROM A_ACT ACTANMBODYEFF (NOLOCK)
INNER JOIN [AtlasInternal].[VIEW_CMR_AR_VET_CHILDACTTOPIC] (NOLOCK) ON AI_VET_ACTTOPIC=ACTANMBODYEFF.ACT_PARENT_ID AND ACTANMBODYEFF.METACODE='ARABA_ROWID'  AND ACTANMBODYEFF.STATUSCODE='ACTIVE'
INNER JOIN A_OBSERVATION OBSBODYEFF (NOLOCK) ON OBSBODYEFF.ID = ACTANMBODYEFF.ID
INNER JOIN V_UNIFIEDCODESET UCSANMBODYEFF  (NOLOCK) ON UCSANMBODYEFF.ID=OBSBODYEFF.TARGETSITECODE_ID 


