create view internals.Person as
select    
  PER_ROWID = per.DVPER_ROWID,
  PER_LEGACY_ROWID = perEntity.LOCALID,  
  PER_COUNTRYOFBIRTHDR = entityCountry.PARTCOUNTRY,
  PER_CELLPHONE = per.DVPER_CellPhone,
  PER_DATEOFARRIVAL = dateOfUSArrival.attributeDateTime,
  PER_OCCUPATIONLOCATION = occupationLocation.attributeStringTxt,
  PER_OCCUPATIONSPECIFY = occupationSpecify.attributeCodeOrTx,
  PER_OCCUPATIONSETTINGTYPEDR = occupationSetting.valueCode_ID,
  PER_OCCUPATIONSETTINGTYPESPECIFY = occupationSetting.valueCode_OrTx,
  PER_ROOTID = per.DVPER_ROOTID,
  PER_LASTNAME = per.DVPER_LASTNAME,
  PER_FIRSTNAME = per.DVPER_FIRSTNAME,
  PER_MIDDLENAME = entityNames.PARTMID,
  PER_SSN = per.DVPER_SSN,
  PER_HOMEPHONE = per.DVPER_HomePhone,
  PER_WORKPHONE = per.DVPER_WorkSchoolPhone,
  PER_STREETADDRESS = per.DVPER_STREETADDRESS,
  PER_APARTMENT = per.DVPER_APARTMENT,
  PER_CITY = per.DVPER_CITY,
  PER_STATE = per.DVPER_STATE ,
  PER_STATENUMBER = StateNumber.attributeStringTxt,
  PER_ZIP = per.DVPER_ZIP,
  PER_ClientID = per.DVPER_NCMID,
  PER_COUNTYOFRESIDENCE = residenceCountryName.fullName,
  PER_CENSUSTRACT = primaryAddress.PARTCEN,
  PER_LATITUDE = primaryAddress.PARTGEOLAT,
  PER_LONGITUDE = primaryAddress.PARTGEOLONG,
  PER_ADDRESSSTANDARDIZED = primaryAddress.USECODE_ORTX,
  PER_COUNTYFIPS = primaryAddress.PARTCOUNTYFIPS,
  PER_COUNTY = primaryAddress.PARTCOUNTY,
  PER_CENSUSBLOCK = primaryAddress.PARTCENBLOCK,
  PER_ZIPPLUS4 = primaryAddress.PARTZIPPLUS4,
  PER_COUNTRY = primaryAddress.PARTCOUNTRY,
  PER_COUNTRY_NAME = countryName.FULLNAME,
  PER_DOB = per.DVPER_DOB,
  PER_SEX = sexcode.fullName,
  PER_RACE = racecode.fullName,
  PER_ETHNICITY = ethnicitycode.fullName,
  PER_OCCUPATION = OccupationCode.fullName,
  PER_SEXCODE_DR = per.DVPER_SEXCODE_ID,
  PER_RACECODE_DR = per.DVPER_RACECODE_ID,
  PER_ETHNICITYCODE_DR = per.DVPER_ETHNICITYCODE_ID,
  PER_OCCUPATIONCODE_DR = per.DVPER_OCCUPATIONCODE_ID,
  PER_NAMESUFFIX = entityNames.PARTSFX,
  PER_RECORDCREATEDBY = 
    case NamespaceCode.conceptCode
      when 'ELR' then 'LAB INTERFACE'
      when 'WEB' then 'WEB INTERFACE'
      else 'MAIN INTERFACE'
    end,
  PER_WORKSCHOOLLOCATION = SchoolLocationName.TRIVIALNAME,
  PER_WORKSCHOOLCONTACT = workSchoolContact.attributeString,
  PER_PRIMARYLANGUAGE_DR = languageCode.LANGUAGECODE_ID,
  PER_PRIMARYLANGUAGE = lang.fullName,
  PER_EMAIL = Email.attributeString,
  PER_ELECTRONICCONTACT = EContact.attributeString,
  PER_CURRENTVERSION = 
    case 
      when per.DVPER_ROWID=per.DVPER_ROOTID then 'Y' 
      else 'N' 
    end,
  PER_DATEOFDEATH = per.DVPER_DOD,
  PER_PERSONSTATUS = DeceasedStatus.fullName,
  PER_STATUSFLAG = statusFlag.fullName,
  PER_PRIMARYNATIONALITY = PrimaryNationality.fullName,
  PER_THIRDNAME = entityNames.partThird,
  PER_FOURTHNAME = entityNames.partFourth,
  PER_NAMEPREFIX = entityNames.partPrefix 
