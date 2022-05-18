create procedure dbo.ExtractDVPerson 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'DV_Person',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try
  -- this table must be brought local to remove computed columns w/ scalar functions
    truncate table internals.DV_Person; ---> bypass partial...for now
    insert internals.DV_Person
    (
      DVPER_IsPatient, DVPER_IsContact, DVPER_IsFamilyMember, DVPER_LastName, DVPER_FirstName, DVPER_SSN, DVPER_StreetAddress, DVPER_Apartment, DVPER_City, DVPER_State, DVPER_Zip, DVPER_DOB, DVPER_CreateDate, DVPER_SourceIdentifier, DVPER_NCMID, 
      DVPER_HomePhone, 
      DVPER_WorkSchoolPhone, DVPER_Address, DVPER_CellPhone, DVPER_EthnicityCode_ID, DVPER_ImportOptionsCode_ID, DVPER_MaritalStatusCode_ID, DVPER_NamespaceCode_ID, DVPER_OccupationCode_ID, DVPER_RaceCode_ID, DVPER_SexCode_ID, DVPER_RootID, DVPER_RowID, 
      DVPER_CensusTract, 
      DVPER_ResidenceCountyDR, DVPER_DateOfUSArrival, DVPER_OccupationSpecify, DVPER_OccupationSettingTypeDR, DVPER_OccupationSettingTypeSpecify, DVPER_OccupationLocation, DVPER_GuardianName, DVPER_WorkSchoolContact, DVPER_EmailID, DVPER_ElectronicContact, DVPER_DOD, DVPER_DeceasedStatusDR, DVPER_StatusFlagDR, DVPER_PrimaryNationalityDR, DVPER_DOBText, DVPER_Namespace, DVPER_Age
    )
    select 
      DVPER_IsPatient, DVPER_IsContact, DVPER_IsFamilyMember, DVPER_LastName, DVPER_FirstName, DVPER_SSN, DVPER_StreetAddress, DVPER_Apartment, DVPER_City, DVPER_State, DVPER_Zip, DVPER_DOB, DVPER_CreateDate, DVPER_SourceIdentifier, DVPER_NCMID, 
      DVPER_HomePhone, 
      DVPER_WorkSchoolPhone, DVPER_Address, DVPER_CellPhone, DVPER_EthnicityCode_ID, DVPER_ImportOptionsCode_ID, DVPER_MaritalStatusCode_ID, DVPER_NamespaceCode_ID, DVPER_OccupationCode_ID, DVPER_RaceCode_ID, DVPER_SexCode_ID, DVPER_RootID, DVPER_RowID, 
      DVPER_CensusTract, 
      DVPER_ResidenceCountyDR, DVPER_DateOfUSArrival, DVPER_OccupationSpecify, DVPER_OccupationSettingTypeDR, DVPER_OccupationSettingTypeSpecify, DVPER_OccupationLocation, DVPER_GuardianName, DVPER_WorkSchoolContact, DVPER_EmailID, DVPER_ElectronicContact, DVPER_DOD, DVPER_DeceasedStatusDR, DVPER_StatusFlagDR, DVPER_PrimaryNationalityDR, DVPER_DOBText, DVPER_Namespace, DVPER_Age
    from [$(PRD_APHIM_UODS)].dbo.DV_Person a with (nolock);
    select @rows = @@rowcount, @status = 'ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows;
  end try
  begin catch
    select  @status = 'error', @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractDVPerson @isRestart = 1;
  end
  
  return 0;
end;