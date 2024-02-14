
CREATE VIEW [AtlasPublic].[View_CMR_WebIncidentReport]
AS
SELECT
[DVPH].[DVPR_RowID] AS [PR_ROWID],
[DVPH].[DVPR_CreateDate] AS [PR_CREATEDATE], 
[DVPH].[DVPR_IncidentID] AS [PR_INSTANCEID], 
[DVPH].[DVPR_DiseaseCode_ID] AS [PR_DISEASEDR],
(CASE WHEN [VCP_Disease].[WebName] IS NULL OR [VCP_Disease].[WebName]='' 
    THEN [UCS_Disease].[fullName] 
    ELSE [VCP_Disease].[WebName] 
END) AS [PR_DISEASE],
[DVPH].[DVPR_PersonDR] AS [PR_PERSONDR],
[DVPER].[DVPER_FirstName] AS [PER_FIRSTNAME],
[DVPER].[DVPER_LastName] AS [PER_LASTNAME],
[DVPER].[DVPER_DOB] AS [PER_DOB],
[DVPH].[DVPR_MRN] as [PR_MRN],
[DVPH].[DVPR_ReportSourceDR] AS [PR_REPORTSOURCEDR],
[TE_RSName].[trivialName] AS [PR_REPORTSOURCE],
[DVPH].[DVPR_UserDR] AS [PR_USERDR],
[DVPH].[DVPR_NameOfSubmitter] AS [PR_SUBMITTEDBY]
FROM [DV_Person] [DVPER](NOLOCK)
 INNER JOIN [DV_PHPersonalRecord] [DVPH] (NOLOCK) ON [DVPER].[DVPER_RowID]=[DVPH].[DVPR_PersonDR]
 INNER JOIN [V_UnifiedCodeSet] [UCS_Namespace] (NOLOCK) ON [DVPER].[DVPER_NamespaceCode_ID] = [UCS_Namespace].ID AND [UCS_Namespace].CONCEPTCODE='WEB'
 INNER JOIN [T_Attribute] [Attr_IsSubmitted] (NOLOCK) ON [DVPH].[DVPR_RowID]=[Attr_IsSubmitted].[Act_ID] AND [Attr_IsSubmitted].[name] = 'PR_IsSubmitted' AND [Attr_IsSubmitted].[valueBool] = 1
 INNER JOIN [V_UnifiedCodeSet] [UCS_Disease] (NOLOCK) ON [UCS_Disease].[ID]=[DVPH].[DVPR_DiseaseCode_ID]
 INNER JOIN [VCP_Disease] [VCP_Disease] (NOLOCK) ON [UCS_Disease].[ID]=[VCP_Disease].[SubjCode_ID]
 LEFT JOIN [T_ENTITYNAME] [TE_RSName] (NOLOCK) ON [DVPH].[DVPR_ReportSourceDR]=[TE_RSName].[Entity_ID]
 
