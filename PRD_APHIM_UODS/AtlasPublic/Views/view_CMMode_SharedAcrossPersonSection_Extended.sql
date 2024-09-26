CREATE VIEW [AtlasPublic].[view_CMMode_SharedAcrossPersonSection_Extended]
AS
SELECT --FETCH SHARED ACROSS PERSON RECORDS WHICH ARE SAVED DIRECTLY WITH CLIENT.
    VIEW_SAP.Act_ID as FolderAct_ID,
    LINK.Act1_ID as CaseAct_ID,
    PER_RowID,
    ACT_FORM.ID AS UDFormID,
    VCP_UDForm.FRM_ID AS UDFormDefID,
    VIEW_SAP.Service_DR AS Service_DR, 
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
    [AtlasPublic].[view_CMMode_SharedAcrossPersonSection] VIEW_SAP
    ------------------------
    LEFT JOIN  S_Link(NOLOCK) LINK on LINK.Entity2_ID = VIEW_SAP.PER_RowID AND LINK.Act2_ID=VIEW_SAP.Act_ID AND LINK.name='Patient-Case'
    ------------------------
    INNER JOIN [V_CodeProperty] CP_FORMSECTION (nolock) ON  CP_FORMSECTION.[valueCode_ID]=UDSectionDefID
    INNER JOIN VCP_UDForm (NOLOCK) ON  VCP_UDForm.SubjCode_ID = CP_FORMSECTION.SUBJCODE_ID  
    ------------------------
    INNER JOIN A_ActRelationship AREL_FOLDER_FORM(NOLOCK) ON AREL_FOLDER_FORM.TYPECODE='COMP' AND AREL_FOLDER_FORM.SOURCE_ID= VIEW_SAP.Act_ID
    INNER JOIN A_ACT AS ACT_FORM (NOLOCK) on AREL_FOLDER_FORM.TARGET_ID=ACT_FORM.ID AND ACT_FORM.CLASSCODE='DOCBODY' AND ACT_FORM.STATUSCODE='active' 
                AND ACT_FORM.code_ID = VCP_UDForm.SubjCode_ID   
    INNER JOIN V_UNIFIEDCODESET VUCS_FORM(NOLOCK) ON VUCS_FORM.ID = ACT_FORM.CODE_ID
    
    UNION ALL
    (
        SELECT --FETCH SHARED ACROSS PERSON RECORDS WHICH ARE SAVED THROUGH SERVICE FORMS.
        VIEW_SAP.Act_ID as FolderAct_ID,
        LINK.Act1_ID as CaseAct_ID,
        PER_RowID,
        ACT_FORM.ID AS UDFormID,
        VCP_UDForm.FRM_ID AS UDFormDefID,
        VIEW_SAP.Service_DR AS Service_DR, 
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
        [AtlasPublic].[view_CMMode_SharedAcrossPersonSection] VIEW_SAP
        ------------------------
        INNER JOIN  S_Link(NOLOCK) LINK on LINK.Entity2_ID = VIEW_SAP.PER_RowID AND LINK.Act2_ID=VIEW_SAP.Act_ID AND LINK.name='Patient-Case'   
        ------------------------
        INNER JOIN [V_CodeProperty] CP_FORMSECTION (nolock) ON  CP_FORMSECTION.[valueCode_ID]=UDSectionDefID
        INNER JOIN VCP_UDForm (NOLOCK) ON  VCP_UDForm.SubjCode_ID = CP_FORMSECTION.SUBJCODE_ID  
        ------------
        INNER JOIN A_ActRelationship AREL_CASE_FORM(NOLOCK) ON AREL_CASE_FORM.TYPECODE='COMP' AND AREL_CASE_FORM.SOURCE_ID= LINK.Act1_ID
        INNER JOIN A_ACT AS ACT_FORM (NOLOCK) on AREL_CASE_FORM.TARGET_ID=ACT_FORM.ID AND ACT_FORM.CLASSCODE='DOCBODY' AND ACT_FORM.STATUSCODE='active' 
            AND ACT_FORM.code_ID = VCP_UDForm.SubjCode_ID
        INNER JOIN V_UNIFIEDCODESET VUCS_FORM(NOLOCK) ON VUCS_FORM.ID = ACT_FORM.CODE_ID
    )
    
