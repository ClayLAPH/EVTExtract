
CREATE VIEW [AtlasPublic].[View_CMR_AutoSavedRecords]
AS

SELECT 
CASE V_UnifiedCodeSet.conceptCode WHEN 'GE' then Ax_GroupEvent.InstanceID WHEN 'CR' then [ForCR].extension else T_InstanceIdentifier.extension END AS INSTANCE_ID,
Sys_AutoSavedRecords.RECORDID AS ROW_ID,
DBO.FN_GetUCSFullName(Sys_AutoSavedRecords.RecordType_Code_ID) AS RecordType,
Sys_AutoSavedRecords.RecordType_Code_ID AS RecordTypeDR,
ISNULL(T_EntityName.PARTFAM, '') + ', ' + ISNULL(T_EntityName.PARTGIV, '') AS UserName,
Sys_AutoSavedRecords.USERDR AS UserDR,
Sys_AutoSavedRecords.AUTOSAVEDTIME AS AutoSavedTime
FROM Sys_AutoSavedRecords(NOLOCK)
INNER JOIN A_ACT(NOLOCK) ON A_ACT.ID=Sys_AutoSavedRecords.RECORDID
INNER JOIN T_EntityName(NOLOCK) ON T_EntityName.Entity_ID =Sys_AutoSavedRecords.UserDR 
INNER JOIN V_UnifiedCodeSet(NOLOCK) on  Sys_AutoSavedRecords.RecordType_Code_ID = V_UnifiedCodeSet.ID
LEFT JOIN T_InstanceIdentifier(NOLOCK) ON T_InstanceIdentifier.Act_ID =Sys_AutoSavedRecords.RecordID AND  T_InstanceIdentifier.root IN ('2.16.840.1.113883.3.33.4.2.2.11.1'+ [dbo].[FN_GetSiteID]() +'.1','2.16.840.1.113883.3.33.4.2.2.11.7'+ [dbo].[FN_GetSiteID]() +'.1','2.16.840.1.113883.3.33.4.2.4.11.2'+ [dbo].[FN_GetSiteID]() +'.1')
LEFT JOIN Ax_GroupEvent(NOLOCK) ON Ax_GroupEvent.ID =Sys_AutoSavedRecords.RECORDID 
LEFT JOIN P_Participation(NOLOCK) on A_Act.Act_Parent_ID  = P_Participation.Act_ID and P_Participation.typeCode = 'SBJ'
LEFT JOIN R_Role(NOLOCK) on P_Participation.Role_ID = R_Role.ID and R_Role.classCode = 'PAT'
LEFT JOIN T_InstanceIdentifier(NOLOCK) [ForCR] on R_Role.player_ID = [ForCR].Entity_ID and [ForCR].[root] = '2.16.840.1.113883.3.33.4.2.4.11.2'+ [dbo].[FN_GetSiteID]() +'.1'


