﻿/****** Object:  View [AtlasPublic].[View_UODS_GetHistoricalSectionData]    Script Date: 01/27/2014 11:42:59 ******/
CREATE VIEW [AtlasPublic].[View_UODS_GetHistoricalSectionData]  
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
SELECT 
	PHCASE.ID AS [RECORD_ID],    
	UDFormID AS [FORM_INSTANCE_ID],
	VCPUDF.FRM_ID [FORM_DEF_DR],  
	UDFormName AS [FORM_NAME],  
	VCPUDF.FRM_InCMR [FORM_SHOW_IN_CMR],    
	VCPUDF.FRM_InNCM [FORM_SHOW_IN_NCM] , 
	UDFormDesc AS [FORM_DESCRIPTION],  
	UDFormCreateDate AS [FORM_CREATEDATE] , 
	UDSectionActID AS [SECTION_INSTANCE_ID],  
	Sec_ID AS [SECTION_DEF_DR],   
	UDSecName AS [SECTION_NAME],    
	(CASE WHEN (SELECT VTD.ACTIVE FROM V_TERMDICTIONARY VTD (NOLOCK) WHERE UDSectionDefID=VTD.TERMCODE_ID) > 0 THEN 'ACTIVE' ELSE 'INACTIVE' END) AS [SECTION_STATUS],    
	CASE WHEN (SELECT VCP.SEC_ISLISTSECTION FROM VCP_UDSECTION VCP (NOLOCK) WHERE UDSectionDefID=VCP.SubjCode_ID) > 0 THEN 'LIST' ELSE 'NON-LIST' END AS [SECTION_TYPE],  
	( SELECT ListSectionNumber FROM [GetListSectionNumber] (UDFormID,0)  WHERE SecActID = UDSectionActID) AS [SECTION_NUMBER] ,   
	UDFieldActID AS [FIELD_INSTANCE_ID], 
	Field_ID AS [FIELD_DEF_DR],     
	UDFieldName AS [FIELD_NAME],    
	(CASE WHEN UDFieldIsRequired=1 THEN 'TRUE' ELSE 'FALSE' END) AS [FIELD_IS_REQUIRED],
	(CASE WHEN VFORM.UDField_valueENTITYID > 1 
	 THEN 
		(SELECT [dbo].[UDF_GetEntityNameAsText](VFORM.UDField_metaCodeUCSID,VFORM.UDField_valueENTITYID) AS Expr1)
     ELSE 
		(SELECT dbo.UDF_GetFieldValueAsText(NULL, NULL, NULL, VFORM.UDField_valueDateTime, VFORM.UDField_valueString, VFORM.UDField_valueENTITYID, - 1, VFORM.UDField_valueUCSID, VFORM.UDField_metaCodeUCSID, NULL, CTE_PHDATEFIELDFORMAT.DATEFIELDFORMAT) AS Expr1)
	 END) AS [FIELD_VALUE],	
    (CASE WHEN VFORM.UDField_valueENTITYID > 1
	 THEN 
		CAST(VFORM.UDField_valueENTITYID AS varchar(100))
	 ELSE 
		(SELECT dbo.UDF_GetFieldUCSValueAsConceptCode( VFORM.UDField_valueUCSID) AS Expr1)
	 END) AS [FIELD_CONCEPT_CODE_VALUE],  
	(Case when VTDField.Active=1 then 'ACTIVE' else 'INACTIVE' END)  AS [FIELD_STATUS],  
	UCSFieldType.FullName AS [FIELD_TYPE]
FROM 
    CTE_PHDATEFIELDFORMAT,
	A_ACT PHCASE (NOLOCK)    
	INNER JOIN [AtlasInternal].[View_UODS_UDForm] VFORM (NOLOCK) ON VFORM.Act_ID=PHCASE.ID AND (VFORM.Disease_ID Is Not Null And VFORM.Disease_ID <> PHCASE.code_ID)
	LEFT JOIN VCP_UDForm VCPUDF (NOLOCK) ON  VCPUDF.SubjCode_ID = UDFormDefID      
	LEFT Join V_TermDictionary VTDField (NOLOCK) on VTDField.termCode_ID=VFORM.UDFieldID    
	LEFT Join V_UnifiedCodeSet UCSFieldType (NOLOCK) on UCSFieldType.ID=VFORM.FIELD_TypeCode_ID    
	LEFT JOIN AX_UDFVALUES AFIELD (NOLOCK) ON AFIELD.ID=VFORM.UDFieldActID    
