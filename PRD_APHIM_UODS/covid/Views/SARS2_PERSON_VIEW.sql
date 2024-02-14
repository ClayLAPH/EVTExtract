﻿





CREATE view [covid].[SARS2_PERSON_VIEW]
as


SELECT
    PER.DVPER_ROWID AS PER_ROWID,
    ENTPER.LOCALID AS PER_LEGACY_ROWID,
--    ENTADDRCOUNTRY.PARTCOUNTRY AS PER_COUNTRYOFBIRTHDR,
    ''  AS PER_COUNTRYOFBIRTHDR,
--
    PER.DVPER_CellPhone AS PER_CELLPHONE,
--    [dbo].[MDF_ATTR_GETDATETIMEVALUE_ENTATTR_BYENTITYID](PER.DVPER_ROWID,'VALUETS', 'PER_DATEOFUSARRIVAL') AS PER_DATEOFARRIVAL,
--    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](PER.DVPER_ROWID,'VALUESTRING_TXT','PER_OCCUPATIONLOCATION') AS PER_OCCUPATIONLOCATION,
--    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](PER.DVPER_ROWID,'VALUECODE_ORTX','PER_OCCUPATIONDR') AS PER_OCCUPATIONSPECIFY,
--    ATTOCCSETTING.VALUECODE_ID AS PER_OCCUPATIONSETTINGTYPEDR,
--    ATTOCCSETTING.VALUECODE_ORTX AS PER_OCCUPATIONSETTINGTYPESPECIFY,
    '' AS PER_DATEOFARRIVAL,
    '' AS PER_OCCUPATIONLOCATION,
    '' AS PER_OCCUPATIONSPECIFY,
    '' AS PER_OCCUPATIONSETTINGTYPEDR,
    '' AS PER_OCCUPATIONSETTINGTYPESPECIFY,
--
    PER.DVPER_ROOTID AS PER_ROOTID,
    PER.DVPER_LASTNAME AS PER_LASTNAME,
    PER.DVPER_FIRSTNAME AS PER_FIRSTNAME,
--    ENTNAME.PARTMID AS PER_MIDDLENAME,
    '' AS PER_MIDDLENAME,
--
    PER.DVPER_SSN AS PER_SSN,
    PER.DVPER_HomePhone AS PER_HOMEPHONE,
    PER.DVPER_WorkSchoolPhone AS PER_WORKPHONE,
    PER.DVPER_STREETADDRESS AS PER_STREETADDRESS,
    PER.DVPER_APARTMENT AS PER_APARTMENT,
    PER.DVPER_CITY AS PER_CITY,
    PER.DVPER_STATE AS PER_STATE,
--    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](PER.DVPER_RootID,'VALUESTRING_TXT','PER_StateNumber') AS PER_STATENUMBER,
    '' AS PER_STATENUMBER,
--
    PER.DVPER_ZIP AS PER_ZIP,
    PER.DVPER_NCMID as PER_ClientID,
--    [dbo].[MDF_UCS_FULLNAME_ATTRUCS_BYENTITYID](PER.DVPER_ROWID,'VALUECODE_ID','PER_RESIDENCECOUNTYDR') AS PER_COUNTYOFRESIDENCE,
--    ENTADDR.PARTCEN AS PER_CENSUSTRACT,
--    ENTADDR.PARTGEOLAT AS PER_LATITUDE,
--    ENTADDR.PARTGEOLONG AS PER_LONGITUDE,
--    ENTADDR.USECODE_ORTX AS PER_ADDRESSSTANDARDIZED,
--    ENTADDR.PARTCOUNTYFIPS AS PER_COUNTYFIPS,
--    ENTADDR.PARTCOUNTY AS PER_COUNTY,
--    ENTADDR.PARTCENBLOCK AS PER_CENSUSBLOCK,
--    ENTADDR.PARTZIPPLUS4 AS PER_ZIPPLUS4,
--    ENTADDR.PARTCOUNTRY AS PER_COUNTRY,
--    UCSCOUNTRY.FULLNAME as PER_COUNTRY_NAME,
    '' AS PER_COUNTYOFRESIDENCE,
    '' AS PER_CENSUSTRACT,
    '' AS PER_LATITUDE,
    '' AS PER_LONGITUDE,
    '' AS PER_ADDRESSSTANDARDIZED,
    '' AS PER_COUNTYFIPS,
    '' AS PER_COUNTY,
    '' AS PER_CENSUSBLOCK,
    '' AS PER_ZIPPLUS4,
    '' AS PER_COUNTRY,
    '' as PER_COUNTRY_NAME,
