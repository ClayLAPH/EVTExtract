﻿
CREATE VIEW [AtlasPublic].[View_CMR_DistrictGroup_Districts] AS

SELECT DISTGRP_UCS.ID AS [DSTGRP_RowID],
DISTGRP_UCS.fullName AS [DSTGRP_Name],
DISTGRP_TERM.active AS [DSTGRP_Active],
DIST_UCS.ID AS [DSTGRP_District_ID],
DIST_UCS.fullName AS [DSTGRP_District_Name], 
DIST_TERM.active AS [DSTGRP_District_Active]
FROM V_UnifiedCodeSet DISTGRP_UCS (NOLOCK)
INNER JOIN V_Domain DISTGRP_DOMAIN (NOLOCK) ON DISTGRP_DOMAIN.ID = DISTGRP_UCS.domain_ID AND DISTGRP_DOMAIN.domainName = 'DistrictGroup'
INNER JOIN V_TermDictionary DISTGRP_TERM (NOLOCK) ON DISTGRP_UCS.ID = DISTGRP_TERM.termCode_ID AND DISTGRP_TERM.name = 'DISTRICTGROUP'
INNER JOIN V_CodeProperty DISTGRP_VCP (NOLOCK) ON DISTGRP_VCP.subjCode_ID = DISTGRP_UCS.ID AND DISTGRP_VCP.property='GRPD_DistrictDR'
INNER JOIN V_UnifiedCodeSet DIST_UCS (NOLOCK) ON DIST_UCS.ID = DISTGRP_VCP.valueCode_ID
INNER JOIN V_Domain DIST_DOMAIN (NOLOCK) ON DIST_DOMAIN.ID = DIST_UCS.domain_ID AND DIST_DOMAIN.domainName = 'District'
INNER JOIN V_TermDictionary DIST_TERM (NOLOCK) ON DIST_UCS.ID = DIST_TERM.termCode_ID AND DIST_TERM.name = 'DISTRICT'

