CREATE VIEW [AtlasInternal].[VIEW_NCM_EpiContacts_LTBI]
AS

SELECT  
	VIEW_SUB_EPICONT.Patient_FK AS LTBITREAT_Patient_FK,
	VIEW_SUB_EPICONT.Service_FK AS LTBITREAT_Case_FK,
	VIEW_SUB_EPICONT.ACT_ID AS LTBITREAT_ID,

	VIEW_SUB_EPICONT.ACT_effectivetime_Beg AS LTBITREAT_Date,
	VIEW_SUB_EPICONT.ACT_EffectiveTime_Dur AS LTBITREAT_Months,
	case when VIEW_SUB_EPICONT.ACT_statusCode='completed' then 'True' else 'False' end AS LTBITREAT_IsComplete,

	[dbo].MDF_UCS_FullName_UCS_ByUCSId(VIEW_SUB_EPICONT.ACT_code_Id) AS LTBITREAT_Type,
	[dbo].[MDF_UCS_FullName_AttrUCS_ByActId](VIEW_SUB_EPICONT.ACT_ID, 'valueCode_ID', 'LTBITREAT_Where_FK') AS LTBITREAT_Where_FK,
	[dbo].MDF_Act_GetDateValue_ActrelSrcAct_ByTrgActIdMetaClassMoodTypeValueType(VIEW_SUB_EPICONT.ACT_ID, 'LTBITREAT_NextDueDate', 'SEQL', 'effectiveTime_Beg') AS LTBITREAT_NextDueDate,
	VIEW_SUB_EPICONT.ACT_Text AS LTBITREAT_Comments
FROM 
	[AtlasInternal].[VIEW_SUB_NCM_EpiContact] VIEW_SUB_EPICONT 

WHERE
	VIEW_SUB_EPICONT.ACT_classCode = 'SBADM' AND VIEW_SUB_EPICONT.ACT_metaCode = 'LTBITREAT_ID' 
