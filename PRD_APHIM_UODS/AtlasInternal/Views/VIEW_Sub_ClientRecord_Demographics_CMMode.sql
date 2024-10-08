﻿
Create VIEW [AtlasInternal].[VIEW_Sub_ClientRecord_Demographics_CMMode]
AS
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
 DVPER.DVPER_CellPhone AS [PAT_CellPhone],
 DVPER.DVPER_WorkSchoolPhone AS [PAT_WorkSchoolPhone], 
DVPER_SexCode_ID as DVPER_SexCode_ID,
DVPER_RaceCode_ID as DVPER_RaceCode_ID,
DVPER_EthnicityCode_ID as DVPER_EthnicityCode_ID,
DVPER_CreateDate as DVPER_Create_Date,
ENTNAME_PATNAME.PARTMID AS [PAT_MIDDLENAME],
ENTNAME_PATNAME.PARTSFX AS [PAT_NAMESUFFIX],
DVPER.DVPER_MaritalStatusCode_ID AS [DVPER_MaritalStatusCode_ID]

FROM 
    dbo.DV_PERSON DVPER (NOLOCK)
    INNER JOIN S_Link (NOLOCK) LINK ON LINK.Entity1_ID=DVPER.DVPER_RowID AND LINK.name='PERSON-PRIMARY'
    INNER JOIN DBO.T_ENTITYNAME ENTNAME_PATNAME (NOLOCK) ON ENTNAME_PATNAME.ENTITY_ID=LINK.Entity2_ID AND ENTNAME_PATNAME.USECODE='L'
