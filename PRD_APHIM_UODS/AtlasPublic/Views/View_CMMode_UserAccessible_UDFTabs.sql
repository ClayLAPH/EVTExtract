
CREATE VIEW [AtlasPublic].[View_CMMode_UserAccessible_UDFTabs]
AS
    SELECT 
    UDFTabs.[USR_RowID] AS [USR_ROWID], 
    UDFTabs.[USR_Login] AS [USR_LOGIN],
    UDFTabs.[USR_ACCESSIBLE_FORMDEF_ID] AS [USR_ACCESSIBLE_FORM_DEF_DR],
    UDFTabs.[USR_ACCESSIBLE_FORM_ID] AS [USR_ACCESSIBLE_FORM_ID],
    UDFTabs.[USR_Accessible_Form_Name] AS [USR_ACCESSIBLE_FORM_NAME]
    FROM [AtlasPublic].[View_CMR_UserAccessible_UDFData] AS UDFTabs
    WHERE [USR_Accessible_Form_IsTab] = 1 

