CREATE VIEW [AtlasPublic].[View_CMR_UserAccessible_UDFData]
AS
    SELECT 
    vSysUser.[USR_RowID] AS [USR_ROWID], 
    vSysUser.[USR_Login] AS [USR_LOGIN],
    [VCP_UDFORM].SubjCode_ID AS [USR_ACCESSIBLE_FORMDEF_ID],
    [VCP_UDFORM].FRM_ID AS [USR_ACCESSIBLE_FORM_ID],
    UCS.fullName AS [USR_Accessible_Form_Name],
    ISNULL(VCP_UDFORM.FRM_ISTAB,0) AS [USR_Accessible_Form_IsTab],
    ISNULL(VCP_UDFORM.FRM_InProtocol,0) AS [USR_Accessible_Form_InProtocol],
    VTD.active AS [USR_Accessible_Form_Active]
    
    FROM [AtlasPublic].[View_CMR_SystemUsers] vSysUser (nolock)
    INNER JOIN [R_RoleLink] [UGRLNK] (nolock) ON  vSysUser.USR_RoleID = UGRLNK.targetRole_ID AND UGRLNK.typeCode = 'PART' 
    AND UGRLNK.metaCode='USR_CMRUserGroupDR'
    INNER JOIN [R_Role] [UROL] (nolock) ON [UGRLNK].sourceRole_ID = UROL.ID and urol.classCode = 'ASSIGNED' AND UROL.metaCode = 'UG_ROWID' 
    AND UROL.statusCode = 'active'
    INNER JOIN S_SECURITYACCESS (nolock) ON UROL.ID = S_SECURITYACCESS.ROLE_ID AND S_SecurityAccess.CanRead = 1
    INNER JOIN VCP_UDFORM (nolock) ON S_SECURITYACCESS.SUBJCODE_ID = VCP_UDFORM.SUBJCODE_ID
    LEFT Join V_UnifiedCodeSet UCS(NOLOCK) On VCP_UDForm.SubjCode_ID = UCS.ID
    LEFT Join V_TermDictionary VTD (NOLOCK) ON VCP_UDForm.SubjCode_ID = VTD.termCode_ID
