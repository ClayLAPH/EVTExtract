create view dbo.All_Person_Raw as 
select
  DVPER_IsPatient, DVPER_IsContact, DVPER_IsFamilyMember, DVPER_LastName, DVPER_FirstName, DVPER_SSN, DVPER_StreetAddress, DVPER_Apartment, DVPER_City, DVPER_State, DVPER_Zip, 
  DVPER_DOB, DVPER_CreateDate, DVPER_SourceIdentifier, DVPER_NCMID, DVPER_LastNameAlphaUp, DVPER_FirstNameAlphaUp, DVPER_HomePhone, DVPER_HomePhoneAlphaUp, DVPER_WorkSchoolPhone, 
  DVPER_Address, DVPER_CellPhone, DVPER_EthnicityCode_ID, DVPER_ImportOptionsCode_ID, DVPER_MaritalStatusCode_ID, DVPER_NamespaceCode_ID, DVPER_OccupationCode_ID, DVPER_RaceCode_ID, 
  DVPER_SexCode_ID, DVPER_RootID, DVPER_RowID, DVPER_WorkSchoolPhoneAlphaUp, DVPER_CensusTract, DVPER_CellPhoneAlphaUp, DVPER_ResidenceCountyDR, DVPER_DateOfUSArrival, 
  DVPER_OccupationSpecify, DVPER_OccupationSettingTypeDR, DVPER_OccupationSettingTypeSpecify, DVPER_OccupationLocation, DVPER_GuardianName, DVPER_WorkSchoolContact, DVPER_EmailID, 
  DVPER_ElectronicContact, DVPER_DOD, DVPER_DeceasedStatusDR, DVPER_StatusFlagDR, DVPER_PrimaryNationalityDR, DVPER_DOBText, DVPER_Namespace, DVPER_Age
from
  internals.DV_Person
