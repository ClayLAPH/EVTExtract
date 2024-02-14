
CREATE   VIEW [AtlasInternal].[VIEW_UODS_ProcessedIncidents] 
AS

SELECT 
PR.ID AS [PR_ProcessedRowID],
PR.[StageRecord_ID] AS [PR_Stage_RowID],
PR.[StageInstanceID] AS [PR_Stage_IncidentID],
CASE WHEN PR.[CurrentLiveRecord_ID] IS NULL THEN PR.[OriginalLiveRecord_ID] ELSE PR.[CurrentLiveRecord_ID] END AS [PR_Target_RowID],
TARGETEXT.[EXTENSION] AS [PR_Target_IncidentID],
PR.[StageDateCreated] AS [PR_DateCreated],
PR.[DateProcessed] AS [PR_DateProcessed],
PR.[ImportOptionCode_ID] AS [PR_ImportOptionCode_ID],
PR.[DemographicImportOptionsCode_ID] AS [PR_DemographicImportOptionsCode_ID],
REPLACE([DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](PR.[ImportOptionCode_ID]),'LAB', (CASE WHEN PR.ReportedByNamespace='ELR' 
THEN 'Lab' WHEN PR.ReportedByNamespace='WEB' THEN 'Web' WHEN PR.ReportedByNamespace='EHR' THEN 'EHR'  END)) 
+ ISNULL(' and ' + [DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](PR.[DemographicImportOptionsCode_ID]),'') AS [PR_ProcessedOption],
[PR].[ImportedByUserDr] AS [PR_ProcessedByDR],
CASE WHEN (USERNAME.DV_UserID IS NULL ) THEN 'System Process' ELSE USERNAME.DV_LastName + ', ' + USERNAME.DV_FirstName END  AS [PR_ProcessedBy],
PR.[OriginalLivePerson_ID] AS [PR_Target_PER_RowID],
PR.[OriginalLivePersonRoot_ID] AS [PR_Target_PER_RootID],
PR.[StagePerson_ID] AS [PR_Stage_PER_RowID],
PR.[StagePersonLastName] + ', ' + PR.[StagePersonFirstName] AS [PR_PersonName],
(SELECT TOP 1 TITLE FROM A_ACT (NOLOCK) WHERE [ACT_PARENT_ID] = CASEACTSTAGE.ID  AND [METACODE] = 'DILR_ID' ORDER BY ID ASC) AS [PR_AccessionNumber],
[CASEACTSTAGE].[Code_ID] AS [PR_DiseaseDR],
[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID] ([CASEACTSTAGE].[Code_ID] ) AS [PR_Disease],
LIPResultName.[ValueString] AS [PR_Result], 
ATTRLIPRESULTVALUE.[VALUESTRING] AS [PR_ResultValue],
CASE WHEN PR.ReportedByNamespace='ELR' THEN 'ELR' WHEN PR.ReportedByNamespace='EHR' THEN 'EHR' ELSE 'WEB' END AS [PR_NameSpaceCode],
RSEntityName.Entity_ID AS PR_ReportSourceDR,
RSEntityName.TrivialName AS PR_ReportSource
FROM  [S_ProcessedPRRecord] PR (NOLOCK) 
INNER JOIN [A_ACT] CASEACTSTAGE (NOLOCK) ON  CASEACTSTAGE.[ID]=[PR].[StageRecord_ID]
LEFT JOIN [A_ACT] CASEACT (NOLOCK) ON  CASEACT.[ID]=[PR].[OriginalLiveRecord_ID] 
LEFT JOIN V_UnifiedCodeSet UDO (NOLOCK) ON UDO.ID=PR.[DemographicImportOptionsCode_ID] 
LEFT JOIN DV_USER USERNAME (NOLOCK) ON USERNAME.DV_UserID=[PR].[ImportedByUserDr]
LEFT JOIN [T_Attribute] AttrLIPResultValue (NOLOCK) ON  [CASEACTSTAGE].[ID] =AttrLIPResultValue.[Act_ID] AND AttrLIPResultValue.[name] = 'PR_LIPResultValue'
LEFT JOIN [A_ACT] LIPResultName (NOLOCK) ON [CASEACTSTAGE].[ID]=LIPResultName.[ACT_PARENT_ID] AND LIPResultName.METACODE='PR_LIPResultName' AND LIPResultName.CLASSCODE='OBS'
LEFT JOIN T_INSTANCEIDENTIFIER TARGETEXT (NOLOCK) ON TARGETEXT.ACT_ID=(CASE WHEN CurrentLiveRecord_ID IS NULL THEN OriginalLiveRecord_ID ELSE CurrentLiveRecord_ID END) 
AND TARGETEXT.[ROOT]='2.16.840.1.113883.3.33.4.2.2.11.1'+ dbo.[FN_GetSiteID]() +'.1'
LEFT JOIN [P_Participation] (NOLOCK) ON [CASEACTSTAGE].[ID]=P_Participation.[Act_ID] AND P_Participation.TypeCode='REFB' AND P_Participation.Metacode='PR_ReportSourceDR'
LEFT JOIN [R_Role] QUAL (NOLOCK) ON [QUAL].[ID]=P_Participation.[Role_ID] AND QUAL.ClassCode='QUAL'
LEFT JOIN [T_EntityName] RSEntityName (NOLOCK) ON [RSEntityName].[Entity_ID]=QUAL.[Player_ID] AND RSEntityName.UseCode='SRCH' AND RSEntityName.Metacode='RS_HealthCareProvider' 
WHERE PR.Statuscode='active' --Statuscode Filter is required to fetch the active records which are getting displayed in Processed Incidents
