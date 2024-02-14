﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_VISIT_SAFESEX]
AS
SELECT 
	ACT_VISITDETAIL.ID AS VISITDTL_ID,ACT_SAFESEX.ID AS SAFESEX_ID,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('SAFESEX_SAFERSEX', ACT_SAFESEX.ID, 'VALUEBOOL') AS SAFESEX_SAFERSEX,
	DBO.MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID('SAFESEX_STD_FK',ACT_SAFESEX.ID,'VALUECODE_ID') AS SAFESEX_STD,
	DBO.MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID('SAFESEX_HXORCURRENT_FK',ACT_SAFESEX.ID,'VALUECODE_ID') AS SAFESEX_HXORCURRENT,
	DBO.MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID('SAFESEX_TBHXORCURRENT_FK',ACT_SAFESEX.ID,'VALUECODE_ID') AS SAFESEX_TBHXORCURRENT,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('SAFESEX_SEXUALLYACTIVE', ACT_SAFESEX.ID, 'VALUEBOOL') AS SAFESEX_SEXUALLYACTIVE,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('SAFESEX_UNPROTECTEDSEX', ACT_SAFESEX.ID, 'VALUEBOOL') AS SAFESEX_UNPROTECTEDSEX,
	DBO.MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID('SAFESEX_SEXUALSTATUS_FK',ACT_SAFESEX.ID,'VALUECODE_ID') AS SAFESEX_SEXUALSTATUS,
	DBO.MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID('SAFESEX_SEXUALIDENTITY_FK',ACT_SAFESEX.ID,'VALUECODE_ID') AS SAFESEX_SEXUALIDENTITY
FROM 
	A_ACT ACT_SAFESEX (NOLOCK) 
	INNER JOIN A_ACT ACT_VISITDETAIL (NOLOCK) ON ACT_VISITDETAIL.ID=ACT_SAFESEX.ACT_PARENT_ID AND ACT_VISITDETAIL.CLASSCODE='ENC'
WHERE 
	ACT_SAFESEX.METACODE='SAFESEX_ID' AND ACT_SAFESEX.STATUSCODE='ACTIVE'