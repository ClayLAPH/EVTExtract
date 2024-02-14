
CREATE VIEW [AtlasPublic].[View_UODS_GetClientRecordAddonData]  
AS 
-- Get the Client Record Add On Section Data
-- Get the Normal Section and Shared Across Record Data
WITH CTE_PHDATEFIELDFORMAT(DATEFIELDFORMAT)
AS
(
    SELECT 
    CASE 
        WHEN ISNULL(VAL.Value,'')='' THEN CAST(CONFIG.defaultValue AS VARCHAR)
        ELSE CAST(VAL.Value AS VARCHAR)
    END AS DATEFIELDFORMAT
    FROM S_CONFIGDEFINITION (nolock)CONFIG
    INNER JOIN S_CONFIGVALUE(nolock) VAL ON VAL.configdefinition_id = CONFIG.id
    WHERE CONFIG.[KEY]='PHDateFieldFormat'
)
SELECT 
    PHCASE.ID AS [RECORD_ID],     
    PAT.player_ID AS [Client_ID],  
    NULL AS [FORM_INSTANCE_ID], 
    NULL [FORM_DEF_DR],    
    NULL AS [FORM_NAME],  
    NULL [FORM_SHOW_IN_CMR],    
    NULL [FORM_SHOW_IN_NCM] ,
    NULL AS [FORM_DESCRIPTION],  
    NULL AS [FORM_CREATEDATE] ,   
    UDSectionActID AS [SECTION_INSTANCE_ID],  
    Sec_ID AS [SECTION_DEF_DR],  
    UDSecName AS [SECTION_NAME],    
    (CASE WHEN (SELECT VTD.ACTIVE FROM V_TERMDICTIONARY VTD (NOLOCK) WHERE SectionID=VTD.TERMCODE_ID) > 0 THEN 'ACTIVE' ELSE 'INACTIVE' END) AS [SECTION_STATUS],    
    (CASE WHEN (SELECT VCP.SEC_ISLISTSECTION FROM VCP_UDSECTION VCP (NOLOCK) WHERE SectionID=VCP.SubjCode_ID) > 0 THEN 'LIST' ELSE 'NON-LIST' END) AS [SECTION_TYPE],
    (SELECT ListSectionNumber FROM [GetListSectionNumber] (PHCASE.ID, 1)  WHERE SecActID = UDSectionActID) AS [SECTION_NUMBER],   
    UDFieldActID AS [FIELD_INSTANCE_ID],
    Field_ID AS [FIELD_DEF_DR],      
    UDFieldName AS [FIELD_NAME],    
    (CASE WHEN UDFieldIsRequired=1 THEN 'TRUE' ELSE 'FALSE' END) AS [FIELD_IS_REQUIRED],    
    (CASE WHEN VSEC.UDField_valueENTITYID > 1 
     THEN 
        (SELECT [dbo].[UDF_GetEntityNameAsText](VSEC.UDField_metaCodeUCSID,VSEC.UDField_valueENTITYID) AS Expr1)
     ELSE 
        (SELECT dbo.UDF_GetFieldValueAsText(NULL, NULL, NULL, VSEC.UDField_valueDateTime, VSEC.UDField_valueString, VSEC.UDField_valueENTITYID, - 1, VSEC.UDField_valueUCSID, VSEC.UDField_metaCodeUCSID, NULL, CTE_PHDATEFIELDFORMAT.DATEFIELDFORMAT) AS Expr1)
     END) AS [FIELD_VALUE], 
    (CASE WHEN VSEC.UDField_valueENTITYID > 1
     THEN 
        CAST(VSEC.UDField_valueENTITYID AS varchar(100))
     ELSE 
        (SELECT dbo.UDF_GetFieldUCSValueAsConceptCode( VSEC.UDField_valueUCSID) AS Expr1)
     END) AS [FIELD_CONCEPT_CODE_VALUE], 
    (Case when VTDField.Active=1 then 'ACTIVE' else 'INACTIVE' END)  AS [FIELD_STATUS],  
    UCSFieldType.FullName AS [FIELD_TYPE]
FROM CTE_PHDATEFIELDFORMAT,
    A_ACT PHCASE (NOLOCK)  
    INNER JOIN P_Participation PART (NOLOCK) ON PART.Act_ID = PHCASE.Act_Parent_ID AND PART.TypeCode = 'SBJ'  
    INNER JOIN R_ROLE PAT (NOLOCK) ON PAT.ID = PART.Role_ID and PAT.statusCode = 'active'
    INNER JOIN [AtlasInternal].[View_UODS_UDSection] VSEC (NOLOCK) ON VSEC.ACT_ID=PHCASE.ID AND VSEC.SectionID = (SELECT CAST(VALUE AS INT) FROM dbo.S_ConfigValue (NOLOCK) WHERE configDefinition_ID = (SELECT ID FROM dbo.S_ConfigDefinition (NOLOCK) WHERE [key] = 'CNF_ClientUDSection'))
    INNER JOIN A_PublicHealthCase CRACT (NOLOCK) ON CRACT.ID = PHCASE.ID 
    INNER JOIN V_UnifiedCodeSet RecordType (NOLOCK) ON RecordType.ID = CRACT.phRecordTypeCode_ID AND RecordType.conceptCode = 'CR'
    LEFT Join V_UnifiedCodeSet UCSFieldType (NOLOCK) on UCSFieldType.ID=VSEC.FIELD_TypeCode_ID    
    LEFT Join V_TermDictionary VTDField (NOLOCK) on VTDField.termCode_ID=VSEC.UDFIELDID    
