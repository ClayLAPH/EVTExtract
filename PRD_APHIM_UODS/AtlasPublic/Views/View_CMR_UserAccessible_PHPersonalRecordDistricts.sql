
CREATE VIEW [AtlasPublic].[View_CMR_UserAccessible_PHPersonalRecordDistricts]
AS
SELECT 
	[vSysUser].[USR_RowID] [USR_ROWID], 
	[vSysUser].[USR_Login] AS [USR_LOGIN],
	[DISTRICT].DistrictID AS [USR_Accessible_DistrictDR],
	[DISTRICT].DistrictName AS [USR_Accessible_District_Name],
	ISNULL([DISTRICT].DistrictActive,0) AS [USR_Accessible_District_Active] 
FROM 
	[AtlasPublic].View_CMR_SystemUsers [vSysUser] 
	LEFT JOIN [AtlasInternal].[View_CMR_UserAccessible_SubDistrictsWithDistrictGroups] [DISTRICT] 
	ON ISNULL([vSysUser].USR_PHPersonalRecord_DistrictGroupDR,-1) = [DISTRICT].DistrictGroupDR

