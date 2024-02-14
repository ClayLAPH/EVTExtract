﻿
CREATE VIEW [AtlasPublic].[View_CMR_Get_All_EFC_Details]
AS
------------------------FILE ALBUM--------------------------------
SELECT 
CASE WHEN DVPR.DVPR_RowID IS NOT NULL Then DVPR.DVPR_IncidentID
     WHEN Client.DVPER_RowID  IS NOT NULL Then  Client.DVPER_NCMID 
     WHEN DVOB.DVOB_RowID IS NOT NULL Then DVOB.DVOB_OutbreakID 
     WHEN DVAR.DVAI_RowID IS NOT NULL Then DVAR.DVAI_AnimalReportID 
     WHEN GE.ID IS NOT NULL Then GE.InstanceID END AS [RECORD_ID],
ActRelation.source_ID AS [RECORD_ROWID],
CASE WHEN DVPR.DVPR_RowID IS NOT NULL Then UCS.fullName
     WHEN  Client.DVPER_RowID  IS NOT NULL Then 'Client Record'
     WHEN DVOB.DVOB_RowID IS NOT NULL Then 'Outbreak' 
     WHEN DVAR.DVAI_RowID IS NOT NULL THEN 'Animal Report'
     WHEN GE.ID IS NOT NULL Then 'Group Event' END AS [RECORD_TYPE],
ImgAlbumAct.ID AS [EFC_ROWID],
ImgAlbumAct.title As [EFC_NAME],
'FILE ALBUM' AS [EFC_TYPE],
(CASE WHEN ImgAlbumAct.statusCode ='nullified' Then 'Deleted' Else 'Active' END) as [EFC_STATUS],
TvalueAct.ID AS [EFC_FILE_ROWID],
TvalueAct.valueString_Txt AS [EFC_FILE_NAME],
(CASE WHEN TvalueAct.statusCode='nullified' Then 'Deleted' Else 'Active' END) AS [EFC_FILE_STATUS],
NULL AS [EFC_CASEREPORT_DEF_ID],
InsAlbumAudit.USERID AS [EFC_UPLOADING_USER_ROWID],
InsAlbumAudit.ActionDate AS [EFC_UPLOADING_DATETIME],
(CASE WHEN (ImgAlbumAct.statusCode='nullified' OR ImgAlbumAct.statusCode='TERMINATED') Then DelAlbumAudit.USERID Else NULL END)  AS [EFC_DELETING_USER_ROWID],
(CASE WHEN (ImgAlbumAct.statusCode='nullified' OR ImgAlbumAct.statusCode='TERMINATED') Then DelAlbumAudit.ActionDate Else NULL END) AS [EFC_DELETING_DATETIME],
InsAudit.USERID AS [EFC_FILE_UPLOADING_USER_ROWID],
InsAudit.ActionDate AS [EFC_FILE_UPLOADING_DATETIME],
(CASE WHEN (TvalueAct.statusCode='nullified' OR TvalueAct.statusCode='TERMINATED') Then DelAlbumAudit.USERID Else NULL END) AS [EFC_FILE_DELETING_USER_ROWID],
(CASE WHEN (TvalueAct.statusCode='nullified' OR TvalueAct.statusCode='TERMINATED') Then DelImgAudit.ActionDate  Else NULL END) AS [EFC_FILE_DELETING_DATETIME]
FROM A_Act CaseAct (NOLOCK)
INNER JOIN A_ActRelationship ActRelation (NOLOCK) ON CaseAct.ID = ActRelation.source_ID AND ActRelation.typeCode = 'pert' 
    AND CaseAct.statusCode <> 'NULLIFIED' AND CaseAct.statusCode<>'TERMINATED'
