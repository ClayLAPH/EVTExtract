
CREATE VIEW [AtlasPublic].[View_CMMode_UserAccessible_Services]
AS
    SELECT 
        [vSysUser].[USR_RowID] AS [USR_ROWID], 
        [vSysUser].[USR_Login] AS [USR_LOGIN],
        [FormAccessAttr].[valueCode_ID] AS [USR_ACCESSIBLE_SERVICEDR]
    FROM [AtlasPublic].[View_CMMode_SystemUsers] [vSysUser]  
        INNER JOIN [R_RoleLink] [UGRLNK] (nolock) ON [vSysUser].[USR_RoleID] = UGRLNK.targetRole_ID AND UGRLNK.typeCode = 'PART' 
            AND UGRLNK.metaCode='USR_CMRUserGroupDR'
        INNER JOIN [R_Role] [UROL] (nolock) ON [UGRLNK].sourceRole_ID = UROL.ID and urol.classCode = 'ASSIGNED' AND UROL.metaCode = 'UG_ROWID' 
            AND UROL.statusCode = 'active'
        INNER JOIN T_Attribute [FormAccessAttr] (nolock) ON [UROL].[ID] = [FormAccessAttr].Role_ID and [FormAccessAttr].name = 'FORMACC'
    WHERE (SELECT COUNT(ID) FROM [V_CodeProperty] [VCP] (nolock)  WHERE [VCP].[subjCode_ID] = [FormAccessAttr].[valueCode_ID] AND [VCP].valueBool = 1 AND [VCP].[property] = CAST([FormAccessAttr].[ID] AS Varchar(50))) > 0