WHERE  
	PHCASE.Classcode In ('Case','OUTB') 
	AND PHCASE.METACODE IN ('SVC_ID', 'PR_RowID','OB_RowID','AI_RowID')   
	AND PHCASE.Statuscode NOT IN ('nullified','terminated')

UNION ALL   
(
SELECT 
	PHCASE.ID AS [RECORD_ID],    
	NULL AS [FORM_INSTANCE_ID], 
	NULL [FORM_DEF_DR],    
	NULL AS [FORM_NAME],  
	NULL [FORM_SHOW_IN_CMR],    
	NULL [FORM_SHOW_IN_NCM] ,
	NULL AS [FORM_DESCRIPTION],  
	NULL AS [FORM_CREATEDATE] , 
	UDSectionActID AS [SECTION_INSTANCE_ID], 
	VSEC.Sec_ID AS [SECTION_DEF_DR],     
	UDSecName AS [SECTION_NAME],    
	(CASE WHEN (SELECT VTD.ACTIVE FROM V_TERMDICTIONARY VTD (NOLOCK) WHERE SectionID=VTD.TERMCODE_ID) > 0 THEN 'ACTIVE' ELSE 'INACTIVE' END) AS [SECTION_STATUS],   
	(CASE WHEN (SELECT VCP.SEC_ISLISTSECTION FROM VCP_UDSECTION VCP (NOLOCK) WHERE SectionID=VCP.SubjCode_ID) > 0 THEN 'LIST' ELSE 'NON-LIST' END) AS [SECTION_TYPE],
	( SELECT ListSectionNumber FROM [GetListSectionNumber] (PHCASE.ID,1)  WHERE SecActID = UDSectionActID) AS [SECTION_NUMBER] ,    
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
	FROM 
	CTE_PHDATEFIELDFORMAT,
	A_ACT PHCASE (NOLOCK) 
	INNER JOIN [AtlasInternal].[View_UODS_UDSection] VSEC (NOLOCK) ON VSEC.ACT_ID = PHCASE.ID 
	INNER JOIN A_Act SecAct (NOLOCK) ON SecAct.ID = VSEC.UDSectionActID AND SecAct.ValueCode_ID <> PHCASE.code_ID
	INNER JOIN VCP_UDSection VCPSEC (NOLOCK) ON SecAct.code_ID = VCPSEC.SubjCode_ID AND ISNULL(VCPSEC.SEC_SHAREACROSSRECORD,0)=0 AND ISNULL(VCPSEC.SEC_SHAREACROSSPERSON ,0)=0
	LEFT Join V_UnifiedCodeSet UCSFieldType (NOLOCK) on UCSFieldType.ID=VSEC.FIELD_TypeCode_ID    
	LEFT Join V_TermDictionary VTDField (NOLOCK) on VTDField.termCode_ID=VSEC.UDFIELDID
)