INNER JOIN A_Act ImgAlbumAct (NOLOCK) ON ImgAlbumAct.ID = ActRelation.target_ID AND ImgAlbumAct.metaCode='IMGALB_RowID' AND ImgAlbumAct.classCode = 'CATEGORY' 
INNER JOIN A_Act TvalueAct (NOLOCK) ON TvalueAct.Act_Parent_ID = ImgAlbumAct.ID AND TvalueAct.metaCode='IMG_RowID'
LEFT JOIN DV_PHPersonalRecord DVPR (NOLOCK) ON DVPR.DVPR_RowID = CaseAct.ID
LEFT JOIN DV_Person DVPerson (NOLOCK) ON DVPerson.DVPER_RowID = DVPR.DVPR_PersonDR
LEFT JOIN S_LINK SL (NOLOCK) ON SL.Act1_ID = CaseAct.ID  and SL.name ='Patient-Case' 
LEFT JOIN DV_Person Client (NOLOCK) ON Client.DVPER_RowID = SL.Entity1_ID  AND Client.DVPER_RowID = SL.Entity1_ID 
LEFT JOIN V_UnifiedCodeSet UCS (NOLOCK) ON UCS.ID = DVPR.DVPR_TypeDR
LEFT JOIN DV_Outbreak DVOB (NOLOCK) ON DVOB.DVOB_RowID = CaseAct.ID
LEFT JOIN DV_AnimalReport DVAR (NOLOCK) ON DVAR.DVAI_RowID = CaseAct.ID
LEFT JOIN Ax_GroupEvent GE (NOLOCK) ON GE.ID = CaseAct.ID
LEFT JOIN dbo.TVFN_GET_AUDIT_TRANS_BY_NameAndAction('','FC_Image','Insert') As InsAudit ON InsAudit.InstanceID=TvalueAct.ID
LEFT JOIN dbo.TVFN_GET_AUDIT_TRANS_BY_NameAndAction('','FC_Image','Delete') As DelImgAudit ON DelImgAudit.InstanceID=TvalueAct.ID
LEFT JOIN dbo.TVFN_GET_AUDIT_TRANS_BY_NameAndAction('','FC_ImageAlbum','Delete') As DelAlbumAudit ON DelAlbumAudit.InstanceID=ImgAlbumAct.ID
LEFT JOIN dbo.TVFN_GET_AUDIT_TRANS_BY_NameAndAction('','FC_ImageAlbum','Insert') As InsAlbumAudit ON InsAlbumAudit.InstanceID=ImgAlbumAct.ID 
WHERE (
(DVPerson.DVPER_RowID IS NOT NULL AND (DVPerson.DVPER_NamespaceCode_ID IS NULL) OR 
    (DVPerson.DVPER_NamespaceCode_ID = [dbo].[MDF_UCS_GETID_UCSVDOMAIN_BYDOMAINOIDCONCEPTCODE]('2.16.840.1.113883.3.33.4.2.2.5.450','ELR') 
    AND DVPerson.DVPER_ImportOptionsCode_ID = [dbo].[MDF_UCS_GETID_UCSVDOMAIN_BYDOMAINOIDCONCEPTCODE]('2.16.840.1.113883.3.33.4.2.2.5.451','PDI'))) 
OR (DVAR.DVAI_RowID IS NOT NULL AND DVAR.DVAI_NamespaceCode_ID IS NULL)
OR (DVOB.DVOB_RowID IS NOT NULL OR GE.ID IS NOT NULL)
OR (Client.DVPER_RowID IS NOT NULL OR Client.DVPER_NamespaceCode_ID  IS NULL)
)
------------------------CASE REPORT--------------------------------
UNION ALL
SELECT 
CASE WHEN DVPR.DVPR_RowID IS NOT NULL Then DVPR.DVPR_IncidentID
     WHEN Client.DVPER_RowID  IS NOT NULL Then  Client.DVPER_NCMID 
     WHEN DVOB.DVOB_RowID IS NOT NULL Then DVOB.DVOB_OutbreakID 
     WHEN DVAR.DVAI_RowID IS NOT NULL Then DVAR.DVAI_AnimalReportID 
     WHEN GE.ID IS NOT NULL Then GE.InstanceID END AS [RECORD_ID],
ActRelation.source_ID AS [RECORD_ROWID],
CASE WHEN DVPR.DVPR_RowID IS NOT NULL Then UCS1.fullName 
     WHEN  Client.DVPER_RowID  IS NOT NULL Then 'Client Record'
     WHEN DVOB.DVOB_RowID IS NOT NULL Then 'Outbreak' 
     WHEN DVAR.DVAI_RowID IS NOT NULL THEN 'Animal Report'
     WHEN GE.ID IS NOT NULL Then 'Group Event' END AS [RECORD_TYPE],
