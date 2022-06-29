﻿create table internals.DV_Person
(
	DVPER_IsPatient bit not null,
	DVPER_IsContact bit not null,
	DVPER_IsFamilyMember bit not null,
	DVPER_LastName varchar(100) null,
	DVPER_FirstName varchar(100) null,
	DVPER_SSN varchar(50) null,
	DVPER_StreetAddress varchar(100) null,
	DVPER_Apartment varchar(100) null,
	DVPER_City varchar(100) null,
	DVPER_State varchar(100) null,
	DVPER_Zip varchar(100) null,
	DVPER_DOB datetime null,
	DVPER_CreateDate datetime null,
	DVPER_SourceIdentifier varchar(50) null,
	DVPER_NCMID int null,
	DVPER_LastNameAlphaUp varchar(100) null,
	DVPER_FirstNameAlphaUp varchar(100) null,
	DVPER_HomePhone varchar(100) null,
	DVPER_HomePhoneAlphaUp varchar(50) null,
	DVPER_WorkSchoolPhone varchar(100) null,
	DVPER_Address varchar(550) null,
	DVPER_CellPhone varchar(100) null,
	DVPER_EthnicityCode_ID int null,
	DVPER_ImportOptionsCode_ID int null,
	DVPER_MaritalStatusCode_ID int null,
	DVPER_NamespaceCode_ID int null,
	DVPER_OccupationCode_ID int null,
	DVPER_RaceCode_ID int null,
	DVPER_SexCode_ID int null,
	DVPER_RootID int null,
	DVPER_RowID 
    int not null
    constraint [DV_Person.DVPER_RowID.PrimaryKey] 
      primary key clustered,
	DVPER_WorkSchoolPhoneAlphaUp varchar(50) null,
	DVPER_CensusTract varchar(100) null,
	DVPER_CellPhoneAlphaUp varchar(50) null,
	DVPER_ResidenceCountyDR int null,
	DVPER_DateOfUSArrival datetime null,
	DVPER_OccupationSpecify varchar(50) null,
	DVPER_OccupationSettingTypeDR int null,
	DVPER_OccupationSettingTypeSpecify varchar(50) null,
	DVPER_OccupationLocation varchar(255) null,
	DVPER_GuardianName varchar(50) null,
	DVPER_WorkSchoolContact varchar(100) null,
	DVPER_EmailID varchar(100) null,
	DVPER_ElectronicContact varchar(100) null,
	DVPER_DOD datetime null,
	DVPER_DeceasedStatusDR int null,
	DVPER_StatusFlagDR int null,
	DVPER_PrimaryNationalityDR int null,
	DVPER_DOBText char(8) null,
	DVPER_Namespace tinyint null,
	DVPER_Age int null
);

