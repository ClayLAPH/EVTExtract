﻿
CREATE VIEW [AtlasInternal].[VIEW_NCM_Sub_PatientData_PatientData]
AS
WITH CTE_SSNOID(SSNOID)
AS
(
	SELECT dbo.FN_GetSSNOIDBasedOnSiteID(CAST((CASE WHEN VAL.value='' THEN CONFIG.defaultvalue ELSE VAL.value END) AS VARCHAR(20))) 
	FROM S_CONFIGDEFINITION (nolock)CONFIG
	INNER JOIN S_CONFIGVALUE(nolock) VAL ON VAL.configdefinition_id = CONFIG.id
	WHERE CONFIG.[KEY]='SITEID'
)
SELECT   
 DVPER.DVPER_RowID AS [PAT_ID],  
 DVPER.DVPER_NCMID AS [PAT_NCMid],  
 DVPER.DVPER_FirstName AS [PAT_FirstName],  
 DVPER.DVPER_LastName AS [PAT_LastName],  
 DVPER.DVPER_SSN AS [PAT_SS],  
 DVPER.DVPER_StreetAddress AS [PAT_Address],  
 DVPER.DVPER_City AS [PAT_City],  
 DVPER.DVPER_State AS [PAT_State],  
 DVPER.DVPER_ZIP AS [PAT_Zip],  
 DVPER.DVPER_DOB AS [PAT_DOB],  
 DVPER.DVPER_HomePhone AS [PAT_HomePhone],
 DVPER_SexCode_ID as DVPER_SexCode_ID,
 DVPER_RaceCode_ID as DVPER_RaceCode_ID,
 DVPER_EthnicityCode_ID as DVPER_EthnicityCode_ID,
 ENTNAME_PATNAME.PARTMID AS [PAT_MIDDLENAME],
 ENTNAME_PATNAME.PARTSFX AS [PAT_NAMESUFFIX],
 [DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](INSTANCEIDENT.STATUSCODE_ID) AS [PAT_SSSTAT]
FROM   
 dbo.DV_PERSON DVPER (NOLOCK)
INNER JOIN DBO.T_ENTITYNAME ENTNAME_PATNAME (NOLOCK) ON ENTNAME_PATNAME.ENTITY_ID=DVPER.DVPER_RowID AND ENTNAME_PATNAME.USECODE='L'
INNER JOIN CTE_SSNOID ON 1=1
LEFT JOIN DBO.T_INSTANCEIDENTIFIER INSTANCEIDENT (NOLOCK) ON INSTANCEIDENT.ENTITY_ID=DVPER.DVPER_RowID AND INSTANCEIDENT.[ROOT]=CTE_SSNOID.SSNOID