DOCBODYAct.ID AS  [EFC_ROWID],
ISNULL(DOCBODYAct.valueString_Txt,UCS.fullName) As [EFC_NAME],
'CASE REPORT' AS [EFC_TYPE],
(CASE WHEN DOCBODYAct.statusCode ='nullified' Then 'Deleted' Else 'Active' END) AS [EFC_STATUS],
NULL AS [EFC_FILE_ROWID],
NULL AS [EFC_FILE_NAME],
NULL AS [EFC_FILE_STATUS],
VCPUDF.SubjCode_ID AS [EFC_CASEREPORT_DEF_ID],
InsAudit.USERID AS [EFC_UPLOADING_USER_ROWID],
InsAudit.ActionDate AS [EFC_UPLOADING_DATETIME],
DelAudit.USERID AS [EFC_DELETING_USER_ROWID],
DelAudit.ActionDate AS [EFC_DELETING_DATETIME],
NULL AS [EFC_FILE_UPLOADING_USER_ROWID],
NULL AS [EFC_FILE_UPLOADING_DATETIME],
NULL AS [EFC_FILE_DELETING_USER_ROWID],
NULL AS [EFC_FILE_DELETING_DATETIME]
FROM A_Act CaseAct (NOLOCK)
INNER JOIN A_ActRelationship ActRelation (NOLOCK) ON CaseAct.ID = ActRelation.source_ID 
    AND CaseAct.statusCode <> 'NULLIFIED' AND CaseAct.statusCode<>'TERMINATED'
INNER JOIN A_Act DOCBODYAct (NOLOCK) ON DOCBODYAct.ID = ActRelation.target_ID AND DOCBODYAct.statusCode <> 'terminated'
INNER JOIN VCP_UDForm VCPUDF (NOLOCK) ON VCPUDF.SubjCode_ID = DOCBODYAct.Code_ID  AND VCPUDF.FRM_IsTab = 0
INNER JOIN V_UnifiedCodeSet UCS (NOLOCK) ON UCS.ID = VCPUDF.SubjCode_ID
LEFT JOIN DV_PHPersonalRecord DVPR (NOLOCK) ON DVPR.DVPR_RowID = CaseAct.ID
LEFT JOIN DV_Person DVPerson (NOLOCK) ON DVPerson.DVPER_RowID = DVPR.DVPR_PersonDR
LEFT JOIN S_LINK SL (NOLOCK) ON SL.Act1_ID = CaseAct.ID  and SL.name ='Patient-Case' 
LEFT JOIN DV_Person Client (NOLOCK) ON Client.DVPER_RowID = SL.Entity1_ID  AND Client.DVPER_RowID = SL.Entity1_ID 
LEFT JOIN V_UnifiedCodeSet UCS1 (NOLOCK) ON UCS1.ID = DVPR.DVPR_TypeDR
LEFT JOIN DV_Outbreak DVOB (NOLOCK) ON DVOB.DVOB_RowID = CaseAct.ID
LEFT JOIN DV_AnimalReport DVAR (NOLOCK) ON DVAR.DVAI_RowID = CaseAct.ID
LEFT JOIN Ax_GroupEvent GE (NOLOCK) ON GE.ID = CaseAct.ID
LEFT JOIN S_AuditMain InsAudit (NOLOCK) ON InsAudit.InstanceID= cast(DOCBODYAct.ID as varchar(100)) AND InsAudit.sqlAction='Insert'
LEFT JOIN S_AuditMain DelAudit (NOLOCK) ON DelAudit.InstanceID=cast(DOCBODYAct.ID as varchar(100)) AND DelAudit.sqlAction='Delete'
WHERE(
(DVPerson.DVPER_RowID IS NOT NULL AND (DVPerson.DVPER_NamespaceCode_ID IS NULL) OR 
    (DVPerson.DVPER_NamespaceCode_ID = [dbo].[MDF_UCS_GETID_UCSVDOMAIN_BYDOMAINOIDCONCEPTCODE]('2.16.840.1.113883.3.33.4.2.2.5.450','ELR') 
    AND DVPerson.DVPER_ImportOptionsCode_ID = [dbo].[MDF_UCS_GETID_UCSVDOMAIN_BYDOMAINOIDCONCEPTCODE]('2.16.840.1.113883.3.33.4.2.2.5.451','PDI'))) 
OR (DVAR.DVAI_RowID IS NOT NULL AND DVAR.DVAI_NamespaceCode_ID IS NULL)
OR (DVOB.DVOB_RowID IS NOT NULL OR GE.ID IS NOT NULL)
OR (Client.DVPER_RowID IS NOT NULL OR Client.DVPER_NamespaceCode_ID  IS NULL)
)
UNION ALL
------------------------WEB/EHR --------------------------------
SELECT 
DVPR.DVPR_IncidentID AS [RECORD_ID],
DVPR.DVPR_RowID AS [RECORD_ROWID],
UCS.fullName AS [RECORD_TYPE],
PR.StageRecord_ID AS [EFC_ROWID],
CASE WHEN PR.StageInstanceID = DVPR.DVPR_IncidentID THEN dbo.FN_GetUCSFullName(DVPR.DVPR_DiseaseCode_ID) ELSE DILR_Act.title END  As [EFC_NAME],
CASE WHEN PR.StageInstanceID = DVPR.DVPR_IncidentID THEN PR.ReportedByNamespace + ' CASE'
ELSE PR.ReportedByNamespace + ' REPORT' END AS [EFC_TYPE],
'Active' AS [EFC_STATUS],
NULL AS [EFC_FILE_ROWID],
NULL AS [EFC_FILE_NAME],
NULL AS [EFC_FILE_STATUS],
NULL AS [EFC_CASEREPORT_DEF_ID],
PR.ImportedByUserDr AS [EFC_UPLOADING_USER_ROWID],
PR.DateProcessed AS [EFC_UPLOADING_DATETIME],
NULL AS [EFC_DELETING_USER_ROWID],
NULL AS [EFC_DELETING_DATETIME],
NULL AS [EFC_FILE_UPLOADING_USER_ROWID],
NULL AS [EFC_FILE_UPLOADING_DATETIME],
NULL AS [EFC_FILE_DELETING_USER_ROWID],
NULL AS [EFC_FILE_DELETING_DATETIME]
FROM DV_PHPersonalRecord DVPR (NOLOCK)
INNER JOIN S_ProcessedPRRecord PR (NOLOCK) ON PR.OriginalLiveRecord_ID = DVPR.DVPR_RowID AND PR.StatusCode = 'active' AND PR.ReportedByNamespace IN ('WEB', 'EHR')
INNER JOIN V_UnifiedCodeSet UCSNamespace (NOLOCK) ON UCSNamespace.ID = PR.[NamespaceCode_ID] AND UCSNamespace.conceptCode = 'WEB'
LEFT JOIN A_ACT DILR_Act (NOLOCK) ON DILR_Act.Act_Parent_ID = DVPR.DVPR_RowID AND DILR_Act.metaCode = 'DILR_ID' AND 
    CAST(PR.StageRecord_ID AS VARCHAR(200))= DILR_Act.ValueString_Txt