WHERE  
    PHCASE.Classcode In ('Case') 
    AND PHCASE.METACODE IN ('PR_RowID')    
    AND PHCASE.Statuscode NOT IN ('nullified','terminated')

-- Get the Shared Across Person Section Data
    
UNION ALL   
(
SELECT 
    PHCASE.ID AS [RECORD_ID],   
    PAT.player_ID AS [Client_ID],      
    NULL AS [FORM_INSTANCE_ID], 
    NULL [FORM_DEF_DR],    
    NULL AS [FORM_NAME],  
    NULL [FORM_SHOW_IN_CMR],    
    NULL [FORM_SHOW_IN_NCM] ,
    NULL AS [FORM_DESCRIPTION],  
    NULL AS [FORM_CREATEDATE] ,   
    UDSectionActID AS [SECTION_INSTANCE_ID],  
    Sec_ID AS [SECTION_DEF_DR],  
    UDSecName AS [SECTION_NAME],    
    (CASE WHEN (SELECT VTD.ACTIVE FROM V_TERMDICTIONARY VTD (NOLOCK) WHERE UDSectionDefID=VTD.TERMCODE_ID) > 0 THEN 'ACTIVE' ELSE 'INACTIVE' END) AS [SECTION_STATUS],    
    (CASE WHEN (SELECT VCP.SEC_ISLISTSECTION FROM VCP_UDSECTION VCP (NOLOCK) WHERE UDSectionDefID=VCP.SubjCode_ID) > 0 THEN 'LIST' ELSE 'NON-LIST' END) AS [SECTION_TYPE],
    (SELECT ListSectionNumber FROM [GetListSectionNumber] (PHCASE.Act_Parent_ID, 1)  WHERE SecActID = UDSectionActID) AS [SECTION_NUMBER],   
    UDFieldActID AS [FIELD_INSTANCE_ID],
    Field_ID AS [FIELD_DEF_DR],      
    UDFieldName AS [FIELD_NAME],    
    (CASE WHEN UDFieldIsRequired=1 THEN 'TRUE' ELSE 'FALSE' END) AS [FIELD_IS_REQUIRED],    
    (CASE WHEN VSEC.UDField_valueENTITYID > 1 
     THEN 
        (SELECT [dbo].[UDF_GetEntityNameAsText](VSEC.UDField_metaCodeUCSID,VSEC.UDField_valueENTITYID) AS Expr1)
     ELSE 
        (SELECT dbo.UDF_GetFieldValueAsText(NULL, NULL, NULL, VSEC.UDField_valueDateTime, VSEC.UDField_valueString, VSEC.UDField_valueENTITYID, - 1, VSEC.UDField_valueUCSID, VSEC.UDField_metaCodeUCSID, NULL, CTE_PHDATEFIELDFORMAT.DATEFIELDFORMAT) AS Expr1)
     END) AS [FIELD_VALUE], 
    (CASE WHEN VSEC.UDField_valueENTITYID > 1
     THEN 
        CAST(VSEC.UDField_valueENTITYID AS varchar(100))
     ELSE 
        (SELECT dbo.UDF_GetFieldUCSValueAsConceptCode( VSEC.UDField_valueUCSID) AS Expr1)
     END) AS [FIELD_CONCEPT_CODE_VALUE],   
    (Case when VTDField.Active=1 then 'ACTIVE' else 'INACTIVE' END)  AS [FIELD_STATUS],  
    UCSFieldType.FullName AS [FIELD_TYPE]
FROM CTE_PHDATEFIELDFORMAT,
    A_ACT PHCASE (NOLOCK) 
    INNER JOIN P_Participation PART (NOLOCK) ON PART.Act_ID = PHCASE.Act_Parent_ID AND PART.TypeCode = 'SBJ'  
    INNER JOIN R_ROLE PAT (NOLOCK) ON PAT.ID = PART.Role_ID and PAT.statusCode = 'active'   
    INNER JOIN [AtlasPublic].[viewUDF_SharedAcrossPersonSection] VSEC (NOLOCK) ON VSEC.ACT_ID=PHCASE.ID AND VSEC.UDSectionDefID = (SELECT CAST(VALUE AS INT) FROM dbo.S_ConfigValue (NOLOCK) WHERE configDefinition_ID = (SELECT ID FROM dbo.S_ConfigDefinition (NOLOCK) WHERE [key] = 'CNF_ClientUDSection'))
    INNER JOIN A_PublicHealthCase CRACT (NOLOCK) ON     CRACT.ID = PHCASE.ID 
    INNER JOIN V_UnifiedCodeSet RecordType (NOLOCK) ON RecordType.ID = CRACT.phRecordTypeCode_ID AND RecordType.conceptCode = 'CR'
    LEFT Join V_UnifiedCodeSet UCSFieldType (NOLOCK) on UCSFieldType.ID=VSEC.FIELD_TypeCode_ID    
    LEFT Join V_TermDictionary VTDField (NOLOCK) on VTDField.termCode_ID=VSEC.UDFIELDID  
  
WHERE  
    PHCASE.Classcode In ('Case') 
    AND PHCASE.METACODE IN ('PR_RowID')    
    AND PHCASE.Statuscode NOT IN ('nullified','terminated')
 
)
