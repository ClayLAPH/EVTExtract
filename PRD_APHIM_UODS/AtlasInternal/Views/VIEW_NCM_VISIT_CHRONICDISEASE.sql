﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_NCM_VISIT_CHRONICDISEASE]
AS
SELECT 
	ACT_VISITDETAIL.ID AS VISITDTL_ID,
	ACT_CHDIS.ID AS CHDIS_ID,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CHDIS_CHRONICDISEASE', ACT_CHDIS.ID , 'VALUEBOOL') AS CHDIS_CHRONICDISEASE,
	DBO.MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETACLASSVALUETYPE('CHDIS_BLOODGLUCOSE', ACT_CHDIS.ID , 'VALUENUMERATOR') AS CHDIS_BLOODGLUCOSE,
	DBO.MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETACLASSVALUETYPE('CHDIS_A1C', ACT_CHDIS.ID , 'VALUENUMERATOR') AS CHDIS_A1C,
	DBO.MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETACLASSVALUETYPE('CHDIS_BLOODCHOLESTEROL',ACT_CHDIS.ID , 'VALUENUMERATOR') AS CHDIS_BLOODCHOLESTEROL,
	DBO.MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETACLASSVALUETYPE('CHDIS_HDL', ACT_CHDIS.ID , 'VALUEDENOMINATOR') AS CHDIS_HDL,
	DBO.MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETACLASSVALUETYPE('CHDIS_LDL', ACT_CHDIS.ID , 'VALUENUMERATOR')  AS CHDIS_LDL,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CHDIS_LUNGPEAKFLOWDELTALESS10', ACT_CHDIS.ID , 'VALUEBOOL')  AS CHDIS_LUNGPEAKFLOWDELTALESS10,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CHDIS_LUNGPEAKFLOWVALUEMORE80', ACT_CHDIS.ID , 'VALUEBOOL') AS CHDIS_LUNGPEAKFLOWVALUEMORE80,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CHDIS_LUNGFORCEDEXPVOLMORE80', ACT_CHDIS.ID , 'VALUEBOOL') AS CHDIS_LUNGFORCEDEXPVOLMORE80,
	DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CHDIS_LUNGUSEINHALERORMEDS', ACT_CHDIS.ID , 'VALUEBOOL') AS CHDIS_LUNGUSEINHALERORMEDS,
	ACT_CHDIS.TEXT AS CHDIS_COMMENTS
FROM 
	A_ACT ACT_CHDIS (NOLOCK) 
	INNER JOIN A_ACT ACT_VISITDETAIL (NOLOCK) ON ACT_VISITDETAIL.ID=ACT_CHDIS.ACT_PARENT_ID AND ACT_VISITDETAIL.CLASSCODE='ENC' 
WHERE 
	ACT_CHDIS.METACODE='CHDIS_ID' AND ACT_CHDIS.STATUSCODE='ACTIVE'
