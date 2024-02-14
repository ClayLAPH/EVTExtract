
CREATE VIEW [AtlasPublic].[View_CMMode_SystemUsers]
AS
    SELECT 
        vSysUser.USR_ROWID AS [USR_ROWID], 
        vSysUser.USR_ROLEID AS [USR_ROLEID],
        vSysUser.USR_LOGIN AS [USR_LOGIN], 
        vSysUser.USR_LASTNAME AS [USR_LASTNAME], 
        vSysUser.USR_FIRSTNAME AS [USR_FIRSTNAME],
        ISNULL([AttrUSRCaseManager].[valueBool],0) AS [USR_CASEMANAGER],
        vSysUser.USR_Active AS [USR_IsActive] ,
        vSysUser.USR_ExternalUser AS [USER_ExternalUser] ,
        vSysUser.USR_PhoneNumber AS [USR_Phone] ,
        vSysUser.USR_Email AS [USR_Email] ,
        vSysUser.USR_ExternalUPN AS [USR_ExternalUPN] ,
        vSysUser.USR_UserGroupDR AS [USR_UserGroupDR],
        vSysUser.USR_PHPersonalRecord_DistrictGroupDR AS [USR_DistrictGroupDR] ,
        vSysUser.USR_GroupEvent_DistrictGroupDR  AS [USR_GroupEventDistrictGroupDR]
    FROM [AtlasPublic].[View_CMR_SystemUsers] [vSysUser]
        LEFT JOIN [T_Attribute] [AttrUSRCaseManager] (NOLOCK) ON [vSysUser].[USR_ROLEID] = [AttrUSRCaseManager].[Role_ID]
            AND [AttrUSRCaseManager].[name] = 'USER_CASEMANAGER' AND [AttrUSRCaseManager].[type] = 'BL'



