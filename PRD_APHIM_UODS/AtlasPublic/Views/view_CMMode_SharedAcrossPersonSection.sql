
CREATE VIEW [AtlasPublic].[view_CMMode_SharedAcrossPersonSection]
AS
SELECT 
    AREL.source_ID AS Act_ID,
    RLE.player_ID AS PER_RowID,
    NULL AS UDFormID,
    NULL AS UDFormDefID,
    Null  AS Service_DR, 
    VUCS_SECTION.FULLNAME AS UDSecName,
    VUCS_SECTION.SHORTNAME AS UDSecType,
    VUCS_FIELD.FULLNAME AS UDFieldName,
    VUCS_FIELD.ID AS UDFieldID,
    VUCS_SECTION.ID AS UDSectionDefID,
    ACT_SECTION.ID AS UDSectionActID,
    AX_UDFVALUES.ID AS UDFieldActID,
    --+CMG IssueNbr:-123369
    Ax_UDFValues.valueDateTime AS UDField_valueDateTime,
    Ax_UDFValues.valueString  AS UDField_valueString,
    ([dbo].[UDF_GetEntityRoot](Ax_UDFValues.VALUE_ENTITYID)) AS UDField_valueENTITYID,
    Ax_UDFValues.value_UCSID  AS UDField_valueUCSID,
    Ax_UDFValues.metaCode_UCSID  AS UDField_metaCodeUCSID,
    ---CMG IssueNbr:-123369
    VCP_Field.Field_ID AS Field_ID,
    VCP_Section.SEC_ID AS  Sec_ID,
    VCP_Section.SEC_IsListSection,
    ISNull(VCP_Field.FIELD_IsRequired, 0) AS UDFieldIsRequired,
    VCP_Field.FIELD_TypeCode_ID,
    '' AS UDFormName,
    '' AS UDFormDesc,
    ACT_SECTION.EFFECTIVETIME_BEG AS UDFormCreateDate
FROM 
    A_ACT AS ACT_SECTION (NOLOCK)
    INNER JOIN A_ActRelationship (NOLOCK) AREL ON AREL.TARGET_ID=ACT_SECTION.ID AND AREL.TYPECODE='COMP' AND ACT_SECTION.CLASSCODE='DOCSECT' 
    INNER JOIN P_Participation (NOLOCK) PART ON AREL.source_ID = PART.Act_ID and PART.typeCode = 'SBJ'
    INNER JOIN R_Role (NOLOCK) RLE ON PART.Role_ID =RLE.ID AND RLE.classCode = 'PAT'AND RLE.statusCode = 'active' 
    INNER JOIN AX_UDFVALUES (NOLOCK) ON ACT_SECTION.ID = AX_UDFVALUES.ACT_PARENT_ID 
    INNER JOIN V_UNIFIEDCODESET(NOLOCK) VUCS_FIELD ON VUCS_FIELD.ID=AX_UDFVALUES.METACODE_UCSID
    INNER JOIN V_UNIFIEDCODESET (NOLOCK) VUCS_SECTION ON  VUCS_SECTION.ID=ACT_SECTION.CODE_ID
    INNER JOIN VCP_UDField (NOLOCK) VCP_Field ON VCP_Field.SubjCode_Id = AX_UDFVALUES.METACODE_UCSID
    INNER JOIN VCP_UDSection (NOLOCK) VCP_Section ON VCP_Section.subjCode_Id = ACT_SECTION.CODE_ID 
        AND VCP_Section.SEC_ShareAcrossPerson = 1--Added SharedAcrossPerson check       

WHERE 
    ACT_SECTION.STATUSCODE='active'     
