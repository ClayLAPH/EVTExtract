﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_DOT_DAYDATA]
AS
SELECT 
	DAYSUM.*,
	ACT_DOTDETAIL.[ID] AS DOTDAY_DOTDETAIL_FK,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDAY_ACUITYBOTH_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDAY_ACUITYBOTH,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDAY_ACUITYLEFT_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDAY_ACUITYLEFT,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDAY_ACUITYRIGHT_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDAY_ACUITYRIGHT,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDAY_ADVERSEREACTION_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDAY_ADVERSEREACTION,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDAY_BALANCE_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDAY_BALANCE,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDAY_COLORVISION_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDAY_COLORVISION,
	ACT_DOT.[TEXT] AS DOTDAY_COMMENTS,ACT_DOT.EFFECTIVETIME_BEG AS DOTDAY_DATE,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('DOTDAY_CONTACTS',ACT_DOT.ID,'VALUEBOOL') AS DOTDAY_CONTACTS,
	DBO.[MDF_UCS_FULLNAME_ACTOBSERVATION_BYPARENTACTID](ACT_DOT.ID,'INTERPRETATIONCODE_ID','DOTDAY_CULTURE_FK') AS DOTDAY_CULTURE,
	DBO.[MDF_UCS_FULLNAME_ACTOBSERVATION_BYPARENTACTID](ACT_CULTURE.ID,'INTERPRETATIONCODE_ID','DOTDAY_SMEAR_FK') AS DOTDAY_SMEAR,
	DBO.[MDF_UCS_FULLNAME_ACTOBSERVATION_BYPARENTACTID](ACT_DOT.ID,'INTERPRETATIONCODE_ID','DOTDAY_CXR_FK') AS DOTDAY_CXR,
	ACTREL_DOTDETAIL.SEQUENCENUMBER AS DOTDAY_DAYNUMBER,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('DOTDAY_DEPRESSED',ACT_DOT.ID,'VALUEBOOL') AS DOTDAY_DEPRESSED,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('DOTDAY_ETHO',ACT_DOT.ID,'VALUEBOOL') AS DOTDAY_ETHO,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('DOTDAY_GLASSES',ACT_DOT.ID,'VALUEBOOL') AS DOTDAY_GLASSES,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('DOTDAY_HEPATITIS',ACT_DOT.ID,'VALUEBOOL') AS DOTDAY_HEPATITIS,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('DOTDAY_HIVPOSITIVE',ACT_DOT.ID,'VALUEBOOL') AS DOTDAY_HIVPOSITIVE,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('DOTDAY_IMMUNECOMPROMISED',ACT_DOT.ID,'VALUEBOOL') AS DOTDAY_IMMUNECOMPROMISED,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('DOTDAY_PREGNANT',ACT_DOT.ID,'VALUEBOOL') AS DOTDAY_PREGNANT,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDAY_HEARINGLEFT_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDAY_HEARINGLEFT,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDAY_HEARINGRIGHT_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDAY_HEARINGRIGHT,
	ATTRIBUTE_CASEMGR.VALUESTRING AS DOTDAY_INITIALS,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('DOTDAY_LIVERFUNCTION_FK',ACT_DOT.ID,'VALUECODE_ID') AS DOTDAY_LIVERFUNCTION,
	ENT_SPUT.QUANTITY AS DOTDAY_SPUTUMS,
	DBO.[MDF_UCS_FULLNAME_ACTUCS_BYACTID](ACT_DOT.ID,'CODE_ID') AS DOTDAY_THERAPY,ACT_DOT.EFFECTIVETIME_DUR AS DOTDAY_TIME,
	DBO.[MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETACLASSVALUETYPE]('DOTDAY_BEGINWEIGHT',ACT_DOT.ID,'VALUENUMERATOR') AS DOTDAY_BEGINWEIGHT
	
FROM   
	A_ACT ACT_DOT (NOLOCK) 
	INNER JOIN A_ACTRELATIONSHIP ACTREL_DOTDETAIL (NOLOCK)ON  ACTREL_DOTDETAIL.SOURCE_ID = ACT_DOT.[ID] AND ACTREL_DOTDETAIL.TYPECODE = 'OCCR' 
	INNER JOIN A_ACT ACT_DOTDETAIL (NOLOCK) ON  ACTREL_DOTDETAIL.TARGET_ID = ACT_DOTDETAIL.[ID] AND ACT_DOTDETAIL.METACODE = 'DOTDTL_ID' 
	LEFT JOIN [ATLASINTERNAL].[VIEW_CMN_PARTICIPATION_ROLE_ENTITY] CMN_CASEMGR  (NOLOCK) ON CMN_CASEMGR.ACT_ID=ACT_DOT.ID
	LEFT JOIN T_ATTRIBUTE ATTRIBUTE_CASEMGR  (NOLOCK) ON ATTRIBUTE_CASEMGR.ROLE_ID=CMN_CASEMGR.ROLEID AND ATTRIBUTE_CASEMGR.NAME='USER_INITIALS'
	--THIS IS NEEDED FOR SMEAR
	LEFT JOIN DBO.A_ACT ACT_CULTURE (NOLOCK) ON ACT_CULTURE.ACT_PARENT_ID = ACT_DOT.[ID] AND ACT_CULTURE.METACODE='DOTDAY_CULTURE_FK'
	LEFT JOIN P_PARTICIPATION PART_SPUT (NOLOCK) ON PART_SPUT.ACT_ID = ACT_CULTURE.[ID] AND PART_SPUT.TYPECODE = 'SPC'
	LEFT JOIN R_ROLE ROLE_SPUT (NOLOCK) ON ROLE_SPUT.ID = PART_SPUT.ROLE_ID AND ROLE_SPUT.CLASSCODE = 'SPEC' 
	LEFT JOIN E_ENTITY ENT_SPUT (NOLOCK) ON ENT_SPUT.ID= ROLE_SPUT.PLAYER_ID AND ENT_SPUT.CLASSCODE='MAT'
	LEFT JOIN [ATLASINTERNAL].[VIEW_NCM_DOT_DAYSUMMARY] DAYSUM (NOLOCK) ON DAYSUM.DOTDAY_ID = ACT_DOT.ID
WHERE
	ACT_DOT.METACODE = 'DOTDAY_ID'
