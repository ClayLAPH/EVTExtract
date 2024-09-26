
CREATE VIEW [AtlasPublic].[VIEW_CMR_AR_Vec_VectorPositive] AS
SELECT 
DVAR.DVAI_RowID AS AI_VecPos_AnimalRowId,
DVAR.DVAI_AnimalReportID as AI_VecPos_AnimalID,
UCSAT.fullname AS AI_VecPos_Animal_Type,
UCSSPECIES.fullname AS AI_VecPos_Species,
UCSVECPOS.fullname AS AI_VecPos_Type_Of_Test,
UCSTESTTYPE.fullname AS AI_VecPos_Type_of_sample,
ACTVECPOS.effectiveTime_Beg AS AI_VecPos_Date_Sample_Collected,
ACTVECPOS.activityTime_Beg AS AI_VecPos_Date_Sample_Tested,
UCSTD.fullname AS AI_VecPos_Disease_Tested_For,
UCSTR.fullname AS AI_VecPos_Test_Result,
ADDVECPOS.partSal AS AI_VecPos_Location,
ADDVECPOS.partAptNum AS AI_VecPos_Apartment,
ADDVECPOS.partCty AS AI_VecPos_City,
ADDVECPOS.partSta AS AI_VecPos_State,
ADDVECPOS.partZip AS AI_VecPos_Zip,
ADDVECPOS.partCen AS AI_VecPos_Subdivision,
ADDVECPOS.partGeoLong AS AI_VecPos_Longitude,
ADDVECPOS.partGeoLat AS AI_VecPos_Latitude
FROM DV_AnimalReport DVAR (NOLOCK)
INNER JOIN S_Link  (NOLOCK) ON  S_Link.Act1_ID=DVAR.DVAI_RowID AND S_Link.name = 'Vector-Case'
INNER JOIN  A_Act (NOLOCK) ON S_Link.Act2_ID=A_Act.ID AND A_Act.metaCode = 'ARP_RowID' and A_Act.StatusCode='active'
INNER JOIN E_Entity  (NOLOCK) ON  E_Entity.ID=S_Link.Entity2_ID AND E_Entity.ClassCode='ANM'
INNER JOIN R_Role ROLEVECPOS (NOLOCK) ON  E_Entity.ID=ROLEVECPOS.player_ID AND ROLEVECPOS.classCode = 'INVSBJ'
LEFT JOIN T_EntityAddress ADDVECPOS (NOLOCK) ON  ROLEVECPOS.ID=ADDVECPOS.Role_ID AND   ADDVECPOS.useCode = 'TMP'
LEFT JOIN A_Act ACTVECPOS (NOLOCK) ON  A_Act.ID=ACTVECPOS.Act_Parent_ID AND   ACTVECPOS.classCode = 'OBS' AND ACTVECPOS.metaCode = 'ARP_TestTypeDR' AND ACTVECPOS.moodCode = 'EVN'
LEFT JOIN A_Observation OBSVECPOS (NOLOCK) ON  ACTVECPOS.ID=OBSVECPOS.ID
LEFT JOIN V_UnifiedCodeSet UCSVECPOS (NOLOCK) ON ACTVECPOS.code_ID=UCSVECPOS.ID
LEFT JOIN V_UnifiedCodeSet UCSTESTTYPE (NOLOCK) ON OBSVECPOS.targetSiteCode_ID=UCSTESTTYPE.ID
LEFT JOIN V_UnifiedCodeSet UCSSPECIES (NOLOCK) ON UCSSPECIES.ID=E_Entity.code_ID
LEFT JOIN V_UnifiedCodeSet UCSAT (NOLOCK) ON UCSAT.ID=ROLEVECPOS.code_ID
LEFT JOIN V_UnifiedCodeSet UCSTD (NOLOCK) ON UCSTD.ID=A_Act.code_ID--AK[13DEC2013]:ISSUE#162647: CORRECTED THE JOIN AS PER MAPPING OF 'ARP_TestedDiseaseDR'.
LEFT JOIN V_UnifiedCodeSet UCSTR (NOLOCK) ON UCSTR.ID=OBSVECPOS.interpretationCode_ID

