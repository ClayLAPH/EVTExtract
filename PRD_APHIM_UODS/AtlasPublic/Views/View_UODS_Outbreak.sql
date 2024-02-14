﻿
CREATE   VIEW [AtlasPublic].[View_UODS_Outbreak]
AS
SELECT 
    [dbo].[DV_Outbreak].[DVOB_RowID] AS [OUTB_RowID],
    [DBO].[A_ACT].[LocalID] as [OUTB_Legacy_RowID],
    [dbo].[V_UnifiedCodeSet].[fullname] AS OUTB_Disease,
    [dbo].[DV_Outbreak].[DVOB_OutbreakNumber] AS [OUTB_OutbreakNumber],
    (SELECT Fullname FROM V_UNIFIEDCODESET UCS (NOLOCK) WHERE
    [dbo].[DV_Outbreak].DVOB_HealthFacilityCode_ID=UCS.ID) AS OUTB_IsHealthFacilityOutbreak,
    ELOCPART.trivialname as [OUTB_OutbreakLocation],
    UCSDISTRICT.FULLNAME AS OUTB_District,
    [dbo].[DV_Outbreak].[DVOB_OnsetDate] AS [OUTB_DateofOnset],
    [dbo].[DV_Outbreak].[DVOB_CreateDate] AS [OUTB_DateCreated],
    [dbo].[DV_Outbreak].[DVOB_ClosedDate] AS [OUTB_DateClosed],
    UCSPROCESSSTATUS.FULLNAME AS OUTB_ProcessStatus,
    UCS.FullName AS OUTB_ResolutionStatus,
    [dbo].[A_Act].[text] as [OUTB_Notes],
    UCSOUTBREAKTYPE.FULLNAME AS OUTB_OutbreakType,
    --- New Fields merged from [VIEWOUTBREAKEXPORT]
    DBO.DV_OUTBREAK.DVOB_OUTBREAKID AS OUTB_OUTBREAKID,     
    DBO.T_ATTRIBUTE.VALUEINTEGER AS OUTB_COUNT,     
    DBO.DV_OUTBREAK.DVOB_USERDR AS OUTB_USERDR,     
    DBO.DV_OUTBREAK.DVOB_HEALTHFACILITYCODE_ID AS OUTB_HEALTHFACILITYCODE_DR,     
    DBO.DV_OUTBREAK.DVOB_DISEASECODE_ID AS OUTB_DISEASECODE_DR,      
    DBO.V_UNIFIEDCODESET.SHORTNAME AS OUTB_DISSHORTNAME, 
    DBO.DV_OUTBREAK.DVOB_LOCATIONDR AS OUTB_LOCATIONDR,     
    DBO.DV_OUTBREAK.DVOB_DISTRICTCODE_ID AS OUTB_DISTRICTCODE_DR,   
    REGION.SPACODE_ID AS OUTB_SPACODE_DR,      --SugannyaB 07/23/2012 Issue#127694 
    DBO.DV_OUTBREAK.DVOB_OUTBREAKTYPECODE_ID AS OUTB_OUTBREAKTYPECODE_DR,     
    DBO.DV_OUTBREAK.DVOB_PROCESSSTATUSCODE_ID AS OUTB_PROCESSSTATUSCODE_DR,    
    DBO.DV_OUTBREAK.DVOB_RESOLUTIONSTATUSCODE_ID AS OUTB_RESOLUTIONSTATUSCODE_DR,    
    ATS.AVAILABILITYTIME AS OUTB_DATESUBMITTED, 
    DBO.FN_DISEASEGROUPS(DBO.DV_OUTBREAK.DVOB_DISEASECODE_ID) AS OUTB_DGRPDR,    
    ISNULL(TENNAME.PARTFAM,'') + ', ' + ISNULL(TENNAME.PARTGIV,'') AS OUTB_USERNAME,  
    (CASE WHEN UCSHEALTHFACILITY.FULLNAME='HEALTH FACILITY' THEN 'TRUE' ELSE 'FALSE' END)  AS OUTB_ISHEALTHFACILITY,  
    UCSLOCATIONTYPE.FULLNAME AS OUTB_LOCATIONTYPE,  
    CASE WHEN isnull(TEALOCADDRESS.PARTSAL,'') = '' THEN '' ELSE 
        (CASE WHEN ISNULL(TEALOCADDRESS.PARTAPTNUM,'') = '' THEN TEALOCADDRESS.PARTSAL ELSE TEALOCADDRESS.PARTSAL + ', ' END) END + 
    CASE WHEN ISNULL(TEALOCADDRESS.PARTAPTNUM,'')='' THEN '' ELSE (TEALOCADDRESS.PARTAPTNUM) END AS OUTB_LOCATIONADDRESS,
    TETLOCPHONE.ADDRESS AS OUTB_LOCATIONPHONE,  
    ISNULL(TENNURSE.PartFam,'') + CASE WHEN TENNURSE.PartGiv IS NULL THEN '' ELSE ', ' END + ISNULL(TENNURSE.PartGiv,'') AS OUTB_NURSEINVESTIGATOR,
    DBO.DV_OUTBREAK.DVOB_NURSEINVESTIGATORDR AS OUTB_NURSEINVESTIGATORDR,
    ATTRIBUTE_EMAIL.VALUESTRING AS OUTB_LOCATIONEMAIL,  
    ATTRIBUTE_PCONTACT.VALUESTRING AS OUTB_LOCATIONPRIMARYCONTACT,  
    UCSCOUNTY.FULLNAME AS OUTB_LOCCOUNTY,  
    UCSLOCDISTRICT.FULLNAME AS OUTB_LOCJURISDICTION,  
    ELOC.CODE_ID AS OUTB_LOCATIONTYPEDR,
    UCSPriority.FullName AS OUTB_PRIORITY,
    REGION.JurisdictionCode AS OUTB_DISTRICTNUMBER,
    TEALOCADDRESS.partCen AS OUTB_LOCATIONCENSUSTRACT,
    TEALOCADDRESS.partCenBlock AS OUTB_LOCATIONCENSUSBLOCK,
    TEALOCADDRESS.partCountyFIPS AS OUTB_LOCATIONCOUNTYFIPS,
    TEALOCADDRESS.partGeoLat AS OUTB_LOCATIONLATITUDE,
    TEALOCADDRESS.partGeoLong AS OUTB_LOCATIONLONGITUDE,
    LOCDISTRICT.JurisdictionCode AS OUTB_LOCATIONDISTRICTNUMBER
