CREATE VIEW [AtlasPublic].[View_CMR_UserAccessible_CaseReports]
AS
    SELECT  [USR_RowID], 
    [USR_LOGIN],
    [USR_ACCESSIBLE_FORMDEF_ID],
    [USR_ACCESSIBLE_FORM_ID],
    [USR_Accessible_Form_Name],
    [USR_Accessible_Form_Active] 
    FROM [AtlasPublic].[View_CMR_UserAccessible_UDFData]
    WHERE [USR_Accessible_Form_IsTab] <> 1 AND [USR_Accessible_Form_InProtocol] <> 1 
