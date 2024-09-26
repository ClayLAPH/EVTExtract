
CREATE VIEW [AtlasPublic].[View_CMMode_UserAccessible_ServiceDistricts]
AS
SELECT 
    [USR_ROWID], 
    [USR_LOGIN],
    [USR_ACCESSIBLE_DISTRICTDR]
FROM [AtlasPublic].[View_CMR_UserAccessible_PHPersonalRecordDistricts] 

