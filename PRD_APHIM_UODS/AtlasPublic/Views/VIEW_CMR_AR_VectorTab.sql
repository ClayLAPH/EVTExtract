CREATE VIEW [AtlasPublic].[VIEW_CMR_AR_VectorTab] AS
SELECT 
DVAR.[DVAI_RowID] AS [AI_Vec_AnimalRowID], 
DVAR.[DVAI_AnimalReportID] AS [AI_Vec_AnimalID], 
[LPA_A2].[text] AS [AI_Vec_Notes]
FROM DV_AnimalReport DVAR (NOLOCK)
INNER JOIN [A_Act] [LPA_A1] (NOLOCK) ON  DVAR.[DVAI_RowID]=[LPA_A1].[Act_Parent_ID] AND [LPA_A1].[ClassCode] = 'DOCBODY' AND [LPA_A1].[Code_ID] =(Select V_unifiedCodeSet.ID from V_unifiedCodeSet (NOLOCK) inner join v_domain (NOLOCK) on V_unifiedCodeSet.domain_id=v_domain.id AND Domainname='AppForm' and conceptcode='InAnim')
INNER JOIN [A_Act] [LPA_A2] (NOLOCK) ON  [LPA_A1].[ID]=[LPA_A2].[Act_Parent_ID] AND [LPA_A2].[ClassCode] = 'TOPIC' AND [LPA_A2].[Code_ID]=(Select V_unifiedCodeSet.ID from V_unifiedCodeSet (NOLOCK) inner join v_domain (NOLOCK) on V_unifiedCodeSet.domain_id=v_domain.id AND Domainname='AppFormTab' and conceptcode='ArVect' )

