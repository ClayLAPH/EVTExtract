﻿
CREATE VIEW [AtlasInternal].[VIEW_ClientRecord_FamilyMembers_CMMode]
AS
SELECT 
      DV_PERSON.[DVPER_ROWID] AS FAM_PERSONID,
      FAMROLE.SCOPER_ID AS FAM_PATIENTID,
      DV_PERSON.DVPER_LASTNAME AS FAM_LASTNAME,
      DV_PERSON.DVPER_FIRSTNAME AS FAM_FIRSTNAME,
      T_ENTITYNAME.PARTMID AS FAM_MIDDLENAME,
      T_ENTITYNAME.PARTSFX AS FAM_NAMESUFFIX,
      DV_PERSON.DVPER_NCMID AS FAM_FAMILYMEMBER,
      [DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](FAMROLE.CODE_ID) AS FAM_RELATION,
      ENTITYADDR_FAMADDR.PARTSAL AS FAM_ADDRESS,
      ENTITYADDR_FAMADDR.PARTCTY AS FAM_CITY,
      ENTITYADDR_FAMADDR.PARTSTA AS FAM_STATE,
      ENTITYADDR_FAMADDR.PARTZIP AS FAM_ZIP,
      ENTITYADDR_FAMADDR.PARTCEN AS FAM_CENSUSTRACT,
      DV_PERSON.DVPER_HOMEPHONE AS FAM_HOMEPHONE,
      [DBO].[MDF_ENTTELECOM_ADDRESS_ENTITY_BYENTITYID](SL.Entity2_ID, 'MC', 'TEL') AS FAM_CELLPHONE,
      [DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](DV_PERSON.DVPER_SEXCODE_ID) AS FAM_GENDER,
      DV_PERSON.DVPER_DOB AS [FAM_DOB],
      [DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](DV_PERSON.DVPER_ETHNICITYCODE_ID) AS FAM_ETHNICITY,
      TRY_PARSE(T_InstanceIdentifier.extension AS INT) AS PER_CLIENTID,
      [DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](DV_PERSON.DVPER_RaceCode_ID) AS FAM_RACE,
      [DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](TAL.languageCode_ID) AS FAM_PRIMARYLANGUAGE,
      DV_PERSON.DVPER_Apartment  AS FAM_APARTMENT
FROM
      DBO.DV_PERSON (NOLOCK)        
      INNER JOIN DBO.R_ROLE FAMROLE (NOLOCK) ON  FAMROLE.PLAYER_ID = DV_PERSON.DVPER_ROWID AND FAMROLE.CLASSCODE = 'PRS' AND FAMROLE.STATUSCODE NOT IN ('nullified','terminated')
      INNER JOIN DBO.E_ENTITY ENTITY_PSN (NOLOCK) ON  FAMROLE.SCOPER_ID = ENTITY_PSN.[ID] AND ENTITY_PSN.CLASSCODE = 'PSN'
      INNER JOIN T_InstanceIdentifier (NOLOCK) on   T_InstanceIdentifier.Entity_ID = ENTITY_PSN.ID   and root = '2.16.840.1.113883.3.33.4.2.4.11.2'+ [dbo].[FN_GetSiteID]() +'.1'
      LEFT JOIN T_LanguageCommunication (NOLOCK) TAL ON TAL.Entity_ID = DV_PERSON.[DVPER_ROWID]  AND TAL.metaCode ='PER_PrimaryLanguage_FK'
      LEFT JOIN DBO.T_ENTITYADDRESS ENTITYADDR_FAMADDR (NOLOCK) ON ENTITYADDR_FAMADDR.ENTITY_ID = DV_PERSON.[DVPER_ROWID] AND ENTITYADDR_FAMADDR.USECODE = 'H'
      INNER JOIN S_Link SL (NOLOCK) ON SL.Entity1_ID=DVPER_ROWID AND SL.name='Person-PrimarY' AND SL.tAddress1_ID=ENTITYADDR_FAMADDR.ID
      INNER JOIN DBO.T_ENTITYNAME (NOLOCK) ON  T_ENTITYNAME.ENTITY_ID = SL.Entity2_ID      
WHERE 
      DVPER_ISFAMILYMEMBER = '1'
