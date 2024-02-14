
CREATE   VIEW [AtlasInternal].[View_UODS_AuditData]
AS

--For Incident,UDSection,ShareAcrossRecordUDSection of Incident
Select PH.DVPR_IncidentID As [RECORD_ID],
       PH.DVPR_RowID As [RECORD_RowID],
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]       
       from S_AuditMain AM WITH(NOLOCK) 
       INNER join DV_PHPersonalRecord PH WITH(NOLOCK) ON CAST(PH.DVPR_RowID AS VARCHAR)=AM.RecordID
       where AM.FormName in ('Incident','UDSection','ShareAcrossRecordUDSection') AND AM.sqlAction in 
              ('Insert', 'Import', 'BatchUpload', 'ImportUtility', 'Merge', 'Update', 'Undelete', 'Unmerge') 
	
	--For Outbreak,ShareAcrossRecordUDSection of Outbreak
UNION ALL
       Select 
       OB.DVOB_OutbreakID As [RECORD_ID],
       OB.DVOB_RowID As [RECORD_RowID],
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
       INNER join DV_Outbreak OB WITH(NOLOCK) ON CAST(OB.DVOB_RowID AS varchar)=AM.RecordID
       where AM.FormName in ( 'Outbreak','ShareAcrossRecordUDSection') AND AM.sqlAction in 
    ('Insert', 'Import', 'ImportUtility', 'Merge', 'Update', 'Undelete', 'Unmerge')

	--For GroupEvent,ShareAcrossRecordUDSection of GroupEvent
UNION ALL
       Select 
       GRP.InstanceID As [RECORD_ID],
       GRP.ID As [RECORD_RowID],
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
       INNER join Ax_GroupEvent GRP WITH(NOLOCK) ON CAST(GRP.ID AS varchar)=AM.RecordID
       where AM.FormName in ('GroupEvent','ShareAcrossRecordUDSection') AND AM.sqlAction in 
    ('Insert', 'Import','ImportUtility', 'Merge', 'Update', 'Undelete', 'Unmerge')

	--For Animalreport,ShareAcrossRecordUDSection of Animalreport
UNION ALL
       Select 
       AR.DVAI_AnimalReportID As [RECORD_ID],
       AR.DVAI_RowID As [RECORD_RowID],
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
       INNER join DV_AnimalReport AR WITH(NOLOCK) ON cast(AR.DVAI_RowID as varchar)=AM.RecordID
       where AM.FormName in ('AnimalReport','ShareAcrossRecordUDSection') AND AM.sqlAction in 
    ('Insert', 'Import', 'Merge', 'Update', 'Undelete', 'Unmerge')

		--For Client
UNION ALL
       Select 
       Person.DVPER_NCMID As [RECORD_ID],
       Person.DVPER_RowID As [RECORD_RowID],
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
       INNER join DV_Person Person WITH(NOLOCK) ON CAST(Person.DVPER_RowID as varchar)=AM.RecordID
       where AM.FormName in ('Client') AND AM.sqlAction in 
    ('Insert', 'Import','BatchUpload', 'ImportUtility', 'Merge', 'Update', 'Undelete', 'Unmerge')


	--UDForm for Incident,CI
UNION ALL
	Select    
	   PH.DVPR_IncidentID AS [RECORD_ID],
	   PH.DVPR_RowID As [RECORD_RowID] , 
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
	   inner join A_Actrelationship ACTREL WITH(NOLOCK) on cast(ACTREL.target_ID as varchar)=AM.RecordID
	   inner join DV_PHPersonalRecord PH WITH(NOLOCK) ON PH.DVPR_RowID =ACTREL.source_ID
	   where AM.FormName = 'UDForm' AND AM.sqlAction in 
    ('Insert', 'Import','BatchUpload', 'ImportUtility', 'Merge', 'Update', 'Undelete', 'Unmerge')

	--UDForm for Outbreak
UNION ALL
	Select    
	   OB.DVOB_OutbreakID AS [RECORD_ID],
	   OB.DVOB_RowID As [RECORD_RowID] , 
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
	   inner join A_Actrelationship ACTREL WITH(NOLOCK) on cast(ACTREL.target_ID as varchar)=AM.RecordID
	   inner join DV_Outbreak OB WITH(NOLOCK) ON OB.DVOB_RowID=ACTREL.source_ID
	   where AM.FormName = 'UDForm' AND AM.sqlAction in 
    ('Insert', 'Import','ImportUtility', 'Merge', 'Update', 'Undelete', 'Unmerge')

	--UDForm for GroupEvent	
UNION ALL
	Select    
	   GRP.InstanceID AS [RECORD_ID],
	   GRP.ID As [RECORD_RowID] , 
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
	   inner join A_Actrelationship ACTREL WITH(NOLOCK) on cast(ACTREL.target_ID as varchar)=AM.RecordID
	   inner join Ax_GroupEvent GRP WITH(NOLOCK) ON GRP.ID =ACTREL.source_ID
	   where AM.FormName = 'UDForm' AND AM.sqlAction in 
    ('Insert', 'Import','ImportUtility', 'Merge', 'Update', 'Undelete', 'Unmerge')

	--UDForm for Animal report
UNION ALL
	Select    
	   AR.DVAI_AnimalReportID AS [RECORD_ID],
	   AR.DVAI_RowID As [RECORD_RowID] , 
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
	   inner join A_Actrelationship ACTREL WITH(NOLOCK) on cast(ACTREL.target_ID as varchar)=AM.RecordID
	   inner join DV_AnimalReport AR WITH(NOLOCK) ON AR.DVAI_RowID=ACTREL.source_ID
	   where AM.FormName ='UDForm' AND AM.sqlAction in 
    ('Insert', 'Import', 'Merge', 'Update','Undelete', 'Unmerge')
	
	--UDForm for Client	
