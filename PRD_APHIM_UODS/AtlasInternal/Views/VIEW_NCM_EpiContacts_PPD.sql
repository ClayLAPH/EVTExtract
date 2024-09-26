
CREATE VIEW [AtlasInternal].[VIEW_NCM_EpiContacts_PPD]
AS

SELECT  
	VIEW_SUB_EPICONT.Patient_FK AS CONTPPD_Patient_FK,
	VIEW_SUB_EPICONT.Service_FK AS CONTPPD_Case_FK,
	VIEW_SUB_EPICONT.ACT_ID AS CONTPPD_ID,

	VIEW_SUB_EPICONT.ACT_effectivetime_Beg AS CONTPPD_Date,
	VIEW_SUB_EPICONT.ACT_activityTime_Beg AS CONTPPD_Interpreted,
	VIEW_SUB_EPICONT.ACT_valueNumerator AS CONTPPD_Result,
	
	case when [dbo].MDF_UCS_FullName_UCS_ByUCSId(A_Observation.InterpretationCode_ID)='Abnormal' then 'True' else  'False' end AS CONTPPD_IsPositive,
	[dbo].MDF_UCS_FullName_UCS_ByUCSId(A_Observation.MethodCode_ID) AS CONTPPD_Type,
	[dbo].MDF_Attr_GetStringValue_ActAttr_ByActId(VIEW_SUB_EPICONT.ACT_ID, 'valueString', 'CONTPPD_Where') AS CONTPPD_Where,
	[dbo].MDF_Act_GetDateValue_ActrelSrcAct_ByTrgActIdMetaClassMoodTypeValueType(VIEW_SUB_EPICONT.ACT_ID, 'CONTPPD_NextDueDate', 'SEQL', 'effectiveTime_Beg') AS CONTPPD_NextDueDate,
	VIEW_SUB_EPICONT.ACT_Text AS CONTPPD_Comments

FROM 
	dbo.A_Observation (nolock) 
	INNER JOIN [AtlasInternal].[VIEW_SUB_NCM_EpiContact] VIEW_SUB_EPICONT  (nolock) ON VIEW_SUB_EPICONT.ACT_ID = A_Observation.ID 
				AND VIEW_SUB_EPICONT.ACT_classCode = 'OBS' AND VIEW_SUB_EPICONT.ACT_metaCode = 'CONTPPD_ID' 


