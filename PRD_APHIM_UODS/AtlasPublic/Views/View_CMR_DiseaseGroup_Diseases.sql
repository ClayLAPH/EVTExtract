﻿
Create View AtlasPublic.View_CMR_DiseaseGroup_Diseases
As
select DSGRP_UCS.ID AS DISGRP_RowID, DSGRP_UCS.fullName AS DISGRP_Name, DSGRP_TERM.active AS DISGRP_Active,DS_UCS.ID AS DISGRP_Disease_ID, DS_UCS.fullName AS DISGRP_Disease_Name,DS_TERM.active AS  DISGRP_Disease_Active
FROM V_UnifiedCodeSet DSGRP_UCS (NOLOCK)
INNER JOIN V_Domain DSGRP_DOMAIN (NOLOCK) ON DSGRP_DOMAIN.ID=DSGRP_UCS.domain_ID AND DSGRP_DOMAIN.domainName='DiseaseGroup'
INNER JOIN V_TermDictionary DSGRP_TERM (NOLOCK) ON DSGRP_TERM.termCode_ID=DSGRP_UCS.ID AND DSGRP_TERM.name='DISEASEGROUP'
INNER JOIN V_CodeProperty DSGRP_CP (NOLOCK) ON DSGRP_CP.subjCode_ID=DSGRP_UCS.ID and DSGRP_CP.property='GRPD_DiseaseDR'
INNER JOIN V_UnifiedCodeSet DS_UCS (NOLOCK) ON DS_UCS.ID=DSGRP_CP.valueCode_ID
INNER JOIN V_Domain DS_DOMAIN (NOLOCK) ON DS_DOMAIN.ID=DS_UCS.domain_ID AND DS_DOMAIN.domainName='CdIllness'
INNER JOIN V_TermDictionary DS_TERM (NOLOCK) ON DS_TERM.termCode_ID=DS_UCS.ID AND DS_TERM.name='DISEASE'