LEFT JOIN V_UnifiedCodeSet UCS (NOLOCK) ON UCS.ID = DVPR.DVPR_TypeDR
UNION ALL

SELECT 
DVPR.DVPR_IncidentID AS [RECORD_ID],
DVPR.DVPR_RowID AS [RECORD_ROWID],
UCS.fullName AS [RECORD_TYPE],
PR.StageRecord_ID AS [EFC_ROWID],
CASE WHEN PR.StageInstanceID = DVPR.DVPR_IncidentID THEN dbo.FN_GetUCSFullName(DVPR.DVPR_DiseaseCode_ID) ELSE DILR_Act.title END  As [EFC_NAME],
CASE WHEN PR.StageInstanceID = DVPR.DVPR_IncidentID THEN PR.ReportedByNamespace + ' CASE'
ELSE PR.ReportedByNamespace + ' REPORT' END AS [EFC_TYPE],
'Active' AS [EFC_STATUS],
NULL AS [EFC_FILE_ROWID],
NULL AS [EFC_FILE_NAME],
NULL AS [EFC_FILE_STATUS],
NULL AS [EFC_CASEREPORT_DEF_ID],

PR.ImportedByUserDr AS [EFC_UPLOADING_USER_ROWID],

PR.DateProcessed AS [EFC_UPLOADING_DATETIME],

NULL AS [EFC_DELETING_USER_ROWID],

NULL AS [EFC_DELETING_DATETIME],

NULL AS [EFC_FILE_UPLOADING_USER_ROWID],