--
    PER.DVPER_DOB AS PER_DOB,
--    [dbo].[MDF_UCS_FULLNAME_UCS_BYUCSID](PER.DVPER_SEXCODE_ID) AS PER_SEX,
--    [dbo].[MDF_UCS_FULLNAME_UCS_BYUCSID](PER.DVPER_RACECODE_ID) AS PER_RACE,
--    [dbo].[MDF_UCS_FULLNAME_UCS_BYUCSID](PER.DVPER_ETHNICITYCODE_ID) AS PER_ETHNICITY,
--    [dbo].[MDF_UCS_FULLNAME_UCS_BYUCSID](PER.DVPER_OCCUPATIONCODE_ID) AS PER_OCCUPATION,
    '' AS PER_SEX,
    '' AS PER_RACE,
    '' AS PER_ETHNICITY,
    '' AS PER_OCCUPATION,
--
    PER.DVPER_SEXCODE_ID AS PER_SEXCODE_DR,
    PER.DVPER_RACECODE_ID AS PER_RACECODE_DR,
    PER.DVPER_ETHNICITYCODE_ID AS PER_ETHNICITYCODE_DR,
    PER.DVPER_OCCUPATIONCODE_ID AS PER_OCCUPATIONCODE_DR,
--    ENTNAME.PARTSFX AS PER_NAMESUFFIX,
    '' AS PER_NAMESUFFIX,
--
    CASE UCSNAME.CONCEPTCODE
        WHEN 'ELR' THEN 'LAB INTERFACE'
        WHEN 'WEB' THEN 'WEB INTERFACE'
        ELSE 'MAIN INTERFACE'
    END AS PER_RECORDCREATEDBY,
    SCHOOL_LOC_NAME.TRIVIALNAME AS PER_WORKSCHOOLLOCATION,
--    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](ENTPER.ID,'VALUESTRING','PER_WorkSchoolContact') AS PER_WORKSCHOOLCONTACT,
--    TLANG.LANGUAGECODE_ID AS PER_PRIMARYLANGUAGE_DR,
--    [dbo].[MDF_UCS_FULLNAME_UCS_BYUCSID](TLANG.LANGUAGECODE_ID) AS PER_PRIMARYLANGUAGE,
--    [LAC].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID]((CASE WHEN  S_Link.ID IS NOT NULL THEN S_Link.Entity2_ID ELSE PER.DVPER_RowID END),'VALUESTRING','PSNID_EMAILID') AS PER_EMAIL,
--    [LAC].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID]((CASE WHEN  S_Link.ID IS NOT NULL THEN S_Link.Entity2_ID ELSE PER.DVPER_RowID END),'VALUESTRING','PSNID_ELECTRONICCONTACT') AS PER_ELECTRONICCONTACT,
    '' AS PER_WORKSCHOOLCONTACT,
    '' AS PER_PRIMARYLANGUAGE_DR,
    '' AS PER_PRIMARYLANGUAGE,
    '' AS PER_EMAIL,
    '' AS PER_ELECTRONICCONTACT,
--
    CASE WHEN PER.DVPER_ROWID=PER.DVPER_ROOTID THEN 'Y' ELSE 'N' END AS PER_CURRENTVERSION