-- Get the Shared Across Case Section Data
UNION ALL  
(
SELECT 
	PHCASE.ID AS [RECORD_ID],    
	UDFormID AS [FORM_INSTANCE_ID], 
	VCPUDF.FRM_ID [FORM_DEF_DR],    
	UDFormName AS [FORM_NAME],  
	VCPUDF.FRM_InCMR [FORM_SHOW_IN_CMR],    
	VCPUDF.FRM_InNCM [FORM_SHOW_IN_NCM] ,
	UDFormDesc AS [FORM_DESCRIPTION],  
	UDFormCreateDate AS [FORM_CREATEDATE] ,   
	UDSectionActID AS [SECTION_INSTANCE_ID],  
	Sec_ID AS [SECTION_DEF_DR],  
	UDSecName AS [SECTION_NAME],    
	(CASE WHEN (SELECT VTD.ACTIVE FROM V_TERMDICTIONARY VTD (NOLOCK) WHERE UDSectionDefID=VTD.TERMCODE_ID) > 0 THEN 'ACTIVE' ELSE 'INACTIVE' END) AS [SECTION_STATUS],    
	CASE WHEN (SELECT VCP.SEC_ISLISTSECTION FROM VCP_UDSECTION VCP (NOLOCK) WHERE UDSectionDefID=VCP.SubjCode_ID) > 0 THEN 'LIST' ELSE 'NON-LIST' END AS [SECTION_TYPE],
	( SELECT ListSectionNumber FROM [GetListSectionNumber] (PHCASE.ID,1)  WHERE SecActID = UDSectionActID) AS [SECTION_NUMBER] ,   
	UDFieldActID AS [FIELD_INSTANCE_ID],
	Field_ID AS [FIELD_DEF_DR],      
	UDFieldName AS [FIELD_NAME],    
	(CASE WHEN UDFieldIsRequired=1 THEN 'TRUE' ELSE 'FALSE' END) AS [FIELD_IS_REQUIRED],    
	(CASE WHEN VFORM.UDField_valueENTITYID > 1 
	 THEN 
		(SELECT [dbo].[UDF_GetEntityNameAsText](VFORM.UDField_metaCodeUCSID,VFORM.UDField_valueENTITYID) AS Expr1)
     ELSE 
		(SELECT dbo.UDF_GetFieldValueAsText(NULL, NULL, NULL, VFORM.UDField_valueDateTime, VFORM.UDField_valueString, VFORM.UDField_valueENTITYID, - 1, VFORM.UDField_valueUCSID, VFORM.UDField_metaCodeUCSID, NULL, CTE_PHDATEFIELDFORMAT.DATEFIELDFORMAT) AS Expr1)
	 END) AS [FIELD_VALUE],	
    (CASE WHEN VFORM.UDField_valueENTITYID > 1
	 THEN 
		CAST(VFORM.UDField_valueENTITYID AS varchar(100))
	 ELSE 
		(SELECT dbo.UDF_GetFieldUCSValueAsConceptCode( VFORM.UDField_valueUCSID) AS Expr1)
	 END) AS [FIELD_CONCEPT_CODE_VALUE],  
	(Case when VTDField.Active=1 then 'ACTIVE' else 'INACTIVE' END)  AS [FIELD_STATUS],  
	UCSFieldType.FullName AS [FIELD_TYPE]
FROM 
	CTE_PHDATEFIELDFORMAT,
	A_ACT PHCASE (NOLOCK)     
	INNER JOIN [AtlasPublic].[viewUDF_SharedAcrossCaseSection] VFORM (NOLOCK) ON VFORM.Act_ID=PHCASE.ID AND (VFORM.Disease_ID Is Not Null And VFORM.Disease_ID <> PHCASE.code_ID)  
	LEFT JOIN VCP_UDForm VCPUDF (NOLOCK) ON  VCPUDF.SubjCode_ID = UDFormDefID  
	LEFT Join V_TermDictionary VTDField (NOLOCK) on VTDField.termCode_ID=VFORM.UDFieldID    
	LEFT Join V_UnifiedCodeSet UCSFieldType (NOLOCK) on UCSFieldType.ID=VFORM.FIELD_TypeCode_ID    
	LEFT JOIN AX_UDFVALUES AFIELD (NOLOCK) ON AFIELD.ID=VFORM.UDFieldActID    
WHERE  
	PHCASE.Classcode In ('Case','OUTB') 
	AND PHCASE.METACODE IN ('SVC_ID', 'PR_RowID','OB_RowID','AI_RowID')    
	AND PHCASE.Statuscode NOT IN ('nullified','terminated')
 
)
-- Get the Shared Across Person Section Data
UNION ALL   
(
SELECT 
	PHCASE.ID AS [RECORD_ID],    
	UDFormID AS [FORM_INSTANCE_ID],  
	VCPUDF.FRM_ID [FORM_DEF_DR],  
	UDFormName AS [FORM_NAME], 
	VCPUDF.FRM_InCMR [FORM_SHOW_IN_CMR],    
	VCPUDF.FRM_InNCM [FORM_SHOW_IN_NCM] ,
	UDFormDesc AS [FORM_DESCRIPTION],  
	UDFormCreateDate AS [FORM_CREATEDATE] , 
	UDSectionActID AS [SECTION_INSTANCE_ID], 
	Sec_ID AS [SECTION_DEF_DR],     
	UDSecName AS [SECTION_NAME],    
	(CASE WHEN (SELECT VTD.ACTIVE FROM V_TERMDICTIONARY VTD (NOLOCK) WHERE UDSectionDefID=VTD.TERMCODE_ID) > 0 THEN 'ACTIVE' ELSE 'INACTIVE' END) AS [SECTION_STATUS],    
	CASE WHEN (SELECT VCP.SEC_ISLISTSECTION FROM VCP_UDSECTION VCP (NOLOCK) WHERE UDSectionDefID=VCP.SubjCode_ID) > 0 THEN 'LIST' ELSE 'NON-LIST' END AS [SECTION_TYPE],
	( SELECT ListSectionNumber FROM [GetListSectionNumber] (PHCASE.Act_Parent_ID,1)  WHERE SecActID = UDSectionActID) AS [SECTION_NUMBER] ,    
	UDFieldActID AS [FIELD_INSTANCE_ID],
	Field_ID AS [FIELD_DEF_DR],     
	UDFieldName AS [FIELD_NAME],    
	(CASE WHEN UDFieldIsRequired=1 THEN 'TRUE' ELSE 'FALSE' END) AS [FIELD_IS_REQUIRED],  
	(CASE WHEN VFORM.UDField_valueENTITYID > 1 
	 THEN 
		(SELECT [dbo].[UDF_GetEntityNameAsText](VFORM.UDField_metaCodeUCSID,VFORM.UDField_valueENTITYID) AS Expr1)
     ELSE 
		(SELECT dbo.UDF_GetFieldValueAsText(NULL, NULL, NULL, VFORM.UDField_valueDateTime, VFORM.UDField_valueString, VFORM.UDField_valueENTITYID, - 1, VFORM.UDField_valueUCSID, VFORM.UDField_metaCodeUCSID, NULL, CTE_PHDATEFIELDFORMAT.DATEFIELDFORMAT) AS Expr1)
	 END) AS [FIELD_VALUE],	
    (CASE WHEN VFORM.UDField_valueENTITYID > 1
	 THEN 
		CAST(VFORM.UDField_valueENTITYID AS varchar(100))
	 ELSE 
		(SELECT dbo.UDF_GetFieldUCSValueAsConceptCode( VFORM.UDField_valueUCSID) AS Expr1)
	 END) AS [FIELD_CONCEPT_CODE_VALUE],   
	(Case when VTDField.Active=1 then 'ACTIVE' else 'INACTIVE' END)  AS [FIELD_STATUS],  
	UCSFieldType.FullName AS [FIELD_TYPE]
FROM 
	CTE_PHDATEFIELDFORMAT,
	A_ACT PHCASE (NOLOCK)   
	INNER JOIN [AtlasPublic].[viewUDF_SharedAcrossPersonSection] VFORM (NOLOCK) ON VFORM.Act_ID=PHCASE.ID AND (VFORM.Disease_ID Is Not Null And VFORM.Disease_ID <> PHCASE.code_ID)   
	LEFT JOIN VCP_UDForm VCPUDF (NOLOCK) ON  VCPUDF.SubjCode_ID = UDFormDefID  
	LEFT Join V_TermDictionary VTDField (NOLOCK) on VTDField.termCode_ID=VFORM.UDFieldID    
	LEFT Join V_UnifiedCodeSet UCSFieldType (NOLOCK) on UCSFieldType.ID=VFORM.FIELD_TypeCode_ID    
	LEFT JOIN AX_UDFVALUES AFIELD (NOLOCK) ON AFIELD.ID=VFORM.UDFieldActID    
WHERE  
	PHCASE.Classcode In ('Case','OUTB') 
	AND PHCASE.METACODE IN ('SVC_ID', 'PR_RowID','OB_RowID','AI_RowID')     
	AND PHCASE.Statuscode NOT IN ('nullified','terminated')
)