NULL AS [EFC_FILE_UPLOADING_DATETIME],

NULL AS [EFC_FILE_DELETING_USER_ROWID],

NULL AS [EFC_FILE_DELETING_DATETIME]

FROM DV_PHPersonalRecord DVPR (NOLOCK)

INNER JOIN S_ProcessedPRRecord PR (NOLOCK) ON PR.currentliverecord_id = DVPR.DVPR_RowID AND PR.StatusCode = 'active' AND PR.ReportedByNamespace IN ('WEB', 'EHR')
INNER JOIN V_UnifiedCodeSet UCSNamespace (NOLOCK) ON UCSNamespace.ID = PR.[NamespaceCode_ID] AND UCSNamespace.conceptCode = 'WEB'
LEFT JOIN A_ACT DILR_Act (NOLOCK) ON DILR_Act.Act_Parent_ID = DVPR.DVPR_RowID AND DILR_Act.metaCode = 'DILR_ID' AND 
    CAST(PR.StageRecord_ID AS VARCHAR(200))= DILR_Act.ValueString_Txt
LEFT JOIN V_UnifiedCodeSet UCS (NOLOCK) ON UCS.ID = DVPR.DVPR_TypeDR
UNION ALL
------------------------Lab Report--------------------------------
SELECT 
DVPR.DVPR_IncidentID AS [RECORD_ID],
DVPR.DVPR_RowID AS [RECORD_ROWID],
'Disease Incident' AS [RECORD_TYPE],
AxLR.DILR_ID AS [EFC_ROWID],
DILR_Act.title As [EFC_NAME],
'LAB REPORT' AS [EFC_TYPE],
'Active' AS [EFC_STATUS],
NULL AS [EFC_FILE_ROWID],
DILR_Act.code_OrTx AS [EFC_FILE_NAME],
NULL AS [EFC_FILE_STATUS],
NULL AS [EFC_CASEREPORT_DEF_ID],
PR.ImportedByUserDr AS [EFC_UPLOADING_USER_ROWID],
DILR_Act.EffectiveTime_Beg AS [EFC_UPLOADING_DATETIME],
NULL AS [EFC_DELETING_USER_ROWID],
NULL AS [EFC_DELETING_DATETIME],
NULL AS [EFC_FILE_UPLOADING_USER_ROWID],
NULL AS [EFC_FILE_UPLOADING_DATETIME],
NULL AS [EFC_FILE_DELETING_USER_ROWID],
NULL AS [EFC_FILE_DELETING_DATETIME]
FROM DV_PHPersonalRecord DVPR (NOLOCK)
INNER JOIN A_ACT DILR_Act (NOLOCK) ON DILR_Act.Act_Parent_ID = DVPR.DVPR_RowID AND DILR_Act.metaCode = 'DILR_ID' AND DILR_Act.valueString_Txt IS NULL
INNER JOIN S_ProcessedPRRecord PR (NOLOCK) ON PR.OriginalLiveRecord_ID = DVPR.DVPR_RowID 
    AND PR.StageRecord_ID = DILR_Act.Act_CaseCmr_ID AND PR.StatusCode = 'active' AND PR.ReportedByNamespace = 'ELR'
