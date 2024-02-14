CREATE VIEW [AtlasPublic].[View_CMMode_SharedAcrossRecordSection_Extended]
AS
SELECT 
    Act_ID AS CaseAct_ID,
    ACT_FORM.ID AS UDFormID,
    VCP_UDForm.FRM_ID AS UDFormDefID,
    Service_DR, 
    UDSecName,
    UDSecType,
    UDFieldName,
    UDFieldID,
    UDSectionDefID,
    UDSectionActID,
    UDFieldActID,
    UDField_valueDateTime,
    UDField_valueString,
    UDField_valueENTITYID,
    UDField_valueUCSID,
    UDField_metaCodeUCSID,
    Field_ID,
    Sec_ID,
    SEC_IsListSection,
    UDFieldIsRequired,  
    FIELD_TypeCode_ID,
    VUCS_FORM.fullName AS UDFormName,
    VCP_UDForm.FRM_DESC AS UDFormDesc,
    VCP_UDForm.FRM_InCMR as UDFormInCMR,
    VCP_UDForm.FRM_InNCM as UDFormInNCM,    
    ACT_FORM.EFFECTIVETIME_BEG AS UDFormCreateDate,
    UDFormCreateDate AS UDSecCreateDate
FROM 
    [AtlasPublic].[View_CMMode_SharedAcrossRecordSection] VIEW_SAR
    ----------------
    INNER JOIN [V_CodeProperty] CP_FORMSECTION (nolock) ON  CP_FORMSECTION.[valueCode_ID]=VIEW_SAR.UDSectionDefID
    INNER JOIN VCP_UDForm (NOLOCK) ON  VCP_UDForm.SubjCode_ID = CP_FORMSECTION.SUBJCODE_ID  
    ------------
    INNER JOIN A_ActRelationship AREL_CASE_FORM(NOLOCK) ON AREL_CASE_FORM.TYPECODE='COMP' AND AREL_CASE_FORM.SOURCE_ID= VIEW_SAR.Act_ID
    INNER JOIN A_ACT AS ACT_FORM (NOLOCK) on AREL_CASE_FORM.TARGET_ID=ACT_FORM.ID AND ACT_FORM.CLASSCODE='DOCBODY' AND ACT_FORM.STATUSCODE='active' 
                AND ACT_FORM.code_ID = VCP_UDForm.SubjCode_ID
    INNER JOIN V_UNIFIEDCODESET VUCS_FORM(NOLOCK) ON VUCS_FORM.ID = ACT_FORM.CODE_ID
