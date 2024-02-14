﻿
CREATE VIEW [AtlasPublic].[View_CMMode_UDFData]
AS
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
    -- Get UDForms attached with Services and UDForms dircetly attached to the Client.
SELECT 
[RECORD_ID],    
[FORM_INSTANCE_ID],
[FORM_DEF_DR],  
[FORM_NAME],  
[FORM_SHOW_IN_CMR],    
[FORM_SHOW_IN_CMM], 
[FORM_DESCRIPTION],
[FORM_CREATEDATE], 
[SECTION_INSTANCE_ID],  
[SECTION_DEF_DR],   
[SECTION_NAME],
[SECTION_STATUS],    
[SECTION_TYPE],  
[SECTION_NUMBER],   
[FIELD_INSTANCE_ID],
[FIELD_DEF_DR], 
[FIELD_NAME], 
[FIELD_IS_REQUIRED],
[FIELD_VALUE],
[FIELD_CONCEPT_CODE_VALUE],  
[FIELD_STATUS],
[FIELD_TYPE]                   
FROM [AtlasInternal].[View_CMMode_NonShared_UDFData]            
-- Get the Shared Across Record Section Data    
UNION ALL  
(
SELECT 
PHCASE.ID AS [RECORD_ID],    
UDFormID AS [FORM_INSTANCE_ID], 
VCPUDF.FRM_ID [FORM_DEF_DR],    
UDFormName AS [FORM_NAME],  
VCPUDF.FRM_InCMR [FORM_SHOW_IN_CMR],    
VCPUDF.FRM_InNCM [FORM_SHOW_IN_CMM] ,
UDFormDesc AS [FORM_DESCRIPTION],  
UDFormCreateDate AS [FORM_CREATEDATE] ,   
UDSectionActID AS [SECTION_INSTANCE_ID],  
Sec_ID AS [SECTION_DEF_DR],  
UDSecName AS [SECTION_NAME],    
(CASE WHEN (SELECT VTD.ACTIVE FROM V_TERMDICTIONARY VTD (NOLOCK) WHERE UDSectionDefID=VTD.TERMCODE_ID) > 0 THEN 'ACTIVE' ELSE 'INACTIVE' END) AS [SECTION_STATUS],
CASE WHEN SEC_ISLISTSECTION > 0 THEN 'LIST' ELSE 'NON-LIST' END AS  [SECTION_TYPE],
( SELECT ListSectionNumber FROM [GetListSectionNumber] (PHCASE.ID,1)  WHERE SecActID = UDSectionActID) AS [SECTION_NUMBER] ,   
UDFieldActID AS [FIELD_INSTANCE_ID],
Field_ID AS [FIELD_DEF_DR],      
UDFieldName AS [FIELD_NAME],    
(CASE WHEN UDFieldIsRequired=1 THEN 'TRUE' ELSE 'FALSE' END) AS [FIELD_IS_REQUIRED],
(CASE WHEN VFORM.UDField_valueENTITYID > 1 Then
(SELECT [dbo].[UDF_GetEntityNameAsText](VFORM.UDField_metaCodeUCSID,VFORM.UDField_valueENTITYID) AS Expr1)
ELSE
(SELECT dbo.UDF_GetFieldValueAsText(NULL, NULL, NULL, VFORM.UDField_valueDateTime, VFORM.UDField_valueString, VFORM.UDField_valueENTITYID, -1, VFORM.UDField_valueUCSID, VFORM.UDField_metaCodeUCSID, NULL, CTE_PHDATEFIELDFORMAT.DATEFIELDFORMAT) AS Expr1) END) As [FIELD_VALUE],
(CASE WHEN VFORM.UDField_valueENTITYID > 0 Then 
    CAST(VFORM.UDField_valueENTITYID AS varchar(100))
ELSE
(SELECT dbo.UDF_GetFieldUCSValueAsConceptCode(VFORM.UDField_valueUCSID) AS Expr1) END) AS [FIELD_CONCEPT_CODE_VALUE],  
(Case when VTDField.Active=1 then 'ACTIVE' else 'INACTIVE' END)  AS [FIELD_STATUS],  
UCSFieldType.FullName AS [FIELD_TYPE]
FROM CTE_PHDATEFIELDFORMAT,
A_ACT PHCASE (NOLOCK)   
INNER JOIN [AtlasPublic].[View_CMMode_SharedAcrossRecordSection](NOLOCK) VFORM ON VFORM.Act_ID=PHCASE.ID
    AND PHCASE.Classcode ='Case'
    AND PHCASE.METACODE ='SVC_ID'
    AND PHCASE.Statuscode NOT IN ('nullified','terminated')
LEFT JOIN VCP_UDForm VCPUDF (NOLOCK) ON  VCPUDF.SubjCode_ID = UDFormDefID  
INNER Join V_TermDictionary(NOLOCK) VTDField on VTDField.termCode_ID=VFORM.UDFieldID    
INNER Join V_UnifiedCodeSet(NOLOCK) UCSFieldType on UCSFieldType.ID=VFORM.FIELD_TypeCode_ID          
)   
-- Get the Shared Across Person Data
UNION ALL   
(
SELECT 
PHCASE.ID AS [RECORD_ID],    
UDFormID AS [FORM_INSTANCE_ID],  
VCPUDF.FRM_ID [FORM_DEF_DR],  
UDFormName AS [FORM_NAME], 
VCPUDF.FRM_InCMR [FORM_SHOW_IN_CMR],    
VCPUDF.FRM_InNCM [FORM_SHOW_IN_CMM] ,
UDFormDesc AS [FORM_DESCRIPTION],  
UDFormCreateDate AS [FORM_CREATEDATE] , 
UDSectionActID AS [SECTION_INSTANCE_ID], 
Sec_ID AS [SECTION_DEF_DR],     
UDSecName AS [SECTION_NAME],    
(CASE WHEN (SELECT VTD.ACTIVE FROM V_TERMDICTIONARY VTD (NOLOCK) WHERE UDSectionDefID=VTD.TERMCODE_ID) > 0 THEN 'ACTIVE' ELSE 'INACTIVE' END) AS [SECTION_STATUS],    
CASE WHEN (SELECT VCP.SEC_ISLISTSECTION FROM VCP_UDSECTION VCP (NOLOCK) WHERE UDSectionDefID=VCP.SubjCode_ID) > 0 THEN 'LIST' ELSE 'NON-LIST' END AS [SECTION_TYPE],
(SELECT ListSectionNumber FROM [GetListSectionNumber] (PHCASE.ID,1)  WHERE SecActID = UDSectionActID) AS [SECTION_NUMBER] ,    
UDFieldActID AS [FIELD_INSTANCE_ID],
Field_ID AS [FIELD_DEF_DR],     
UDFieldName AS [FIELD_NAME],    
(CASE WHEN UDFieldIsRequired=1 THEN 'TRUE' ELSE 'FALSE' END) AS [FIELD_IS_REQUIRED],
(CASE WHEN VFORM.UDField_valueENTITYID > 1 Then
(SELECT [dbo].[UDF_GetEntityNameAsText](VFORM.UDField_metaCodeUCSID,VFORM.UDField_valueENTITYID) AS Expr1)
ELSE
(SELECT dbo.UDF_GetFieldValueAsText(NULL, NULL, NULL, VFORM.UDField_valueDateTime, VFORM.UDField_valueString, VFORM.UDField_valueENTITYID, -1, VFORM.UDField_valueUCSID, VFORM.UDField_metaCodeUCSID, NULL, CTE_PHDATEFIELDFORMAT.DATEFIELDFORMAT) AS Expr1) END) As [FIELD_VALUE],
(CASE WHEN VFORM.UDField_valueENTITYID > 0 Then 
    CAST(VFORM.UDField_valueENTITYID AS varchar(100))
ELSE
(SELECT dbo.UDF_GetFieldUCSValueAsConceptCode( VFORM.UDField_valueUCSID) AS Expr1) END) AS [FIELD_CONCEPT_CODE_VALUE],  
(Case when VTDField.Active=1 then 'ACTIVE' else 'INACTIVE' END)  AS [FIELD_STATUS],  
UCSFieldType.FullName AS [FIELD_TYPE]
FROM CTE_PHDATEFIELDFORMAT,
A_ACT PHCASE  (NOLOCK)  
INNER JOIN [AtlasPublic].[view_CMMode_SharedAcrossPersonSection](NOLOCK) VFORM ON VFORM.Act_ID=PHCASE.ID 
    AND PHCASE.Classcode = 'FOLDER'
    AND PHCASE.metaCode is Null
    AND PHCASE.Statuscode NOT IN ('nullified','terminated')
LEFT JOIN VCP_UDForm VCPUDF (NOLOCK) ON  VCPUDF.SubjCode_ID = UDFormDefID  
INNER Join V_TermDictionary (NOLOCK) VTDField on VTDField.termCode_ID=VFORM.UDFieldID    
INNER Join V_UnifiedCodeSet (NOLOCK) UCSFieldType on UCSFieldType.ID=VFORM.FIELD_TypeCode_ID
)
