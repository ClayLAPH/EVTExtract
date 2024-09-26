﻿
CREATE VIEW [AtlasPublic].[View_CMMode_GroupEvent]
        AS
        SELECT 
        GroupEv.ID AS [GE_RowID],
        GroupEv.InstanceID AS [GE_InstanceID],
        GroupEv.EventNumber AS [GE_EventNumber],
        ACT_GROUP.code_ID AS [GE_TypeDR],
        UCS_TYPE.fullName AS [GE_Type],
        GroupEv.[Description] AS [GE_Description],
        GroupEv.DateofEvent AS [GE_DateofEvent],
        GroupEv.LocationDR AS [GE_LocationDR],
        ENTNAME_LOC.trivialName AS [GE_Location],
        UCS_LOCTYPE.ID AS [GE_LOCATIONTYPEDR],
        UCS_LOCTYPE.fullName AS [GE_LOCATIONTYPE],
        CASE WHEN cast(isnull(ENT_LOCADDR.[partSal],'') as varchar(400)) = '' THEN '' ELSE cast(ENT_LOCADDR.[partSal] as varchar(400)) END + 
 CASE WHEN ISNULL(ENT_LOCADDR.[partAptNum],'') = '' THEN '' ELSE 
    CASE WHEN ISNULL(ENT_LOCADDR.[partSal],'') <> '' THEN ', ' + ENT_LOCADDR.[partAptNum] ELSE  ENT_LOCADDR.[partAptNum] END END +  
 CASE WHEN ISNULL(ENT_LOCADDR.[partCty],'') = '' THEN '' ELSE 
    CASE WHEN ISNULL(ENT_LOCADDR.[partSal],'') <> '' OR ISNULL(ENT_LOCADDR.[partAptNum],'') <> '' THEN ', ' + ENT_LOCADDR.[partCty] ELSE  ENT_LOCADDR.[partCty] END END +
 CASE WHEN ISNULL(ENT_LOCADDR.[partSta],'') = '' THEN '' ELSE 
    CASE WHEN ISNULL(ENT_LOCADDR.[partSal],'') <> '' OR ISNULL(ENT_LOCADDR.[partAptNum],'') <> '' OR ISNULL(ENT_LOCADDR.[partCty],'') <> '' THEN ', ' + ENT_LOCADDR.[partSta] ELSE  ENT_LOCADDR.[partSta] END END +  
 CASE WHEN ISNULL(ENT_LOCADDR.[partZip],'') = '' THEN '' ELSE 
    CASE WHEN (ISNULL(ENT_LOCADDR.[partSal],'') <> '' OR ISNULL(ENT_LOCADDR.[partAptNum],'') <> '' OR ISNULL(ENT_LOCADDR.[partCty],'') <> '' OR ISNULL(ENT_LOCADDR.[partSta],'') <> '') THEN ', ' + ENT_LOCADDR.[partZip] ELSE  ENT_LOCADDR.[partZip] END END  AS [GE_LocationAddress],
        ENT_LOCPHONE.[address] AS [GE_LocationPhone],
        ATTRIBUTE_EMAIL.VALUESTRING AS [GE_LocationEmail], 
        ATTRIBUTE_PCONTACT.VALUESTRING AS [GE_LocationPrimaryContact],
        UCS_LOCCOUNTY.fullName AS [GE_LocationCounty],
        UCS_LOCDIS.fullName AS [GE_LocationDistrict],
        CAST(CONVERT(VARCHAR(10),ACT_GROUP.effectiveTime_Beg,112) AS DATETIME) AS GE_DateCreated,        
        CONVERT(VARCHAR(8),ACT_GROUP.effectiveTime_Beg,108) AS GE_TimeCreated, 
        (CASE WHEN ACT_GROUP.statusCode = 'completed' THEN ACT_GROUP.effectiveTime_End ELSE NULL END) AS [GE_DateClosed],
        GroupEv.DistrictDR AS [GE_DistrictDR],
        UCS_DIS.fullName AS [GE_District],
        REGION.SPACode_ID AS [GE_SPACODE_ID],
        GroupEv.CaseManagerDR AS [GE_CaseManagerDR],    
        isnull(ENT_CASEMANAGER.partFAM,'') +  CASE WHEN ENT_CASEMANAGER.partGIV IS NULL THEN '' ELSE ', ' END + isnull(ENT_CASEMANAGER.partGIV,'') AS [GE_CaseManager], 
        GroupEv.PriorityDR  AS  [GE_PriorityDR],
        UCS_PRIOR.fullName AS [GE_Priority],
        GroupEv.StatusDR AS [GE_StatusDR],  
        UCS_STATUS.fullName AS [GE_Status],    
        ACT_GROUP.[text] AS [GE_Notes],
        GroupEv.[StatusChangeDate] AS [GE_StatusChangeDate]       
        FROM [dbo].[Ax_GroupEvent] GroupEv (NOLOCK)
        INNER JOIN A_Act ACT_GROUP (NOLOCK) ON GroupEv.ID=ACT_GROUP.ID AND Act_Group.classCode = 'TOPIC' AND Act_Group.metaCode = 'GE_RowID' 
        LEFT JOIN V_UnifiedCodeSet UCS_TYPE (NOLOCK) ON UCS_TYPE.ID = ACT_GROUP.code_ID
        LEFT JOIN E_Entity ENT_LOC (NOLOCK) ON ENT_LOC.ID = GroupEv.LocationDR AND ENT_LOC.classCode = 'PLC' AND ENT_LOC.determinerCode = 'INSTANCE' AND ENT_LOC.metaCode='LOC_RowID' 
        LEFT JOIN T_EntityName ENTNAME_LOC (NOLOCK) ON ENTNAME_LOC.Entity_ID = ENT_LOC.ID
        LEFT JOIN V_UNIFIEDCODESET UCS_LOCTYPE (NOLOCK) ON UCS_LOCTYPE.ID=ENT_LOC.CODE_ID
        LEFT JOIN T_ENTITYADDRESS ENT_LOCADDR (NOLOCK) ON ENT_LOCADDR.ENTITY_ID = GroupEv.LocationDR AND ENT_LOCADDR.USECODE='PHYS' 
        LEFT JOIN T_ENTITYTELECOM ENT_LOCPHONE (NOLOCK) ON ENT_LOCPHONE.ENTITY_ID = GroupEv.LocationDR AND ENT_LOCPHONE.SCHEME='TEL' AND ENT_LOCPHONE.USECODE='PHYS' LEFT JOIN T_ATTRIBUTE ATTRIBUTE_EMAIL (NOLOCK) ON GroupEv.LocationDR=ATTRIBUTE_EMAIL.ENTITY_ID AND ATTRIBUTE_EMAIL.NAME='LOC_Email' AND ATTRIBUTE_EMAIL.[TYPE]='ST'  
        LEFT JOIN T_ATTRIBUTE ATTRIBUTE_PCONTACT (NOLOCK) ON GroupEv.LocationDR=ATTRIBUTE_PCONTACT.ENTITY_ID AND ATTRIBUTE_PCONTACT.NAME='LOC_PrimaryContact' AND ATTRIBUTE_PCONTACT.[TYPE]='ST'  
        LEFT JOIN T_ATTRIBUTE ATTRIBUTE_LOCCOUNTY (NOLOCK) ON GroupEv.LocationDR=ATTRIBUTE_LOCCOUNTY.ENTITY_ID AND ATTRIBUTE_LOCCOUNTY.NAME='LOC_CountyDR' AND ATTRIBUTE_LOCCOUNTY.[TYPE]='CV'  
        LEFT JOIN V_UNIFIEDCODESET UCS_LOCCOUNTY (NOLOCK) ON ATTRIBUTE_LOCCOUNTY.ValueCode_ID=UCS_LOCCOUNTY.ID  
        LEFT JOIN T_ATTRIBUTE ATTRIBUTE_LOCDISTRICT (NOLOCK) ON GroupEv.LocationDR=ATTRIBUTE_LOCDISTRICT.ENTITY_ID AND ATTRIBUTE_LOCDISTRICT.NAME='LOC_DistrictDR' AND ATTRIBUTE_LOCDISTRICT.[TYPE]='CV'  
        LEFT JOIN V_UNIFIEDCODESET UCS_LOCDIS (NOLOCK) ON ATTRIBUTE_LOCDISTRICT.ValueCode_ID=UCS_LOCDIS.ID  
        LEFT JOIN V_UnifiedCodeSet UCS_DIS (NOLOCK) ON UCS_DIS.ID = GroupEv.DistrictDR
        LEFT JOIN VCP_District REGION (NOLOCK) ON REGION.SubjCode_ID = GroupEv.DistrictDR
        LEFT JOIN T_EntityName ENT_CASEMANAGER (NOLOCK) ON ENT_CASEMANAGER.Entity_ID = GroupEv.CaseManagerDR
        LEFT JOIN V_UnifiedCodeSet UCS_PRIOR (NOLOCK) ON UCS_PRIOR.ID = GroupEv.PriorityDR
        LEFT JOIN V_UnifiedCodeSet UCS_STATUS (NOLOCK) ON UCS_STATUS.ID = GroupEv.StatusDR
        WHERE ACT_GROUP.statusCode<>'nullified' and ACT_GROUP.statusCode<>'terminated'
