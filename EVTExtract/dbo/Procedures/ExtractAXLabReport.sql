create procedure dbo.ExtractAXLabReport 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'AX_LabReport',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  -- this table must be brought local to remove computed columns w/ scalar functions
  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try 
    truncate table internals.AX_LabReport; ---> bypasssing the partial...for now
    insert internals.AX_LabReport
    (
      DILR_PatientName, DILR_ImportStatus, DILR_SpecCollectedDate, DILR_SpecReceivedDate, DILR_TestCode, DILR_TestDescription, DILR_TestCodingSystem_ID, DILR_LocalTestCode, DILR_LocalTestDescription, DILR_OrganismCode, DILR_OrganismDescription, DILR_OrganismCodingSystem_ID, DILR_LocalOrganismCode, DILR_LocalOrganismDescription, DILR_ResultValue, DILR_ResultUnit, DILR_ReferenceRange, DILR_ResultDate, DILR_PerformingFacilityID, DILR_PersonVerifiedResult, DILR_Notes, DILR_ProviderName, DILR_ProviderID, DILR_ProviderPhone, DILR_ProviderAddress, DILR_ProviderCity, DILR_ProviderState, DILR_ProviderZip, DILR_ProviderCounty, DILR_ProviderFax, DILR_ProviderEmail, DILR_FacilityName, DILR_FacilityID, DILR_PlacerOrderNo, DILR_FacilityAddress, DILR_FacilityCity, DILR_FacilityState, DILR_FacilityZip, DILR_FacilityCounty, DILR_FacilityPhone, DILR_FacilityEmail, DILR_IsFromHL7, DILR_Serology, DILR_Species, DILR_Serogroup, DILR_Serotype, DILR_PFGEPattern1st, DILR_PFGEPattern2nd, DILR_SpecimenSourceText, DILR_AbnormalFlagCode_ID, DILR_LIPTestStatusCode_ID, DILR_ResultStatusCode_ID, DILR_SourceCode_ID, DILR_SpecBodySiteCode_ID, DILR_SpecimenSourceCode_ID, DILR_StatusCode_ID, DILR_ID, DILR_LaboratoryDR, DILR_SpecimenResult_ID, DILR_SpecimenType_ID, DILR_ImportStatus_ID, DILR_ResultTest, DILR_MessageType, 
      DILR_IsAttachedToLive, DILR_MessageTypeID, DILR_ResultValueEx, DILR_RelevantClinicalInformation, DILR_ReasonForStudy, DILR_StandardResultValue, DILR_StandardResultUnitDR
      )
    select 
    a.DILR_PatientName, a.DILR_ImportStatus, a.DILR_SpecCollectedDate, a.DILR_SpecReceivedDate, a.DILR_TestCode, a.DILR_TestDescription, a.DILR_TestCodingSystem_ID, a.DILR_LocalTestCode, a.DILR_LocalTestDescription, a.DILR_OrganismCode, a.DILR_OrganismDescription, a.DILR_OrganismCodingSystem_ID, a.DILR_LocalOrganismCode, a.DILR_LocalOrganismDescription, a.DILR_ResultValue, a.DILR_ResultUnit, a.DILR_ReferenceRange, a.DILR_ResultDate, a.DILR_PerformingFacilityID, a.DILR_PersonVerifiedResult, a.DILR_Notes, a.DILR_ProviderName, a.DILR_ProviderID, a.DILR_ProviderPhone, a.DILR_ProviderAddress, a.DILR_ProviderCity, a.DILR_ProviderState, a.DILR_ProviderZip, a.DILR_ProviderCounty, a.DILR_ProviderFax, a.DILR_ProviderEmail, a.DILR_FacilityName, a.DILR_FacilityID, a.DILR_PlacerOrderNo, a.DILR_FacilityAddress, a.DILR_FacilityCity, a.DILR_FacilityState, a.DILR_FacilityZip, a.DILR_FacilityCounty, a.DILR_FacilityPhone, a.DILR_FacilityEmail, a.DILR_IsFromHL7, a.DILR_Serology, a.DILR_Species, a.DILR_Serogroup, a.DILR_Serotype, a.DILR_PFGEPattern1st, a.DILR_PFGEPattern2nd, a.DILR_SpecimenSourceText, a.DILR_AbnormalFlagCode_ID, a.DILR_LIPTestStatusCode_ID, a.DILR_ResultStatusCode_ID, a.DILR_SourceCode_ID, a.DILR_SpecBodySiteCode_ID, a.DILR_SpecimenSourceCode_ID, a.DILR_StatusCode_ID, a.DILR_ID, a.DILR_LaboratoryDR, a.DILR_SpecimenResult_ID, a.DILR_SpecimenType_ID, a.DILR_ImportStatus_ID, a.DILR_ResultTest, a.DILR_MessageType, 
    a.DILR_IsAttachedToLive, a.DILR_MessageTypeID, a.DILR_ResultValueEx, a.DILR_RelevantClinicalInformation, a.DILR_ReasonForStudy, a.DILR_StandardResultValue, a.DILR_StandardResultUnitDR 
    from [$(PRD_APHIM_UODS)].dbo.AX_LabReport a with (nolock)
    select @rows = @@rowcount, @status = 'ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows
  end try
  begin catch
    select  @status = 'error', @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractAXLabReport @isRestart = 1;
  end
  
  return 0;
end;