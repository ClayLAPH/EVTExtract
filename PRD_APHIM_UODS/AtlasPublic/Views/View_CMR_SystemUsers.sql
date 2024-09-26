
CREATE VIEW [AtlasPublic].[View_CMR_SystemUsers]
AS
    SELECT 
        [E_Entity].[ID] AS [USR_RowID], 
        [R_Role].[ID] AS [USR_RoleID],
        AttrUsrName.[valueString] AS [USR_Login], 
        [T_EntityName].[partFAM] AS [USR_LastName], 
        [T_EntityName].[partGIV] AS [USR_FirstName],
        RLinkUserGroup.SourceRole_ID as [USR_UserGroupDR],
        entityUserGroupName.desc_txt as [USR_UserGroup_Name],
        CASE WHEN AttrAccessIncident.[valueBool] IS NULL THEN 0 ELSE AttrAccessIncident.[valueBool] END AS [USR_Access_Incident],
        CASE WHEN AttrAccessOutbreak.[valueBool] IS NULL THEN 0 ELSE AttrAccessOutbreak.[valueBool] END AS [USR_Access_Outbreak],
        CASE WHEN AttrAccessGroupEvent.[valueBool] IS NULL THEN 0 ELSE AttrAccessGroupEvent.[valueBool] END as [USR_Access_GroupEvent],
        CASE WHEN AttrAccessIdenTab.[valueBool] IS NULL THEN 0 ELSE AttrAccessIdenTab.[valueBool] END as [USR_Access_AnimalReport],
        AttrDiseaseGroup.ValueCode_ID as [USR_DiseaseGroupDR],
        UCSDiseaseGroupName.fullName as [USR_DiseaseGroup_Name],
        AttrDistrictGroup.ValueCode_ID as [USR_PHPersonalRecord_DistrictGroupDR],
        UCSDistrictGroupName.fullName [USR_PHPersonalRecord_DistrictGroup_Name],
        AttrOutbreakDistrictGroup.ValueCode_ID [USR_Outbreak_DistrictGroupDR],
        UCSOutbreakDistrictGroupName.fullName as [USR_Outbreak_DistrictGroup_Name],
        AttrGroupEventDistrictGroup.ValueCode_ID as [USR_GroupEvent_DistrictGroupDR],
        UCSGroupEventDistrictGroupName.fullName as [USR_GroupEvent_DistrictGroup_Name],
        AttrAnimalReportDistrictGroup.ValueCode_ID as [USR_AnimalReport_DistrictGroupDR],
        UCSAnimalReportDistrictGroupName.fullName as [USR_AnimalReport_DistrictGroup_Name],
        EntityTelecomPhone.[Address] as [USR_PhoneNumber],
        AttrLDAPAccount.[valueString] as [USR_LDAPAccount], 
        EntityTelecomEmail.[Address] as [USR_Email],
        AttrExternalUPN.[valueString] as [USR_ExternalUPN],
        CASE WHEN AttrUSRExternalUser.[valueBool] IS NULL THEN 0 ELSE AttrUSRExternalUser.[valueBool] END AS [USR_ExternalUser],
        CASE WHEN AttrUSRInvestigator.[valueBool] IS NULL Then 0 ELSE AttrUSRInvestigator.[valueBool] END AS [USR_Investigator],
        CASE WHEN AttrUSRAnimalInvestigator.[valueBool] IS NULL THEN 0 ELSE AttrUSRAnimalInvestigator.[valueBool] END AS [USR_AnimalInvestigator],
        CASE WHEN AttrUSRLocked.[valueBool] IS NULL THEN 0 ELSE AttrUSRLocked.[valueBool] END AS [USR_AccountLocked],
        CASE WHEN AttrUSRActive.[valueBool] IS NULL THEN 0 ELSE AttrUSRActive.[valueBool] END AS [USR_Active]
    FROM [E_Entity] (nolock) 
    INNER JOIN [E_Person] (nolock) ON  [E_Entity].[ID]=[E_Person].[ID] AND [E_Entity].[classCode] = 'PSN' AND [E_Entity].[determinerCode] = 'INSTANCE'
    INNER JOIN [R_Role] (nolock) ON  [E_Entity].[ID]=[R_Role].[player_ID] AND [R_Role].[classCode] = 'AGNT' 
    INNER JOIN [T_EntityName] (nolock) ON  [E_Entity].[ID]=[T_EntityName].[Entity_ID] AND [T_EntityName].[useCode] = 'L'
    LEFT JOIN R_RoleLink RLinkUserGroup (nolock) On RLinkUserGroup.targetRole_ID=[R_Role].[ID] and RLinkUserGroup.MetaCode = 'USR_CMRUserGroupDR' and RLinkUserGroup.typeCode='PART' 
    LEFT JOIN R_Role RoleUserGroup (nolock) on RoleUserGroup.ID=RLinkUserGroup.sourceRole_ID and RoleUserGroup.classCode ='ASSIGNED'
    LEFT JOIN E_Entity entityUserGroupName (nolock) on entityUserGroupName.id=RoleUserGroup.player_ID and entityUserGroupName.metaCode='UG_RowID'
    LEFT JOIN [T_Attribute] AttrUsrName (nolock) ON  [R_Role].[ID]=AttrUsrName.[Role_ID] AND  AttrUsrName.[type] = 'ST' AND AttrUsrName.[name] = 'USER_Username'   
    LEFT JOIN [T_Attribute] AttrAccessIncident (nolock) on RLinkUserGroup.SourceRole_ID=AttrAccessIncident.Role_ID and AttrAccessIncident.name='UG_CanAccessIncident' AND AttrAccessIncident.[type] = 'BL' 
    LEFT JOIN [T_Attribute] AttrAccessOutbreak (nolock) on RLinkUserGroup.SourceRole_ID=AttrAccessOutbreak.Role_ID and AttrAccessOutbreak.name='UG_CanAccessOutbreak' AND AttrAccessOutbreak.[type] = 'BL'
    LEFT JOIN [T_Attribute] AttrAccessGroupEvent (nolock) on RLinkUserGroup.SourceRole_ID=AttrAccessGroupEvent.Role_ID and AttrAccessGroupEvent.name='UG_CanAccessGroupEvent' AND AttrAccessGroupEvent.[type] = 'BL'
    LEFT JOIN [T_Attribute] AttrAccessIdenTab (nolock) on RLinkUserGroup.SourceRole_ID=AttrAccessIdenTab.Role_ID and AttrAccessIdenTab.name='UG_CanAccessIdenTab' AND AttrAccessIdenTab.[type] = 'BL' 
       
    LEFT JOIN [T_Attribute] AttrDiseaseGroup (nolock) ON  [R_Role].[ID]=AttrDiseaseGroup.[Role_ID] AND  AttrDiseaseGroup.[name] = 'USR_DiseaseGroupDR' AND AttrDiseaseGroup.[type] = 'CV' 
    LEFT JOIN V_UnifiedCodeSet UCSDiseaseGroupName (nolock) on UCSDiseaseGroupName.ID=AttrDiseaseGroup.ValueCode_ID
     
    LEFT JOIN [T_Attribute] AttrDistrictGroup (nolock) ON  [R_Role].[ID]=AttrDistrictGroup.[Role_ID] AND  AttrDistrictGroup.[name] = 'USR_DistrictGroupDR' AND AttrDistrictGroup.[type] = 'CV' 
    LEFT JOIN V_UnifiedCodeSet UCSDistrictGroupName (nolock) on UCSDistrictGroupName.ID=AttrDistrictGroup.ValueCode_ID
     
    LEFT JOIN [T_Attribute] AttrOutbreakDistrictGroup (nolock) ON  [R_Role].[ID]=AttrOutbreakDistrictGroup.[Role_ID] AND  AttrOutbreakDistrictGroup.[name] = 'USR_OutbreakDistrictGroupDR' AND AttrOutbreakDistrictGroup.[type] = 'CV' 
    LEFT JOIN V_UnifiedCodeSet UCSOutbreakDistrictGroupName (nolock) on UCSOutbreakDistrictGroupName.ID=AttrOutbreakDistrictGroup.ValueCode_ID 
     
    LEFT JOIN [T_Attribute] AttrGroupEventDistrictGroup (nolock) ON  [R_Role].[ID]=AttrGroupEventDistrictGroup.[Role_ID] AND  AttrGroupEventDistrictGroup.[name] = 'USR_GroupEventDistrictGroupDR' AND AttrGroupEventDistrictGroup.[type] = 'CV' 
    LEFT JOIN V_UnifiedCodeSet UCSGroupEventDistrictGroupName (nolock) on UCSGroupEventDistrictGroupName.ID=AttrGroupEventDistrictGroup.ValueCode_ID 
     
    LEFT JOIN [T_Attribute] AttrAnimalReportDistrictGroup (nolock) ON  [R_Role].[ID]=AttrAnimalReportDistrictGroup.[Role_ID] AND  AttrAnimalReportDistrictGroup.[name] = 'USR_AnimalReportDistrictGroupDR' AND AttrAnimalReportDistrictGroup.[type] = 'CV' 
    LEFT JOIN V_UnifiedCodeSet UCSAnimalReportDistrictGroupName (nolock) on UCSAnimalReportDistrictGroupName.ID=AttrAnimalReportDistrictGroup.ValueCode_ID 
         
    LEFT JOIN [T_EntityTelecom] EntityTelecomPhone (nolock) ON  [E_Entity].[ID]=EntityTelecomPhone.[Entity_ID] AND  EntityTelecomPhone.useCode = 'WP' AND EntityTelecomPhone.scheme = 'TEL'  
    LEFT JOIN [T_Attribute] AttrLDAPAccount (nolock) ON  [R_Role].[ID]=AttrLDAPAccount.[Role_ID] AND  AttrLDAPAccount.[name] = 'USR_LDAPAccount' AND AttrLDAPAccount.[type] = 'ST' 
    LEFT JOIN [T_Attribute] AttrExternalUPN (nolock) ON  [R_Role].[ID]=AttrExternalUPN.[Role_ID] AND  AttrExternalUPN.[name] = 'USR_ExternalUPN' AND AttrExternalUPN.[type] = 'ST' 
    LEFT JOIN [T_EntityTelecom] EntityTelecomEmail (nolock) ON  [E_Entity].[ID]=EntityTelecomEmail.[Entity_ID] AND  EntityTelecomEmail.useCode = 'DIR' AND EntityTelecomEmail.scheme = 'MAILTO'   
    LEFT JOIN [T_Attribute] AttrUSRExternalUser (nolock) ON  [R_Role].[ID]=AttrUSRExternalUser.[Role_ID] AND  AttrUSRExternalUser.[name] = 'USER_ExternalUser' AND AttrUSRExternalUser.[type] = 'BL'
    LEFT JOIN [T_Attribute] AttrUSRInvestigator (nolock) ON  [R_Role].[ID]=AttrUSRInvestigator.[Role_ID] AND  AttrUSRInvestigator.[name] = 'USER_Investigator' AND AttrUSRInvestigator.[type] = 'BL'
    LEFT JOIN [T_Attribute] AttrUSRLocked (nolock) ON  [R_Role].[ID]=AttrUSRLocked.[Role_ID] AND  AttrUSRLocked.[name] = 'USR_AccountLocked' AND AttrUSRLocked.[type] = 'BL' 
    LEFT JOIN [T_Attribute] AttrUSRAnimalInvestigator (nolock) ON  [R_Role].[ID]=AttrUSRAnimalInvestigator.[Role_ID] AND  AttrUSRAnimalInvestigator.[name] = 'USR_AnimalInvestigator' AND AttrUSRAnimalInvestigator.[type] = 'BL'  
    LEFT JOIN [T_Attribute] AttrUSRActive (nolock) ON  [R_Role].[ID]=AttrUSRActive.[Role_ID] AND  AttrUSRActive.[name] = 'USR_CMRIsActive' AND AttrUSRActive.[type] = 'BL'  
    LEFT JOIN [T_Attribute] [AttrSystemUser] (nolock) ON  RoleUserGroup.[ID]=[AttrSystemUser].[Role_ID] AND [AttrSystemUser].[name] = 'UG_DefaultRole' AND [AttrSystemUser].[type] = 'CV' 
    WHERE [AttrSystemUser].valueCode_ID = (SELECT UCS.ID FROM V_UnifiedCodeSet UCS (nolock) INNER JOIN V_Domain DOM (nolock) ON UCS.domain_ID = DOM.ID AND DOM.domainName ='UserViewFilter' AND UCS.conceptCode='VuAll')
    OR RoleUserGroup.scoper_ID IS NULL