INNER JOIN Ax_LabReport AxLR (NOLOCK) ON  AxLR.[DILR_ID] = DILR_Act.ID and AxLR.DILR_IsFromHL7 = 1
UNION ALL
------------------------WEB ANIMAL REPORT--------------------------------
SELECT
DVAILive.DVAI_AnimalReportID AS [RECORD_ID],
DVAILive.DVAI_RowID AS [RECORD_ROWID],
'Animal Report' AS [RECORD_TYPE],
DVAIWeb.DVAI_RowID AS [EFC_ROWID],
UCS.fullName As [EFC_NAME],
'WEB ANIMAL REPORT' AS [EFC_TYPE],
'Active' AS [EFC_STATUS],  
NULL AS [EFC_FILE_ROWID],
NULL AS [EFC_FILE_NAME],
NULL AS [EFC_FILE_STATUS],
NULL AS [EFC_CASEREPORT_DEF_ID],
DVAIWeb.DVAI_UserDR AS [EFC_UPLOADING_USER_ROWID],
DVAIWeb.DVAI_CreateDate AS [EFC_UPLOADING_DATETIME],
NULL AS [EFC_DELETING_USER_ROWID],
NULL AS [EFC_DELETING_DATETIME],
NULL AS [EFC_FILE_UPLOADING_DATETIME],
NULL AS [EFC_FILE_UPLOADING_USER_ROWID],
NULL AS [EFC_FILE_DELETING_USER_ROWID],
NULL AS [EFC_FILE_DELETING_DATETIME]
FROM DV_AnimalReport DVAIWeb (NOLOCK)
INNER JOIN S_Link SLink (NOLOCK) ON SLink.Act1_ID = DVAIWeb.DVAI_RowID AND SLink.name = 'Animal-Case' 
INNER JOIN T_Attribute TA (NOLOCK) ON TA.Entity_ID = SLink.Entity1_ID AND TA.name = 'Namespace_Animal'
INNER JOIN T_AttributeRelationship TAR (NOLOCK) ON TAR.Attribute_ID = TA.ID
INNER JOIN DV_AnimalReport DVAILive (NOLOCK) ON DVAILive.DVAI_RowID = TAR.Act_ID
LEFT JOIN V_UnifiedCodeSet UCS (NOLOCK) ON UCS.ID = DVAIWeb.DVAI_DiseaseCode_ID
UNION ALL
---------------------------------------RVCT REPORT-------------------------------
SELECT
DVPR.DVPR_IncidentID AS [RECORD_ID],
DVPR.DVPR_RowID AS [RECORD_ROWID],
UCS.fullName AS [RECORD_TYPE],
DOCBODYAct.ID AS  [EFC_ROWID],
'RVCT (system)' As [EFC_NAME],
'CASE REPORT' AS [EFC_TYPE],
(CASE WHEN DOCSECT.effectiveTime_End IS NOT NULL Then 'Deleted' Else 'Active' END) AS [EFC_STATUS],
NULL AS [EFC_FILE_ROWID],
NULL AS [EFC_FILE_NAME],
NULL AS [EFC_FILE_STATUS],
[dbo].[MDF_UCS_GETID_UCSVDOMAIN_BYDOMAINOIDCONCEPTCODE]('2.16.840.1.113883.3.33.4.2.4.5.13','RVTM') AS [EFC_CASEREPORT_DEF_ID],
InsAudit.USERID AS [EFC_UPLOADING_USER_ROWID],
InsAudit.ActionDate AS [EFC_UPLOADING_DATETIME],
DelAudit.USERID AS [EFC_DELETING_USER_ROWID],
DelAudit.ActionDate AS [EFC_DELETING_DATETIME],
NULL AS [EFC_FILE_UPLOADING_USER_ROWID],
NULL AS [EFC_FILE_UPLOADING_DATETIME],
NULL AS [EFC_FILE_DELETING_USER_ROWID],
NULL AS [EFC_FILE_DELETING_DATETIME]
FROM A_Act CaseAct (NOLOCK)
INNER JOIN DV_PHPersonalRecord DVPR (NOLOCK) ON DVPR.DVPR_RowID = CaseAct.ID AND dbo.FN_GetUCSFullName(DVPR.DVPR_TypeDR) = 'Disease Incident'
INNER JOIN A_Act DOCBODYAct (NOLOCK) ON DOCBODYAct.Act_CaseCmr_ID = DVPR.DVPR_RowID AND DOCBODYAct.classCode = 'DOCBODY'
INNER JOIN A_Act DOCSECT (NOLOCK) ON DOCSECT.Act_Parent_ID = DOCBODYAct.ID AND DOCSECT.metaCode = 'RVCTPG_ID'
INNER JOIN V_UnifiedCodeSet UCSConceptCode (NOLOCK) ON DOCBODYAct.Code_ID = UCSConceptCode.ID AND UCSConceptCode.conceptCode = 'RVT'
LEFT JOIN S_AuditMain InsAudit (NOLOCK) ON InsAudit.InstanceID= cast(DOCSECT.ID as varchar(100)) AND InsAudit.sqlAction='Insert'
LEFT JOIN S_AuditMain DelAudit (NOLOCK) ON DelAudit.InstanceID=cast(DOCSECT.ID as varchar(100)) AND DelAudit.sqlAction='Delete'
LEFT JOIN V_UnifiedCodeSet UCS (NOLOCK) ON UCS.ID = DVPR.DVPR_TypeDR