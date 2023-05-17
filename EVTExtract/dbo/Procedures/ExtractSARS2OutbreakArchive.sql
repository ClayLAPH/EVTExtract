create procedure dbo.ExtractSARS2OutbreakArchive
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'SARS2_OUTBREAK_ARCHIVE',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot
  
  execute dbo.SetProcessingStatus @status, @name, @instance;

  begin try
    truncate table dbo.SARS2_OUTBREAK_ARCHIVE;
    insert dbo.SARS2_OUTBREAK_ARCHIVE (
      OUTB_RowID, OUTB_Legacy_RowID, OUTB_Disease, OUTB_OutbreakNumber, OUTB_IsHealthFacilityOutbreak, OUTB_OutbreakLocation, OUTB_District, OUTB_DateofOnset, 
      OUTB_DateCreated, OUTB_DateClosed, OUTB_ProcessStatus, OUTB_ResolutionStatus, OUTB_Notes, OUTB_OutbreakType, OUTB_OUTBREAKID, OUTB_COUNT, OUTB_USERDR, 
      OUTB_HEALTHFACILITYCODE_DR, OUTB_DISEASECODE_DR, OUTB_DISSHORTNAME, OUTB_LOCATIONDR, OUTB_DISTRICTCODE_DR, OUTB_SPACODE_DR, OUTB_OUTBREAKTYPECODE_DR, 
      OUTB_PROCESSSTATUSCODE_DR, OUTB_RESOLUTIONSTATUSCODE_DR, OUTB_DATESUBMITTED, OUTB_DGRPDR, OUTB_USERNAME, OUTB_ISHEALTHFACILITY, OUTB_LOCATIONTYPE, 
      OUTB_LOCATIONADDRESS, OUTB_LOCATIONPHONE, OUTB_NURSEINVESTIGATOR, OUTB_NURSEINVESTIGATORDR, OUTB_LOCATIONEMAIL, OUTB_LOCATIONPRIMARYCONTACT, OUTB_LOCCOUNTY, 
      OUTB_LOCJURISDICTION, OUTB_LOCATIONTYPEDR, OUTB_PRIORITY, OUTB_DISTRICTNUMBER, OUTB_LOCATIONCENSUSTRACT, OUTB_LOCATIONCENSUSBLOCK, OUTB_LOCATIONCOUNTYFIPS, 
      OUTB_LOCATIONLATITUDE, OUTB_LOCATIONLONGITUDE, OUTB_LOCATIONDISTRICTNUMBER, Patients_Linked_to_Outbreak, All_Contacts_Linked_to_Outbreak, 
      Incident_Contacts_Linked_to_Outbreak, Contact_Investigations_Linked_to_Outbreak 
    )
    select 
      OUTB_RowID, OUTB_Legacy_RowID, OUTB_Disease, OUTB_OutbreakNumber, OUTB_IsHealthFacilityOutbreak, OUTB_OutbreakLocation, OUTB_District, OUTB_DateofOnset, 
      OUTB_DateCreated, OUTB_DateClosed, OUTB_ProcessStatus, OUTB_ResolutionStatus, OUTB_Notes, OUTB_OutbreakType, OUTB_OUTBREAKID, OUTB_COUNT, OUTB_USERDR, 
      OUTB_HEALTHFACILITYCODE_DR, OUTB_DISEASECODE_DR, OUTB_DISSHORTNAME, OUTB_LOCATIONDR, OUTB_DISTRICTCODE_DR, OUTB_SPACODE_DR, OUTB_OUTBREAKTYPECODE_DR, 
      OUTB_PROCESSSTATUSCODE_DR, OUTB_RESOLUTIONSTATUSCODE_DR, OUTB_DATESUBMITTED, OUTB_DGRPDR, OUTB_USERNAME, OUTB_ISHEALTHFACILITY, OUTB_LOCATIONTYPE, 
      OUTB_LOCATIONADDRESS, OUTB_LOCATIONPHONE, OUTB_NURSEINVESTIGATOR, OUTB_NURSEINVESTIGATORDR, OUTB_LOCATIONEMAIL, OUTB_LOCATIONPRIMARYCONTACT, OUTB_LOCCOUNTY, 
      OUTB_LOCJURISDICTION, OUTB_LOCATIONTYPEDR, OUTB_PRIORITY, OUTB_DISTRICTNUMBER, OUTB_LOCATIONCENSUSTRACT, OUTB_LOCATIONCENSUSBLOCK, OUTB_LOCATIONCOUNTYFIPS, 
      OUTB_LOCATIONLATITUDE, OUTB_LOCATIONLONGITUDE, OUTB_LOCATIONDISTRICTNUMBER, Patients_Linked_to_Outbreak, All_Contacts_Linked_to_Outbreak, 
      Incident_Contacts_Linked_to_Outbreak, Contact_Investigations_Linked_to_Outbreak 
    from dbo.SARS2_OUTBREAK;

    select @rows = @@rowcount;
    select @status = 'ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows;
  end try
  begin catch
    select  @status ='error', @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractSARS2OutbreakArchive @isRestart = 1;
  end

  return 0;

end



