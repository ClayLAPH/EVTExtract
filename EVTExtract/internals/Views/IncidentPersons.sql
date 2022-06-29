create view internals.IncidentPersons as
select 
  DVPER_IsPatient,
  DVPER_IsContact,
  DVPER_IsFamilyMember,
  DVPER_LastName,
  DVPER_MiddleName = entityName.partMID,
  DVPER_FirstName,
  DVPER_SSN,
  DVPER_StreetAddress,
  DVPER_Apartment,
  DVPER_City,
  DVPER_State,
  DVPER_Zip,
  DVPER_DOB,
  DVPER_CreateDate,
  DVPER_SourceIdentifier
  DVPER_NCMID,
  DVPER_LastNameAlphaUp,
  DVPER_FirstNameAlphaUp,
  DVPER_HomePhone,
  DVPER_HomePhoneAlphaUp,
  DVPER_WorkSchoolPhone,
  DVPER_Address,
  DVPER_CellPhone,
  DVPER_EthnicityCode_ID,
  DVPER_Ethnicity = UCSEthnicityCode.fullName,
  DVPER_ImportOptionsCode_ID,
  DVPER_ImportOptions = UCSImportOptionsCode.conceptCode,
  DVPER_MaritalStatusCode_ID,
  DVPER_MaritalStatus = UCSMaritalStatusCode.fullName,
  DVPER_NamespaceCode_ID,
  DVPER_Namespace = 
    case
      when  UCSNamespaceCode.conceptCode = 'WEB' then 'WEB'
      when  UCSNamespaceCode.conceptCode = 'MLR' then 'MLR'
		  when 
        UCSNamespaceCode.ID is null or 
        (
          UCSNamespaceCode.ID is not null and
          UCSImportOptionsCode.ID is not null and
          UCSImportOptionsCode.ConceptCode not in ('ALR', 'UDL')
        )
      then 'LIVE' 
		  else 'ELR' 
    end,
  DVPER_OccupationCode_ID,
  DVPER_Occupation = OccupationCode.fullName,
  DVPER_RaceCode_ID,
  DVPER_Race = UCSRaceCode.fullName,
  DVPER_SexCode_ID,
  DVPER_Sex = UCSSexCode.fullName,
  DVPER_RootID,
  DVPER_RowID,
  DVPER_WorkSchoolPhoneAlphaUp,
  DVPER_CensusTract,
  DVPER_CellPhoneAlphaUp,
  DVPER_ResidenceCountyDR,
  DVPER_DateOfUSArrival,
  DVPER_OccupationSpecify,
  DVPER_OccupationSettingTypeDR,
  DVPER_OccupationSettingTypeSpecify = UCSOccupationSettingType.fullName,
  DVPER_OccupationLocation,
  DVPER_GuardianName,
  DVPER_WorkSchoolContact,
  DVPER_EmailID,
  DVPER_ElectronicContact,
  DVPER_DOD,
  DVPER_DeceasedStatusDR,
  DVPER_DeceasedStatus = UCSDeceasedStatus.fullName,
  DVPER_StatusFlagDR,
  DVPER_StatusFlag = UCSStatusFlag.fullName,
  DVPER_PrimaryNationalityDR,
  DVPER_PrimaryNationality = UCSPrimaryNationality.fullName,
  DVPER_DOBText,
  DVPER_Age,
  American_Indian_or_Alaska_Native = ppp.[American Indian or Alaska Native],
  Asian___Specify                  = ppp.Asian,
  Black_or_African_American___Spec = ppp.[Black or African American],
  Native_Hawaiian_or_Other_Pacific = ppp.[Native Hawaiian or Other Pacific Islander],
  Other___Specify                  = ppp.Other,
  Unknown___Specify                = ppp.Unknown,
  White___Specify                  = ppp.White,
  Country_of_Birth = pbc.CountryName

from
  internals.DV_Person p with (nolock)
  left outer join
  internals.PersonRacesPivoted ppp with (nolock)
  on
    p.DVPER_RowID = ppp.PersonId
  left outer join
  internals.PersonBirthCountry pbc with (nolock)
  on
    p.DVPER_RowID = pbc.PersonId

  --------------------------------------------------------
  /*
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.S_Link with (nolock) 
  on 
    S_Link.Name = 'Person-Primary' and 
    S_Link.Entity1_ID = p.DVPER_ROWID
  */
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_ENTITYNAME entityName with (nolock) 
  on
    --entityName.ENTITY_ID = isnull(S_Link.Entity2_ID, p.DVPER_RowID)  --> there are 7 rows in the entire db that satisfy this criterion
    entityName.ENTITY_ID = p.DVPER_RowID
  ------------------------------------------------------
  
  
  
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCSDeceasedStatus with (nolock)
  on
    p.DVPER_DeceasedStatusDR = UCSDeceasedStatus.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCSEthnicityCode with (nolock)
  on
    p.DVPER_EthnicityCode_ID = UCSEthnicityCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCSImportOptionsCode with (nolock)
  on
    p.DVPER_ImportOptionsCode_ID = UCSImportOptionsCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCSMaritalStatusCode with (nolock)
  on
    p.DVPER_MaritalStatusCode_ID = UCSMaritalStatusCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCSNamespaceCode with (nolock)
  on
    p.DVPER_NamespaceCode_ID = UCSNamespaceCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet OccupationCode with (nolock)
  on
    p.DVPER_OccupationCode_ID = OccupationCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCSPrimaryNationality with (nolock)
  on
    p.DVPER_PrimaryNationalityDR = UCSPrimaryNationality.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCSRaceCode with (nolock)
  on
    p.DVPER_RaceCode_ID = UCSRaceCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCSSexCode with (nolock)
  on
    p.DVPER_SexCode_ID = UCSSexCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCSStatusFlag with (nolock)
  on
    p.DVPER_StatusFlagDR = UCSStatusFlag.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCSOccupationSettingType with (nolock)
  on
    p.DVPER_OccupationSettingTypeDR = UCSOccupationSettingType.ID;