FROM DBO.DV_PERSON(NOLOCK) AS PER
    INNER JOIN DBO.E_ENTITY ENTPER (NOLOCK) ON PER.DVPER_ROWID = ENTPER.[ID]
    LEFT OUTER JOIN R_ROLE(NOLOCK) R_LOCE ON R_LOCE.player_id=ENTPER.[ID] AND R_LOCE.classCode='LOCE' AND R_LOCE.metaCode='PER_WorkSchoolLocationDR'
    LEFT OUTER JOIN T_ENTITYNAME(NOLOCK) SCHOOL_LOC_NAME ON R_LOCE.Scoper_ID=SCHOOL_LOC_NAME.Entity_ID AND SCHOOL_LOC_NAME.metaCode='LOC_Name' AND SCHOOL_LOC_NAME.useCode='SRCH'
    LEFT JOIN DBO.V_UNIFIEDCODESET UCSNAME (NOLOCK) ON  PER.DVPER_NAMESPACECODE_ID = UCSNAME.ID
    LEFT JOIN DBO.V_UNIFIEDCODESET UCSOP (NOLOCK) ON  PER.DVPER_IMPORTOPTIONSCODE_ID = UCSOP.ID
--    LEFT OUTER JOIN dbo.S_Link (NOLOCK) ON S_Link.Name = 'Person-Primary'
--        AND S_Link.Entity1_ID = PER.DVPER_ROWID
--    LEFT OUTER JOIN dbo.T_EntityAddress ENTADDR (NOLOCK)  ON ENTADDR.Entity_ID=PER.DVPER_ROWID AND ENTADDR.useCode='H'
--        AND ENTADDR.ID = (CASE WHEN S_Link.ID IS NOT NULL THEN S_Link.tAddress1_ID ELSE ENTADDR.ID END)
--    LEFT OUTER JOIN DBO.T_ENTITYNAME ENTNAME (NOLOCK) ON  ENTNAME.ENTITY_ID = (CASE WHEN  S_Link.ID IS NOT NULL THEN S_Link.Entity2_ID ELSE PER.DVPER_RowID END)
--    LEFT JOIN V_UNIFIEDCODESET UCSCOUNTRY (NOLOCK) on ENTADDR.partCountry = UCSCOUNTRY.ID
--    LEFT OUTER JOIN DBO.T_ENTITYADDRESS ENTADDRCOUNTRY (NOLOCK) ON  ENTADDRCOUNTRY.ENTITY_ID = PER.DVPER_ROWID AND ENTADDRCOUNTRY.USECODE = 'BIR'
--    LEFT OUTER JOIN DBO.T_ATTRIBUTE ATTOCCSETTING (NOLOCK) ON  ATTOCCSETTING.ENTITY_ID = PER.DVPER_ROWID AND ATTOCCSETTING.NAME = 'PER_OCCUPATIONSETTINGTYPEDR' AND ATTOCCSETTING.TYPE = 'CV'
--    LEFT OUTER JOIN DBO.T_LANGUAGECOMMUNICATION TLANG (NOLOCK) ON  PER.DVPER_ROWID = TLANG.ENTITY_ID AND TLANG.METACODE = 'PER_PRIMARYLANGUAGE_FK'
    WHERE ((ISNULL(UCSNAME.CONCEPTCODE,'') = ''
        OR (
            ISNULL(UCSNAME.CONCEPTCODE,'') <> ''
            AND (UCSNAME.CONCEPTCODE <> 'WEB')
            AND ISNULL(UCSOP.CONCEPTCODE,'') <> ''
            AND (UCSOP.CONCEPTCODE NOT IN ('ALR', 'UDL'))
        ))
        AND PER.DVPER_RowID IN (SELECT PR.DVPR_PERSONDR
    FROM [dbo].DV_PHPERSONALRECORD PR (NOLOCK)
    INNER JOIN dbo.DV_Person PER (NOLOCK) ON PER.DVPER_RowID=PR.DVPR_PersonDR
    WHERE PR.DVPR_DiseaseCode_ID = 544041))