from

  internals.DV_PERSON                               per with (nolock)
  inner join 
  [$(PRD_APHIM_UODS)].DBO.E_ENTITY                  perEntity with (nolock)   
  on
    per.DVPER_ROWID = perEntity.ID

  outer apply
  internals.AttributeDateTimeByEntity(per.DVPER_RowID, 'PER_DATEOFUSARRIVAL') 
                                                    dateOfUSArrival
  outer apply
  internals.AttributeStringByEntity(per.DVPER_RowID, 'PER_OCCUPATIONLOCATION') 
                                                    occupationLocation
  outer apply
  internals.AttributeStringByEntity(per.DVPER_RowID, 'PER_OCCUPATIONDR') 
                                                    occupationSpecify
  outer apply 
  internals.AttributeStringByEntity(per.DVPER_RowID, 'PER_WorkSchoolContact') 
                                                    workSchoolContact
  outer apply
  internals.AttributeStringByEntity(per.DVPER_RootID, 'PER_StateNumber' ) 
                                                    StateNumber

  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          DeceasedStatus with (nolock)
  on
    per.DVPER_DeceasedStatusDR = DeceasedStatus.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          EthnicityCode with (nolock)
  on
    per.DVPER_EthnicityCode_ID = EthnicityCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          ImportOptionsCode with (nolock)
  on
    per.DVPER_ImportOptionsCode_ID = ImportOptionsCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          MaritalStatusCode with (nolock)
  on
    per.DVPER_MaritalStatusCode_ID = MaritalStatusCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          NamespaceCode with (nolock)
  on
    per.DVPER_NamespaceCode_ID = NamespaceCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          OccupationCode with (nolock)
  on
    per.DVPER_OccupationCode_ID = OccupationCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          PrimaryNationality with (nolock)
  on
    per.DVPER_PrimaryNationalityDR = PrimaryNationality.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          RaceCode with (nolock)
  on
    per.DVPER_RaceCode_ID = RaceCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          SexCode with (nolock)
  on
    per.DVPER_SexCode_ID = SexCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          StatusFlag with (nolock)
  on
    per.DVPER_StatusFlagDR = StatusFlag.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               occupationSetting with (nolock) 
  on  
    occupationSetting.ENTITY_ID = per.DVPER_ROWID and
    occupationSetting.NAME = 'PER_OCCUPATIONSETTINGTYPEDR' and
    occupationSetting.TYPE = 'CV' 

  --------------------------------------------------------
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.R_ROLE                    roleSchoolLocation with (nolock)  
  ON 
    roleSchoolLocation.player_id=perEntity.[ID] AND 
    roleSchoolLocation.classCode='LOCE' AND 
    roleSchoolLocation.metaCode='PER_WorkSchoolLocationDR'
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ENTITYNAME              SchoolLocationName with (nolock)  
  ON 
    roleSchoolLocation.Scoper_ID=SchoolLocationName.Entity_ID AND 
    SchoolLocationName.metaCode='LOC_Name' AND 
    SchoolLocationName.useCode='SRCH' 
  --------------------------------------------------------
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.S_Link                    slink with (nolock) 
  ON 
    slink.Name = 'Person-Primary'  AND 
    slink.Entity1_ID = per.DVPER_ROWID 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_EntityAddress           primaryAddress with (nolock)  
  ON 
    primaryAddress.Entity_ID=per.DVPER_ROWID AND 
    primaryAddress.useCode='H' AND 
    primaryAddress.ID = isnull( slink.tAddress1_ID,primaryAddress.ID) 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ENTITYNAME              entityNames with (nolock) 
  ON  
    entityNames.ENTITY_ID = isnull(slink.Entity2_ID,per.DVPER_RowID)
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          countryName with (nolock) 
  on 
    primaryAddress.partCountry = countryName.ID
  --------------------------------------------------------
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ENTITYADDRESS           entityCountry with (nolock) 
  ON  
    entityCountry.ENTITY_ID = per.DVPER_ROWID AND 
    entityCountry.USECODE = 'BIR' 

  ----------------------------------------------------------------
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               countryAttribute with (nolock)  
  on
    per.DVPER_RowID = countryAttribute.Entity_ID and
    countryAttribute.name = 'PER_RESIDENCECOUNTYDR'

  left outer join  
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          residenceCountryName with (nolock) 
  on
    countryAttribute.VALUECODE_ID = residenceCountryName.ID 
  ----------------------------------------------------------------

  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_LANGUAGECOMMUNICATION   languageCode with (nolock) 
  ON  
    per.DVPER_ROWID = languageCode.ENTITY_ID AND 
    languageCode.METACODE = 'PER_PRIMARYLANGUAGE_FK'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          Lang with (nolock)
  on
    languageCode.LANGUAGECODE_ID = Lang.ID


  outer apply
  internals.AttributeStringByEntity(case when  slink.ID IS NOT NULL then slink.Entity2_ID else per.DVPER_RowID end, 'PSNID_EMAILID' ) 
                                                    Email

  outer apply
  internals.AttributeStringByEntity(case when  slink.ID IS NOT NULL then slink.Entity2_ID else per.DVPER_RowID end, 'PSNID_ELECTRONICCONTACT' ) 
                                                    EContact



where
  NamespaceCode.conceptCode is null
  or 
  ( NamespaceCode.conceptCode is not null and
    NamespaceCode.conceptCode != 'WEB' and
    ImportOptionsCode.conceptCode is not null and
    ImportOptionsCode.conceptCode not in ( 'ALR', 'UDL' ) 
  );