UNION ALL
	Select    
	   Person.DVPER_NCMID As [RECORD_ID],
	   Person.DVPER_RowID As [RECORD_RowID] , 
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
	   inner join A_Actrelationship ACTREL WITH(NOLOCK) on cast(ACTREL.target_ID as varchar)=AM.RecordID
	   inner join A_Act ACT WITH(NOLOCK) on ACT.ID=ACTREL.source_ID
	   inner join A_PublicHealthCase PHCASE WITH(NOLOCK) on PHCASE.ID=ACTREL.source_ID
	   inner join V_UnifiedCodeSet CODE WITH(NOLOCK) on PHCASE.phRecordTypeCode_ID=CODE.ID and CODE.conceptCode='CR'
	   inner join P_Participation Participate WITH(NOLOCK) on Participate.Act_ID=ACT.Act_Parent_ID
	   inner join R_Role Roles WITH(NOLOCK) on Roles.ID=Participate.Role_ID and Roles.classCode='PAT'
	   inner join DV_Person Person WITH(NOLOCK) ON Person.DVPER_RowID=Roles.player_ID
	   where AM.FormName ='UDForm' AND AM.sqlAction in 
    ('Insert', 'Import','BatchUpload', 'ImportUtility', 'Merge', 'Update','Undelete', 'Unmerge')
	
	--UDsection for Incident,CI
UNION ALL
	Select    
       PH.DVPR_IncidentID AS [RECORD_ID],
	   PH.DVPR_RowID As [RECORD_RowID] , 
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
	   inner join A_Act ACT WITH(NOLOCK) on cast(ACT.ID as varchar)=AM.RecordID
	   inner join DV_PHPersonalRecord PH WITH(NOLOCK) ON PH.DVPR_RowID=ACT.Act_Parent_ID
	   where AM.FormName ='UDSection' AND AM.sqlAction in 
    ('Insert', 'Import','BatchUpload', 'ImportUtility', 'Merge', 'Update', 'Undelete', 'Unmerge')	

	--ShareAcrossPersonUDsection for Incident,CI
UNION ALL
	Select    
       PH.DVPR_IncidentID AS [RECORD_ID],
	   PH.DVPR_RowID As [RECORD_RowID] , 
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
	   inner join A_Act ACT WITH(NOLOCK) on cast(ACT.Act_Parent_ID as varchar)=AM.RecordID and classcode='CASE'
	   inner join DV_PHPersonalRecord PH WITH(NOLOCK) ON PH.DVPR_RowID=ACT.ID
	   where AM.FormName ='ShareAcrossPersonUDSection' AND AM.sqlAction in 
    ('Insert', 'Import','BatchUpload', 'ImportUtility', 'Merge', 'Update', 'Undelete', 'Unmerge')
    
	--ShareAcrossPersonUDsection for client
UNION ALL
	Select DISTINCT  
       PH.DVPER_NCMID As [RECORD_ID],
	   PH.DVPER_RowID As [RECORD_RowID] , 
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK)
	   inner join A_Act Act WITH(NOLOCK) on cast(Act.Act_Parent_ID as varchar)=AM.RecordID and classcode='CASE'
	   inner join P_Participation Participate WITH(NOLOCK) on Participate.Act_ID=Act.Act_Parent_ID
	   inner join R_Role Roles WITH(NOLOCK) on Roles.ID=Participate.Role_ID and Roles.classCode='PAT'
	   inner join DV_Person PH WITH(NOLOCK) ON PH.DVPER_RowID=Roles.player_ID
	   where AM.FormName in ('ShareAcrossPersonUDSection') AND AM.sqlAction in 
    ('Insert', 'Import','BatchUpload', 'ImportUtility', 'Merge', 'Update', 'Undelete', 'Unmerge')

	--Add on UDsection for client
UNION ALL
	Select    
       PH.DVPER_NCMID As [RECORD_ID],
	   PH.DVPER_RowID As [RECORD_RowID] , 
	   AM.ID As [AM_RowID],
       AM.RecordID As [AM_RecordID],
       AM.FormName As [AM_FormName],
       AM.TableName As [AM_TableName],
       AM.sqlAction As [AM_ActionType],
       AM.ActionDate As [AM_ActionDate],
       AM.USERID As [AM_UserRowID]
       from S_AuditMain AM WITH(NOLOCK) 
	   inner join A_Act ACT WITH(NOLOCK) on cast(ACT.ID as varchar)=AM.RecordID
	   inner join A_PublicHealthCase PHCASE WITH(NOLOCK) on PHCASE.ID=ACT.ID
	   inner join V_UnifiedCodeSet CODE WITH(NOLOCK) on PHCASE.phRecordTypeCode_ID=CODE.ID and CODE.conceptCode='CR'
	   inner join P_Participation Participate WITH(NOLOCK) on Participate.Act_ID=ACT.Act_Parent_ID
	   inner join R_Role Roles WITH(NOLOCK) on Roles.ID=Participate.Role_ID
	   inner join DV_Person PH WITH(NOLOCK) ON PH.DVPER_RowID=Roles.player_ID
	   where AM.FormName ='UDSection' AND AM.sqlAction in 
    ('Insert', 'Import','BatchUpload', 'ImportUtility', 'Merge', 'Update', 'Undelete', 'Unmerge')