FROM [DBO].[DV_OUTBREAK] (NOLOCK)
    INNER JOIN [DBO].[A_ACT](NOLOCK)ON [DBO].[DV_OUTBREAK].[DVOB_ROWID]=[DBO].[A_ACT].[ID]
    INNER JOIN [DBO].[V_UnifiedCodeSet] (NOLOCK)ON [DBO].[V_UNIFIEDCODESET].ID=[DBO].[DV_OUTBREAK].DVOB_DiseaseCode_ID
    LEFT JOIN A_ACT ATS (NOLOCK) ON ATS.ACT_PARENT_ID = A_ACT.ID AND ATS.CLASSCODE = 'OBS' AND ATS.METACODE = 'OB_SUBMITTEDBY'
    LEFT JOIN [DBO].[T_ATTRIBUTE](NOLOCK) ON [DBO].[T_ATTRIBUTE].[ACT_ID]=[DBO].[A_ACT].[ID] AND [DBO].[T_ATTRIBUTE].[NAME]='OB_COUNT' AND [DBO].[T_ATTRIBUTE].[TYPE]='INT'
    LEFT JOIN E_ENTITY EESYSUSER (NOLOCK) ON EESYSUSER.ID=DV_OUTBREAK.DVOB_USERDR  
    LEFT JOIN T_ENTITYNAME TENNAME (NOLOCK) ON TENNAME.ENTITY_ID=EESYSUSER.ID AND TENNAME.USECODE='L'   
    LEFT JOIN V_UNIFIEDCODESET UCSHEALTHFACILITY (NOLOCK) ON UCSHEALTHFACILITY.ID = DBO.DV_OUTBREAK.DVOB_HEALTHFACILITYCODE_ID  
    LEFT JOIN E_ENTITY ELOC(NOLOCK) ON ELOC.ID = [dbo].[DV_Outbreak].[DVOB_LocationDR] AND ELOC.ClassCode = 'PLC' AND ELOC.DeterminerCode = 'INSTANCE' AND ELOC.MetaCode = 'LOC_RowID'
    LEFT JOIN T_ENTITYNAME ELOCPART(NOLOCK) ON ELOCPART.ENTITY_ID = ELOC.ID AND ELOCPART.Metacode='LOC_Name'
    LEFT JOIN V_UNIFIEDCODESET UCSLOCATIONTYPE (NOLOCK) ON UCSLOCATIONTYPE.ID=ELOC.CODE_ID  
    LEFT JOIN T_ENTITYADDRESS TEALOCADDRESS (NOLOCK) ON TEALOCADDRESS.ENTITY_ID = ELOC.ID AND TEALOCADDRESS.USECODE='PHYS'   
    LEFT JOIN T_ENTITYTELECOM TETLOCPHONE (NOLOCK) ON TETLOCPHONE.ENTITY_ID=ELOC.ID AND TETLOCPHONE.SCHEME='TEL' AND TETLOCPHONE.USECODE='PHYS'  
    LEFT JOIN V_UNIFIEDCODESET UCSDISTRICT (NOLOCK) ON UCSDISTRICT.ID = DV_OUTBREAK.DVOB_DISTRICTCODE_ID   
    LEFT JOIN V_UNIFIEDCODESET UCSOUTBREAKTYPE (NOLOCK) ON UCSOUTBREAKTYPE.ID = DV_OUTBREAK.DVOB_OUTBREAKTYPECODE_ID   
    LEFT JOIN V_UNIFIEDCODESET UCSPROCESSSTATUS (NOLOCK) ON UCSPROCESSSTATUS.ID = DV_OUTBREAK.DVOB_PROCESSSTATUSCODE_ID
    LEFT JOIN  V_UNIFIEDCODESET(NOLOCK) UCS on UCS.ID=[DV_Outbreak].DVOB_ResolutionStatusCode_ID   
    LEFT JOIN T_ENTITYNAME TENNURSE (NOLOCK) ON DV_Outbreak.DVOB_NurseInvestigatorDR=TENNURSE.ENTITY_ID  
    LEFT JOIN T_ATTRIBUTE ATTRIBUTE_EMAIL (NOLOCK) ON DBO.DV_OUTBREAK.DVOB_LOCATIONDR=ATTRIBUTE_EMAIL.ENTITY_ID AND ATTRIBUTE_EMAIL.NAME='LOC_Email' AND ATTRIBUTE_EMAIL.[TYPE]='ST'  
    LEFT JOIN T_ATTRIBUTE ATTRIBUTE_PCONTACT (NOLOCK) ON DBO.DV_OUTBREAK.DVOB_LOCATIONDR=ATTRIBUTE_PCONTACT.ENTITY_ID AND ATTRIBUTE_PCONTACT.NAME='LOC_PrimaryContact' AND ATTRIBUTE_PCONTACT.[TYPE]='ST'  
    LEFT JOIN T_ATTRIBUTE ATTRIBUTE_LOCCOUNTY (NOLOCK) ON DBO.DV_OUTBREAK.DVOB_LOCATIONDR=ATTRIBUTE_LOCCOUNTY.ENTITY_ID AND ATTRIBUTE_LOCCOUNTY.NAME='LOC_CountyDR' AND ATTRIBUTE_LOCCOUNTY.[TYPE]='CV'  
    LEFT JOIN V_UNIFIEDCODESET UCSCOUNTY (NOLOCK) ON ATTRIBUTE_LOCCOUNTY.ValueCode_ID=UCSCOUNTY.ID  
    LEFT JOIN T_ATTRIBUTE ATTRIBUTE_LOCDISTRICT (NOLOCK) ON DBO.DV_OUTBREAK.DVOB_LOCATIONDR=ATTRIBUTE_LOCDISTRICT.ENTITY_ID AND ATTRIBUTE_LOCDISTRICT.NAME='LOC_DistrictDR' AND ATTRIBUTE_LOCDISTRICT.[TYPE]='CV'  
    LEFT JOIN V_UNIFIEDCODESET UCSLOCDISTRICT (NOLOCK) ON ATTRIBUTE_LOCDISTRICT.ValueCode_ID=UCSLOCDISTRICT.ID  
    LEFT JOIN V_UNIFIEDCODESET UCSPRIORITY (NOLOCK) ON UCSPRIORITY.ID = DV_OUTBREAK.DVOB_PRIORITYDR    
    LEFT JOIN VCP_DISTRICT REGION (NOLOCK) ON REGION.SUBJCODE_ID = DV_OUTBREAK.DVOB_DISTRICTCODE_ID
    LEFT JOIN VCP_DISTRICT LOCDISTRICT (NOLOCK) ON LOCDISTRICT.SUBJCODE_ID = ATTRIBUTE_LOCDISTRICT.valueCode_ID
