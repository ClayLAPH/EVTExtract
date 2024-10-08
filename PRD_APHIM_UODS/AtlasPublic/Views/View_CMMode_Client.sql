﻿
CREATE VIEW [AtlasPublic].[View_CMMode_Client] 
AS 
    SELECT 
    PER.DVPER_ROWID AS PER_ROWID,
    ENTPER.LOCALID AS PER_LEGACY_ROWID,  
    --NM ISSUE:-51679  
    ENTADDRCOUNTRY.PARTCOUNTRY AS PER_COUNTRYOFBIRTHDR,
    PER.DVPER_CellPhone AS PER_CELLPHONE,
    [dbo].[MDF_ATTR_GETDATETIMEVALUE_ENTATTR_BYENTITYID](PER.DVPER_ROWID,'VALUETS', 'PER_DATEOFUSARRIVAL') AS PER_DATEOFUSARRIVAL,
    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](PER.DVPER_ROWID,'VALUESTRING_TXT','PER_OCCUPATIONLOCATION') AS PER_OCCUPATIONLOCATION,
    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](PER.DVPER_ROWID,'VALUECODE_ORTX','PER_OCCUPATIONDR') AS PER_OCCUPATIONSPECIFY,
    ATTOCCSETTING.VALUECODE_ID AS PER_OCCUPATIONSETTINGTYPEDR,
    ATTOCCSETTING.VALUECODE_ORTX AS PER_OCCUPATIONSETTINGTYPESPECIFY,
    --NM ISSUE:-51679  
    PER.DVPER_ROOTID AS PER_ROOTID,
    PER.DVPER_LASTNAME AS PER_LASTNAME,
    PER.DVPER_FIRSTNAME AS PER_FIRSTNAME,
    ENTNAME.PARTMID AS PER_MIDDLENAME,
    PER.DVPER_SSN AS PER_SSN,
    PER.DVPER_HomePhone AS PER_HOMEPHONE,
    PER.DVPER_WorkSchoolPhone AS PER_WORKPHONE,
    PER.DVPER_STREETADDRESS AS PER_STREETADDRESS,
    PER.DVPER_APARTMENT AS PER_APARTMENT,
    PER.DVPER_CITY AS PER_CITY,
    PER.DVPER_STATE AS PER_STATE,
    PER.DVPER_ZIP AS PER_ZIP,
    PER.DVPER_NCMID as PER_ClientID,--Suroy 138652 11/21/2012
    [dbo].[MDF_UCS_FULLNAME_ATTRUCS_BYENTITYID](PER.DVPER_ROWID,'VALUECODE_ID','PER_RESIDENCECOUNTYDR') AS PER_COUNTYOFRESIDENCE,
    ENTADDR.PARTCEN AS PER_CENSUSTRACT,
    ENTADDR.PARTGEOLAT AS PER_LATITUDE,
    ENTADDR.PARTGEOLONG AS PER_LONGITUDE,
    ENTADDR.USECODE_ORTX AS PER_ADDRESSSTANDARDIZED,
    ENTADDR.PARTCOUNTYFIPS AS PER_COUNTYFIPS,
    ENTADDR.PARTCOUNTY AS PER_COUNTY,
    ENTADDR.PARTCENBLOCK AS PER_CENSUSBLOCK,
    ENTADDR.PARTZIPPLUS4 AS PER_ZIPPLUS4,
    ENTADDR.PARTCOUNTRY AS PER_COUNTRY,
    PER.DVPER_DOB AS PER_DOB,
    [dbo].[MDF_UCS_FULLNAME_UCS_BYUCSID](PER.DVPER_SEXCODE_ID) AS PER_SEX,
    [dbo].[MDF_UCS_FULLNAME_UCS_BYUCSID](PER.DVPER_RACECODE_ID) AS PER_RACE,
    [dbo].[MDF_UCS_FULLNAME_UCS_BYUCSID](PER.DVPER_ETHNICITYCODE_ID) AS PER_ETHNICITY,
    [dbo].[MDF_UCS_FULLNAME_UCS_BYUCSID](PER.DVPER_OCCUPATIONCODE_ID) AS PER_OCCUPATION,
    PER.DVPER_SEXCODE_ID AS PER_SEXCODE_ID,
    PER.DVPER_RACECODE_ID AS PER_RACECODE_ID,
    PER.DVPER_ETHNICITYCODE_ID AS PER_ETHNICITYCODE_ID,
    PER.DVPER_OCCUPATIONCODE_ID AS PER_OCCUPATIONCODE_ID,
    ENTNAME.PARTSFX AS PER_NAMESUFFIX,
    CASE UCSNAME.CONCEPTCODE
        WHEN 'ELR' THEN 'LAB INTERFACE'
        WHEN 'WEB' THEN 'WEB INTERFACE'
        ELSE 'MAIN INTERFACE'
    END AS PER_RECORDCREATEDBY,
    SCHOOL_LOC_NAME.TRIVIALNAME AS PER_WORKSCHOOLLOCATION,
    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](ENTPER.ID,'VALUESTRING','PER_WorkSchoolContact') AS  PER_WORKSCHOOLCONTACT,
    TLANG.LANGUAGECODE_ID AS PER_PRIMARYLANGUAGE_FK,
    [dbo].[MDF_UCS_FULLNAME_UCS_BYUCSID](TLANG.LANGUAGECODE_ID) AS PER_PRIMARYLANGUAGE,
    -- +SKUMAR IssueNbr:110616
    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](SLinkPrimary.Entity2_ID,'VALUESTRING','PSNID_EMAILID') AS  PER_EMAIL,
    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](SLinkPrimary.Entity2_ID,'VALUESTRING','PSNID_ELECTRONICCONTACT') AS  PER_ELECTRONICCONTACT
    -- -SKUMAR IssueNbr:110616
    FROM   DBO.DV_PERSON AS PER (NOLOCK)
    INNER JOIN DBO.E_ENTITY ENTPER (NOLOCK)   ON  PER.DVPER_ROWID = ENTPER.[ID] 
    LEFT JOIN R_ROLE R_LOCE (NOLOCK) ON R_LOCE.player_id=ENTPER.[ID] AND R_LOCE.classCode='LOCE' AND R_LOCE.metaCode='PER_WorkSchoolLocationDR'
    LEFT JOIN T_ENTITYNAME SCHOOL_LOC_NAME (NOLOCK) ON R_LOCE.Scoper_ID=SCHOOL_LOC_NAME.Entity_ID AND SCHOOL_LOC_NAME.metaCode='LOC_Name' AND SCHOOL_LOC_NAME.useCode='SRCH' 
    LEFT JOIN DBO.V_UNIFIEDCODESET UCSNAME (NOLOCK) ON  PER.DVPER_NAMESPACECODE_ID = UCSNAME.ID
    LEFT JOIN DBO.V_UNIFIEDCODESET UCSOP (NOLOCK) ON  PER.DVPER_IMPORTOPTIONSCODE_ID = UCSOP.ID
    LEFT JOIN dbo.S_Link SLinkPrimary (NOLOCK) ON SLinkPrimary.Name = 'Person-Primary'  AND SLinkPrimary.Entity1_ID = PER.DVPER_RootID
    LEFT JOIN DBO.T_ENTITYNAME ENTNAME (NOLOCK) ON  ENTNAME.ENTITY_ID = SLinkPrimary.Entity2_ID
    LEFT JOIN dbo.T_EntityAddress ENTADDR (NOLOCK)  ON ENTADDR.ID=SLinkPrimary.tAddress1_ID
    LEFT JOIN DBO.T_ENTITYADDRESS ENTADDRCOUNTRY (NOLOCK) ON  ENTADDRCOUNTRY.ENTITY_ID = PER.DVPER_ROWID AND ENTADDRCOUNTRY.USECODE = 'BIR'
    LEFT JOIN DBO.T_ATTRIBUTE ATTOCCSETTING (NOLOCK) ON  ATTOCCSETTING.ENTITY_ID = PER.DVPER_ROWID AND ATTOCCSETTING.NAME = 'PER_OCCUPATIONSETTINGTYPEDR' AND ATTOCCSETTING.TYPE = 'CV' 
    ----NM ISSUE:-51679 
    LEFT JOIN DBO.T_LANGUAGECOMMUNICATION TLANG (NOLOCK) ON TLANG.ENTITY_ID = PER.DVPER_ROWID  AND TLANG.METACODE = 'PER_PRIMARYLANGUAGE_FK'
    WHERE  
    ISNULL(UCSNAME.CONCEPTCODE,'') = '' 
    OR 
    (ISNULL(UCSNAME.CONCEPTCODE,'') <> ''  AND (UCSNAME.CONCEPTCODE <> 'WEB') AND ISNULL(UCSOP.CONCEPTCODE,'') <> '' AND (UCSOP.CONCEPTCODE NOT IN ('ALR', 'UDL')))
