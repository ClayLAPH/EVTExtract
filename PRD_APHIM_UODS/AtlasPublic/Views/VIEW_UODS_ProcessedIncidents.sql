
CREATE   VIEW [AtlasPublic].[VIEW_UODS_ProcessedIncidents]
AS

SELECT 
[PR_ProcessedRowID],
[PR_Stage_RowID],
[PR_Stage_IncidentID],
[PR_Target_RowID],
[PR_Target_IncidentID],
[PR_DateCreated],
[PR_DateProcessed],
[PR_ImportOptionCode_ID],
[PR_DemographicImportOptionsCode_ID],
[PR_ProcessedOption],
[PR_ProcessedByDR],
[PR_ProcessedBy],
[PR_Target_PER_RowID],
[PR_Target_PER_RootID],
[PR_Stage_PER_RowID],
[PR_PersonName],
[PR_AccessionNumber],
[PR_DiseaseDR],
[PR_Disease],
[PR_Result],
[PR_ResultValue],
[PR_NameSpaceCode],
[PR_ReportSourceDR],
[PR_ReportSource]
FROM [AtlasInternal].[VIEW_UODS_ProcessedIncidents]
