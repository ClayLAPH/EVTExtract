create function internals.ParameterizedPerson ( @diseaseTypes dbo.IdsType readonly ) returns table as return
(
select    
  PER_ROWID = per.DVPER_ROWID,
  PER_LEGACY_ROWID = per.PER_LEGACY_ROWID,  
  PER_COUNTRYOFBIRTHDR = entityCountry.PARTCOUNTRY,
  PER_CELLPHONE = per.DVPER_CellPhone,
  PER_DATEOFARRIVAL = dateOfUSArrival.valueTS,
  PER_OCCUPATIONLOCATION = occupationLocation.valueString_Txt,
  PER_OCCUPATIONSPECIFY = occupationSpecify.valueCode_OrTx,
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
  PER_STATENUMBER = StateNumber.valueString_Txt,
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
  PER_RECORDCREATEDBY = per.PER_RECORDCREATEDBY,
  PER_WORKSCHOOLLOCATION = SchoolLocationName.TRIVIALNAME,
  PER_WORKSCHOOLCONTACT = workSchoolContact.valueString,
  PER_PRIMARYLANGUAGE_DR = languageCode.LANGUAGECODE_ID,
  PER_PRIMARYLANGUAGE = lang.fullName,
  PER_EMAIL = Email.valueString,
  PER_ELECTRONICCONTACT = EContact.valueString,
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
  ( select 
      person.*,
      PER_RECORDCREATEDBY = 
        case NamespaceCode.conceptCode
          when 'ELR' then 'LAB INTERFACE'
          when 'WEB' then 'WEB INTERFACE'
          else 'MAIN INTERFACE'
        end,
      EntityId = perEntity.ID,
      PER_LEGACY_ROWID = perEntity.LOCALID,
      PrimaryPersonId = isnull(slink.Entity2_ID,person.DVPER_RowID),
      PrimaryPersonAddressId = slink.tAddress1_ID --?
    from
      ( select distinct 
          DVPR_PersonDR 
        from 
          [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord   pr with (nolock)
        where
          pr.DVPR_DiseaseCode_ID in ( select Id from @diseaseTypes )
      ) pr
      inner join
      internals.DV_PERSON                               person with (nolock)
      on
        pr.DVPR_PersonDR = person.DVPER_RowID
      left outer join
      [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          NamespaceCode with (nolock)
      on
        person.DVPER_NamespaceCode_ID = NamespaceCode.ID
      left outer join
      [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          ImportOptionsCode with (nolock)
      on
        person.DVPER_ImportOptionsCode_ID = ImportOptionsCode.ID
      inner join 
      [$(PRD_APHIM_UODS)].DBO.E_ENTITY                  perEntity with (nolock)   
      on
        person.DVPER_ROWID = perEntity.ID
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.S_Link                    slink with (nolock) 
      on
        slink.Name = 'Person-Primary'  and 
        slink.Entity1_ID = perEntity.ID
    where
      NamespaceCode.conceptCode is null
      or 
      ( NamespaceCode.conceptCode is not null and
        NamespaceCode.conceptCode != 'WEB' and
        ImportOptionsCode.conceptCode is not null and
        ImportOptionsCode.conceptCode not in ( 'ALR', 'UDL' ) 
      )
  ) per
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          DeceasedStatus with (nolock)
  on
    per.DVPER_DeceasedStatusDR = DeceasedStatus.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          EthnicityCode with (nolock)
  on
    per.DVPER_EthnicityCode_ID = EthnicityCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          MaritalStatusCode with (nolock)
  on
    per.DVPER_MaritalStatusCode_ID = MaritalStatusCode.ID
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
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               dateofUSArrival with (nolock)
  on
    dateofUSArrival.ENTITY_ID = per.EntityId 
    and 
    dateofUSArrival.NAME = 'PER_DATEOFUSARRIVAL'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               occupationLocation with (nolock)
  on
    occupationLocation.ENTITY_ID = per.EntityId  
    and 
    occupationLocation.NAME = 'PER_OCCUPATIONLOCATION'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               occupationSpecify with (nolock)
  on
    occupationSpecify.ENTITY_ID = per.EntityId  
    and 
    occupationSpecify.NAME = 'PER_OCCUPATIONDR'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               workSchoolContact with (nolock)
  on
    workSchoolContact.ENTITY_ID = per.EntityId  
    and 
    workSchoolContact.NAME = 'PER_WorkSchoolContact'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               StateNumber with (nolock)
  on
    StateNumber.ENTITY_ID = per.EntityId 
    and 
    StateNumber.NAME = 'PER_StateNumber'
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
    roleSchoolLocation.player_id=per.EntityId  AND 
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
  [$(PRD_APHIM_UODS)].dbo.T_EntityAddress           primaryAddress with (nolock)  
  ON 
    primaryAddress.Entity_ID=per.DVPER_ROWID AND 
    primaryAddress.useCode='H' AND 
    primaryAddress.ID = isnull( per.PrimaryPersonAddressId ,primaryAddress.ID) 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ENTITYNAME              entityNames with (nolock) 
  ON  
    entityNames.ENTITY_ID = per.PrimaryPersonId 
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

  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               Email with (nolock)
  on
    Email.ENTITY_ID = per.EntityId  
    and 
    Email.NAME = 'PSNID_EMAILID'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               EContact with (nolock)
  on
    EContact.ENTITY_ID = per.EntityId  
    and 
    EContact.NAME = 'PSNID_ELECTRONICCONTACT'

)