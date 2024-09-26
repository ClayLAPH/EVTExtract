
CREATE VIEW [AtlasInternal].[VIEW_NCM_EpiContacts_ARPE]
AS

SELECT  
	VIEW_SUB_EPICONT.Patient_FK AS ARPE_Patient_FK,
	VIEW_SUB_EPICONT.SERVICE_FK as SERVICE_FK,
	VIEW_SUB_EPICONT.Service_FK AS ARPE_Case_FK,
	VIEW_SUB_EPICONT.ACT_ID AS ARPE_ID,
	
	dbo.MDF_Act_GetBooleanValue_Act_ByParActIdMetaValueType('ARPE_WarrantsEvaluation', VIEW_SUB_EPICONT.ACT_ID, 'valueBool') AS ARPE_WarrantsEvaluation,
	dbo.MDF_Act_GetBooleanValue_Act_ByParActIdMetaValueType('ARPE_Locatable', VIEW_SUB_EPICONT.ACT_ID, 'valueBool') AS ARPE_Locatable,
	dbo.MDF_Act_GetBooleanValue_Act_ByParActIdMetaValueType('ARPE_FullyEvaluated', VIEW_SUB_EPICONT.ACT_ID, 'valueBool') AS ARPE_FullyEvaluated,
	dbo.[MDF_UCS_FullName_ActChildUCS_ByParentActId]('ARPE_Results_FK',VIEW_SUB_EPICONT.ACT_ID,'valueCode_ID') AS ARPE_Results,
	case when Act_TxStarted.StatusCode='completed' then 'True' else (case when  Act_TxStarted.StatusCode='active' then 'False' else null end) end AS ARPE_LTBITxComplete,
	case when Act_TxStarted.MoodCode='EVN' then 'True' else (case when Act_TxStarted.MoodCode='' then 'False' else null end)end AS ARPE_LTBITxStarted,
	[dbo].MDF_UCS_FullName_UCS_ByUCSId(T_ActReason.ReasonCode_ID) AS ARPE_ReasonNotComplete
FROM 
	[AtlasInternal].[VIEW_SUB_NCM_EpiContact] VIEW_SUB_EPICONT
	LEFT JOIN A_Act Act_TxStarted  (nolock) ON Act_TxStarted.Act_Parent_ID =  VIEW_SUB_EPICONT.ACT_ID 
		AND Act_TxStarted.classCode = 'SBADM' AND Act_TxStarted.metaCode = 'ARPE_LTBITxStarted' AND Act_TxStarted.Act_Parent_TypeCode = 'COMP'
	LEFT JOIN T_ActReason (nolock) ON T_ActReason.Act_ID = Act_TxStarted.ID
	
WHERE 
	VIEW_SUB_EPICONT.ACT_classCode = 'DOCSECT' AND VIEW_SUB_EPICONT.ACT_metaCode = 'ARPE_ID' AND VIEW_SUB_EPICONT.ACT_moodCode = 'EVN'

