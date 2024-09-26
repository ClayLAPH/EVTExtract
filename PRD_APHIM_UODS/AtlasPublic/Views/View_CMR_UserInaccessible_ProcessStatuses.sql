
CREATE VIEW [AtlasPublic].[View_CMR_UserInaccessible_ProcessStatuses]
AS
    SELECT 
        [E_Entity].[ID] AS [USR_RowID], 
        AttrUserName.[valueString] AS [USR_Login],
        S_UGPS.[UG_ProcessStatusID] AS [USR_Inaccessible_ProcessStatusDR],
        UCSProcessStatusName.[fullName] AS [USR_Inaccessible_ProcessStatus_Name],
        ISNULL([V_TermDictionary].active,0) AS [USR_Inaccessible_ProcessStatus_Active]
    FROM [S_UserGroupInAccessibleProcessStatus] S_UGPS (NOLOCK)
        INNER JOIN [R_RoleLink] RLinkUserGroup (NOLOCK) ON RLinkUserGroup.sourceRole_ID=S_UGPS.[UG_RowID] AND RLinkUserGroup.MetaCode = 'USR_CMRUserGroupDR' AND RLinkUserGroup.typeCode='PART' 
        INNER JOIN [R_Role] (NOLOCK) ON RLinkUserGroup.targetRole_ID=[R_Role].[ID] AND [R_Role].[classCode] = 'AGNT' 
        INNER JOIN [E_Entity] (NOLOCK) ON [R_Role].[player_ID]=[E_Entity].[ID] AND [R_Role].[classCode] = 'AGNT' 
        INNER JOIN [T_Attribute] AttrUserName (NOLOCK) ON [R_Role].[ID]=AttrUserName.[Role_ID] AND  AttrUserName.[type] = 'ST' AND AttrUserName.[name] = 'USER_Username'   
        INNER JOIN [V_UnifiedCodeSet] UCSProcessStatusName (NOLOCK) ON UCSProcessStatusName.ID=S_UGPS.[UG_ProcessStatusID] 
        INNER JOIN [V_Domain] DOM (NOLOCK) ON DOM.ID=UCSProcessStatusName.domain_ID 
        INNER JOIN [V_DictionaryDefinition] DIC (NOLOCK) ON DOM.id=DIC.domain_ID and DIC.[name] = 'IncidentProcessStatus'
        LEFT JOIN [V_TermDictionary] (NOLOCK) ON UCSProcessStatusName.ID=[V_TermDictionary].termCode_ID AND V_TermDictionary.[name]='INCIDENTPROCESSSTATUS'
