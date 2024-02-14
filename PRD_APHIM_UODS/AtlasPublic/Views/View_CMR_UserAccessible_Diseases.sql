
CREATE VIEW [AtlasPublic].[View_CMR_UserAccessible_Diseases]
AS
SELECT 
	[vSysUser].[USR_RowID] AS [USR_ROWID], 
	[vSysUser].[USR_Login] AS [USR_LOGIN],
	ISNULL([DGDISEASE].valueCode_ID, [DISEASE].SubjCode_ID) AS [USR_ACCESSIBLE_DISEASEDR],
	[DISEASENAME].fullName AS [USR_Accessible_Disease_Name],
	[ACTIVE].active AS [USR_Accessible_Disease_Active]	
FROM 
	[AtlasPublic].[View_CMR_SystemUsers] [vSysUser] (NOLOCK)
	LEFT JOIN [T_Attribute] [USRDiseaseGroupDR] (NOLOCK) 
	INNER JOIN [V_CodeProperty] [DGDISEASE] (NOLOCK) ON [DGDISEASE].subjCode_ID = [USRDiseaseGroupDR].valueCode_ID
	ON  [USRDiseaseGroupDR].[Role_ID] = [vSysUser].[USR_RoleID] AND [USRDiseaseGroupDR].[name] = 'USR_DiseaseGroupDR' AND [USRDiseaseGroupDR].[type] = 'CV'
	LEFT JOIN VCP_Disease [DISEASE] (NOLOCK) ON [USRDiseaseGroupDR].ID IS NULL	
	
	LEFT JOIN V_UnifiedCodeSet [DISEASENAME](NOLOCK) ON [DISEASENAME].ID = ISNULL([DGDISEASE].valueCode_ID,[DISEASE].SubjCode_ID)
	LEFT JOIN V_TermDictionary [ACTIVE] (NOLOCK) ON [DISEASENAME].ID = [ACTIVE].termCode_ID AND [ACTIVE].name = 'DISEASE'
