
CREATE VIEW [AtlasPublic].[View_CMMode_UserAccessible_SystemUsers]
AS
    SELECT DISTINCT
        [E_Entity].[ID] AS [USR_RowID], AttrUsrName.[valueString] AS [USR_Login],USREntity.ID AS [USR_ACCESSIBLE_USER_DR]
    FROM R_ROLE UGRole (NOLOCK)
        INNER JOIN R_RoleLink UGRLNK (NOLOCK) ON UGRole.ID=UGRLNK.sourceRole_ID
        INNER JOIN R_Role AGNTRole (NOLOCK) ON AGNTRole.ID=UGRLNK.targetRole_ID 
        INNER JOIN [E_Entity] (NOLOCK) ON  [E_Entity].[ID]=[AGNTRole].[player_ID] 
        LEFT JOIN [T_Attribute] AttrUsrName (NOLOCK) ON  AGNTRole.[ID]=AttrUsrName.[Role_ID] AND AttrUsrName.[type] = 'ST' 
            AND AttrUsrName.[name] = 'USER_Username'
        LEFT JOIN T_Attribute SourceDistictGroup (NOLOCK) ON SourceDistictGroup.Role_ID=AGNTRole.ID AND SourceDistictGroup.name='USR_DistrictGroupDR' 
        INNER JOIN T_Attribute AttrCaseManager (NOLOCK) ON AttrCaseManager.Role_ID=AGNTRole.ID AND AttrCaseManager.name='USER_CaseManager'
        CROSS APPLY 
        (        SELECT UGRole.ID AS TargetUG_ID, UGRole.ID AS SourceUG_ID
        UNION 
        SELECT TargetUG_ID, SourceUG_ID FROM 
        DBO.FN_CMM_GetAccessibleUserGroups()  WHERE SourceUG_ID=UGRole.ID)  AccessibleUserGroups 
        INNER JOIN R_Role UG1 (NOLOCK) ON UG1.ID=AccessibleUserGroups.TargetUG_ID
        INNER JOIN R_RoleLink AccUGRoleLNK (NOLOCK) ON UG1.ID=AccUGRoleLNK.sourceRole_ID
        INNER JOIN R_Role AGNT1 (NOLOCK) ON AGNT1.ID=AccUGRoleLNK.targetRole_ID 
        INNER JOIN [E_Entity] (NOLOCK) USREntity ON  USREntity.[ID]=AGNT1.[player_ID] 
        LEFT JOIN [T_Attribute] AttrUsrName1 (NOLOCK) ON  AGNT1.[ID]=AttrUsrName1.[Role_ID] AND AttrUsrName1.[type] = 'ST' 
            AND AttrUsrName1.[name] = 'USER_Username'
        LEFT JOIN T_Attribute TargetDistictGroup (NOLOCK) ON TargetDistictGroup.Role_ID=AGNT1.ID AND TargetDistictGroup.name='USR_DistrictGroupDR' 
        INNER JOIN T_Attribute USRCaseManager (NOLOCK) ON USRCaseManager.Role_ID=AGNT1.ID 
            AND USRCaseManager.name='USER_CaseManager'
    WHERE UGRole.classCode='Assigned' AND UG1.classCode='Assigned' AND AGNTRole.classCode='AGNT' 
        AND AGNT1.classCode='AGNT' AND (SourceDistictGroup.valueCode_ID IS NULL OR SourceDistictGroup.valueCode_ID <=0 OR (SourceDistictGroup.valueCode_ID = TargetDistictGroup.valueCode_ID) OR TargetDistictGroup.valueCode_ID in (SELECT TARGETDISTRICTGROUP_ID FROM DBO.FN_CMM_GetAccessibleDistictGroups(SourceDistictGroup.valueCode_ID)))

