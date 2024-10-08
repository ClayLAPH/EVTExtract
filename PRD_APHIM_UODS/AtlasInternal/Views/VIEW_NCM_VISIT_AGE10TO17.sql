﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_VISIT_AGE10TO17]
AS
SELECT 
	ACT_VISITDETAIL.ID AS VISITDTL_ID,
	ACT_AGE10X17.ID AS AGE10X17_ID,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('AGE10X17_AGE10TO17',ACT_AGE10X17.ID,'VALUEBOOL') AS AGE10X17_AGE10TO17,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('AGE10X17_LEARNDISABLED',ACT_AGE10X17.ID,'VALUEBOOL') AS AGE10X17_LEARNDISABLED,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('AGE10X17_LANGBARRIER',ACT_AGE10X17.ID,'VALUEBOOL') AS AGE10X17_LANGBARRIER,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('AGE10X17_CHILDSERVICES',ACT_AGE10X17.ID,'VALUEBOOL') AS AGE10X17_CHILDSERVICES,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('AGE10X17_REGIONCENTER',ACT_AGE10X17.ID,'VALUEBOOL') AS AGE10X17_REGIONCENTER,
	ACT_AGE10X17.TEXT AS AGE10X17_COMMENTS
FROM 
	A_ACT ACT_AGE10X17 (NOLOCK) 
	INNER JOIN A_ACT ACT_VISITDETAIL (NOLOCK) ON ACT_VISITDETAIL.ID=ACT_AGE10X17.ACT_PARENT_ID AND ACT_VISITDETAIL.CLASSCODE='ENC'
WHERE 
	ACT_AGE10X17.METACODE='AGE10X17_ID'
