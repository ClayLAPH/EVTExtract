
CREATE VIEW [AtlasPublic].[VIEW_CMR_AR_Vet_FoundAnimalInformation] AS
SELECT DISTINCT
DV_AnimalReport.DVAI_RowID AS AI_FAI_AnimalRowId,
DV_AnimalReport.DVAI_AnimalReportID AS AI_FAI_AnimalID,
R_Role.EffectiveTime_Beg    AS AI_FAI_DateAnimalCaptured,
T_EntityAddress.PartSal     AS AI_FAI_Address,
T_EntityAddress.PartAptNum  AS AI_FAI_Apartment,
T_EntityAddress.PartCty     AS AI_FAI_City,
T_EntityAddress.PartSta     AS AI_FAI_State,
T_EntityAddress.PartZip     AS AI_FAI_Zip,
T_EntityAddress.PartCen     AS AI_FAI_SubDivision,
T_EntityAddress.PartGeoLong AS AI_FAI_Longitude,
T_EntityAddress.PartGeoLat  AS AI_FAI_Latitude 
FROM [DV_AnimalReport] (NOLOCK)
INNER JOIN [S_Link] (NOLOCK) ON [S_LINK].[Act1_ID] = DV_AnimalReport.DVAI_RowID AND [S_LINK].[NAME] ='Animal-case'
INNER JOIN  [R_Role] (NOLOCK) ON [S_LINK].[Entity1_ID] = [R_Role].[Player_ID]
INNER JOIN [T_EntityAddress] (NOLOCK) ON [T_EntityAddress].[Role_ID] =[R_Role].[ID] AND [T_EntityAddress].[useCode] = 'TMP' 

