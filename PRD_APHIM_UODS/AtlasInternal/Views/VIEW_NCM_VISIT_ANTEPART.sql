﻿CREATE VIEW [AtlasInternal].[VIEW_NCM_VISIT_ANTEPART]
AS
SELECT 
	ACT_VISITDETAIL.ID AS VISITDTL_ID,
	ACT_ANTEPART.ID AS ANTEPART_ID, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_ANTEPARTUM',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_ANTEPARTUM,
	DBO.[MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE]('PERIHIST_GRAVIDA',ACT_ANTEPART.ID,'VALUEINTEGER')  AS ANTEPART_GRAVIDA, 
	DBO.[MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_PARA',ACT_ANTEPART.ID,'VALUEINTEGER') AS ANTEPART_PARA, 
	DBO.[MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_AB',ACT_ANTEPART.ID,'VALUEINTEGER')  AS ANTEPART_AB,
	DBO.[MDF_ACT_GETDATETIMEVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_EDC',ACT_ANTEPART.ID,'VALUETS') AS ANTEPART_EDC, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_PLANNEDPREGNANCY',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_PLANNEDPREGNANCY, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_PNC',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_PNC, 
	DBO.[MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_TRIMESTER_FK',ACT_ANTEPART.ID,'VALUECODE_ID') AS ACT_ANTEPART_TRIMESTER_FK,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('ANTEPART_TRIMESTER_FK',ACT_ANTEPART.ID,'VALUECODE_ID')AS ANTEPART_TRIMESTER_TEXT,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_TAKINGVITAMINS',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_TAKINGVITAMINS, 
	DBO.[MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_WEIGHTGAIN_FK',ACT_ANTEPART.ID,'VALUECODE_ID') AS ANTEPART_WEIGHTGAIN_FK,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('ANTEPART_WEIGHTGAIN_FK',ACT_ANTEPART.ID,'VALUECODE_ID')AS ANTEPART_WEIGHTGAIN_TEXT,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_EDEMA',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_EDEMA, 
	DBO.[MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_EDEMA',ACT_ANTEPART.ID,'VALUECODE_ID') AS ANTEPART_EDEMAPLUS_FK,
	DBO.[MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID]('ANTEPART_EDEMA',ACT_ANTEPART.ID,'VALUECODE_ID')AS ANTEPART_EDEMAPLUS_TEXT,
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_LEGCRAMPS',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_LEGCRAMPS, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_PAINWVOIDING',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_PAINWVOIDING, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_PIHSS',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_PIHSS, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_NAUSEAVOMIT',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_NAUSEAVOMIT, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_CONSTIPATION',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_CONSTIPATION, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_PLANBREASTFEED',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_PLANBREASTFEED, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_HEARTBURN',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_HEARTBURN, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_HEADACHE',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_HEADACHE, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_PRENATALCLASS',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_PRENATALCLASS, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_PARENTCLASS',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_PARENTCLASS, 
	DBO.[MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE]('ANTEPART_BIRTHPREPAREDNESS',ACT_ANTEPART.ID,'VALUEBOOL') AS ANTEPART_BIRTHPREPAREDNESS    
FROM 
	A_ACT ACT_ANTEPART (NOLOCK)
	INNER JOIN A_ACT ACT_VISITDETAIL (NOLOCK) ON ACT_VISITDETAIL.ID=ACT_ANTEPART.ACT_PARENT_ID AND ACT_VISITDETAIL.CLASSCODE='ENC'
WHERE 
	ACT_ANTEPART.METACODE='ANTEPART_ID'

