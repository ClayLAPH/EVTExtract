
CREATE VIEW [AtlasPublic].[VIEW_CMR_AR_Vec_FieldMonitoring] AS
SELECT 
		DVAR.DVAI_RowID AS AI_FieldMon_AnimalRowId,
		DVAR.DVAI_AnimalReportID as AI_FieldMon_AnimalID,
		UCSAT.fullname AS AI_FieldMon_Animal_Type,
		UCSSPECIES.fullname AS AI_FieldMon_Species, 
		UCSDISEASE.fullname AS AI_FieldMon_Transmittable_Disease, 
		E_Entity.quantity AS AI_FieldMon_No_of_Animal_Found, 
		ADDFM.partSal AS AI_FieldMon_Vector_Location,
		ADDFM.partAptNum AS AI_FieldMon_Apartment, 
		ADDFM.partCty AS AI_FieldMon_City, 
		ADDFM.partSta AS AI_FieldMon_State, 
		ADDFM.partZip AS AI_FieldMon_Zip, 
		ADDFM.partCen AS AI_FieldMon_Subdivision, 
		ADDFM.partGeoLong AS AI_FieldMon_Longitude, --sarjunan corrected the Spelling
		ADDFM.partGeoLat AS AI_FieldMon_Latitude 
FROM  A_Act (NOLOCK) 
		INNER JOIN S_Link (NOLOCK) ON  A_Act.ID=S_Link.Act2_ID AND   S_Link.name = 'Vector-Case' 
		AND A_Act.classCode = 'COND'  AND A_Act.metaCode = 'ARFM_RowID' AND A_Act.Act_Parent_TypeCode = 'COMP'
		INNER JOIN A_Act ACTANIMAL  (NOLOCK) ON  ACTANIMAL.ID=S_Link.Act1_ID AND ACTANIMAL.metaCode='AI_RowID'
		INNER JOIN DV_AnimalReport DVAR (NOLOCK) ON DVAR.DVAI_RowID=ACTANIMAL.ID
		INNER JOIN E_Entity (NOLOCK) ON  E_Entity.ID=S_Link.Entity2_ID 
		INNER JOIN R_Role ROLEFM (NOLOCK) ON  E_Entity.ID=ROLEFM.player_ID AND ROLEFM.classCode = 'INVSBJ'
		LEFT JOIN T_EntityAddress ADDFM (NOLOCK) ON  ROLEFM.ID=ADDFM.Role_ID AND   ADDFM.useCode = 'TMP' 
		LEFT JOIN V_UnifiedCodeSet UCSSPECIES (NOLOCK) ON UCSSPECIES.ID=E_Entity.code_ID
		LEFT JOIN V_UnifiedCodeSet UCSAT (NOLOCK) ON UCSAT.ID=ROLEFM.code_ID
		LEFT JOIN V_UnifiedCodeSet UCSDISEASE (NOLOCK) ON UCSDISEASE.ID=A_Act.code_ID
WHERE   A_Act.statusCode <> 'nullified' AND A_Act.Act_Parent_TypeCode = 'COMP'


