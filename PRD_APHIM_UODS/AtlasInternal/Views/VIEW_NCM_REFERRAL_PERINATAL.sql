﻿CREATE VIEW [AtlasInternal].[VIEW_NCM_REFERRAL_PERINATAL]
AS
SELECT
	DBO.MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_LMP',APERHIST.ID,'VALUETS') AS PERIHIST_LMP,
	DBO.MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_EDD',APERHIST.ID,'VALUETS') AS PERIHIST_EDD,
	DBO.MDF_UCS_FULLNAME_ACTCHILDUCS_BYPARENTACTID('PERIHIST_TRIMESTERPNC_FK',APERHIST.ID,'VALUECODE_ID') AS PERIHIST_TRIMESTERPNC_TEXT,
	DBO.MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_GESTATIONALAGE',APERHIST.ID,'VALUENUMERATOR') AS PERIHIST_GESTATIONALAGE,
	DBO.MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_GRAVIDA',APERHIST.ID,'VALUEINTEGER') AS PERIHIST_GRAVIDA,
	DBO.MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_PARA',APERHIST.ID,'VALUEINTEGER') AS PERIHIST_PARA,
	DBO.MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_SAB',APERHIST.ID,'VALUEINTEGER') AS PERIHIST_SAB,
	DBO.MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_TAB',APERHIST.ID,'VALUEINTEGER') AS PERIHIST_TAB,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_HADNVD',APERHIST.ID,'VALUEBOOL') AS PERIHIST_HADNVD,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_HADCS',APERHIST.ID,'VALUEBOOL') AS PERIHIST_HADCS,
	DBO.MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_BIRTHWEIGHTLBS',APERHIST.ID,'VALUENUMERATOR') AS PERIHIST_BIRTHWEIGHTLBS,
	DBO.MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_BIRTHWEIGHTOZ',APERHIST.ID,'VALUENUMERATOR') AS PERIHIST_BIRTHWEIGHTOZ,
	DBO.MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_LENGTH',APERHIST.ID,'VALUENUMERATOR') AS PERIHIST_LENGTH,
	DBO.MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_HC',APERHIST.ID,'VALUENUMERATOR') AS PERIHIST_HC,
	DBO.MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_APGAR1',APERHIST.ID,'VALUEINTEGER') AS PERIHIST_APGAR1,
	DBO.MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_APGAR5',APERHIST.ID,'VALUEINTEGER') AS PERIHIST_APGAR5,
	DBO.MDF_ACT_GETINTEGERVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_APGAR10',APERHIST.ID,'VALUEINTEGER') AS PERIHIST_APGAR10,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_ISAODINVOLVED',APERHIST.ID,'VALUEBOOL') AS PERIHIST_ISAODINVOLVED,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_ISENTERINGAODTREATMENT',APERHIST.ID,'VALUEBOOL') AS PERIHIST_ISENTERINGAODTREATMENT,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('PERIHIST_WASAODTOXATBIRTH',APERHIST.ID,'VALUEBOOL') AS PERIHIST_WASAODTOXATBIRTH,
	DV_SERVICE.DVSVC_ROWID AS [SVC_ID],
	DV_SERVICE.DVSVC_PATIENT_FK AS [PAT_ID]
FROM 
	A_ACT APERHIST (NOLOCK)
	INNER JOIN A_ACT DOCBODY (NOLOCK) ON DOCBODY.ID=APERHIST.ACT_PARENT_ID AND DOCBODY.CLASSCODE='DOCBODY'
	INNER JOIN A_ACTRELATIONSHIP (NOLOCK) ON A_ACTRELATIONSHIP.TARGET_ID=DOCBODY.ID
	INNER JOIN DV_SERVICE (NOLOCK)ON DV_SERVICE.DVSVC_ROWID=A_ACTRELATIONSHIP.SOURCE_ID
WHERE
	APERHIST.METACODE='PERIHIST_ID' AND APERHIST.STATUSCODE='ACTIVE'
