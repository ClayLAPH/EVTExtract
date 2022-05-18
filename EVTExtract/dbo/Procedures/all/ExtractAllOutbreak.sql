create procedure dbo.ExtractAllOutbreak
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'ALL_OUTBREAK',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  begin try
    execute dbo.SetProcessingStatus @status, @name, @instance;
    truncate table dbo.ALL_OUTBREAK;
    insert dbo.ALL_OUTBREAK 
    ( Disease,
      OUTB_RowID, OUTB_Legacy_RowID, OUTB_Disease, OUTB_OutbreakNumber, OUTB_IsHealthFacilityOutbreak, OUTB_OutbreakLocation, OUTB_District, OUTB_DateofOnset, OUTB_DateCreated, OUTB_DateClosed, OUTB_ProcessStatus, OUTB_ResolutionStatus, OUTB_Notes, OUTB_OutbreakType, OUTB_OUTBREAKID, OUTB_COUNT, OUTB_USERDR, OUTB_HEALTHFACILITYCODE_DR, OUTB_DISEASECODE_DR, OUTB_DISSHORTNAME, OUTB_LOCATIONDR, OUTB_DISTRICTCODE_DR, OUTB_SPACODE_DR, OUTB_OUTBREAKTYPECODE_DR, OUTB_PROCESSSTATUSCODE_DR, OUTB_RESOLUTIONSTATUSCODE_DR, OUTB_DATESUBMITTED, OUTB_DGRPDR, OUTB_USERNAME, OUTB_ISHEALTHFACILITY, OUTB_LOCATIONTYPE, OUTB_LOCATIONADDRESS, OUTB_LOCATIONPHONE, OUTB_NURSEINVESTIGATOR, OUTB_NURSEINVESTIGATORDR, OUTB_LOCATIONEMAIL, OUTB_LOCATIONPRIMARYCONTACT, OUTB_LOCCOUNTY, OUTB_LOCJURISDICTION, OUTB_LOCATIONTYPEDR, OUTB_PRIORITY, OUTB_DISTRICTNUMBER, OUTB_LOCATIONCENSUSTRACT, OUTB_LOCATIONCENSUSBLOCK, OUTB_LOCATIONCOUNTYFIPS, OUTB_LOCATIONLATITUDE, OUTB_LOCATIONLONGITUDE, OUTB_LOCATIONDISTRICTNUMBER, OUTB_LOCATIONADDRESS_PLUS, Patients_Linked_to_Outbreak, All_Contacts_Linked_to_Outbreak, Incident_Contacts_Linked_to_Outbreak, Contact_Investigations_Linked_to_Outbreak
    )
    select 
      OUTB_DISEASECODE_DR,
      OUTB_RowID, OUTB_Legacy_RowID, OUTB_Disease, OUTB_OutbreakNumber, OUTB_IsHealthFacilityOutbreak, OUTB_OutbreakLocation, OUTB_District, OUTB_DateofOnset, OUTB_DateCreated, OUTB_DateClosed, OUTB_ProcessStatus, OUTB_ResolutionStatus, OUTB_Notes, OUTB_OutbreakType, OUTB_OUTBREAKID, OUTB_COUNT, OUTB_USERDR, OUTB_HEALTHFACILITYCODE_DR, OUTB_DISEASECODE_DR, OUTB_DISSHORTNAME, OUTB_LOCATIONDR, OUTB_DISTRICTCODE_DR, OUTB_SPACODE_DR, OUTB_OUTBREAKTYPECODE_DR, OUTB_PROCESSSTATUSCODE_DR, OUTB_RESOLUTIONSTATUSCODE_DR, OUTB_DATESUBMITTED, OUTB_DGRPDR, OUTB_USERNAME, OUTB_ISHEALTHFACILITY, OUTB_LOCATIONTYPE, OUTB_LOCATIONADDRESS, OUTB_LOCATIONPHONE, OUTB_NURSEINVESTIGATOR, OUTB_NURSEINVESTIGATORDR, OUTB_LOCATIONEMAIL, OUTB_LOCATIONPRIMARYCONTACT, OUTB_LOCCOUNTY, OUTB_LOCJURISDICTION, OUTB_LOCATIONTYPEDR, OUTB_PRIORITY, OUTB_DISTRICTNUMBER, OUTB_LOCATIONCENSUSTRACT, OUTB_LOCATIONCENSUSBLOCK, OUTB_LOCATIONCOUNTYFIPS, OUTB_LOCATIONLATITUDE, OUTB_LOCATIONLONGITUDE, OUTB_LOCATIONDISTRICTNUMBER, OUTB_LOCATIONADDRESS_PLUS, Patients_Linked_to_Outbreak, All_Contacts_Linked_to_Outbreak, Incident_Contacts_Linked_to_Outbreak, Contact_Investigations_Linked_to_Outbreak
    from 
       dbo.ALL_OUTBREAK_VIEW
    option
      ( recompile, maxdop 4, use hint( 'enable_parallel_plan_preference' ) );
    select @rows = @@rowcount, @status ='ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows;
 end try
  begin catch
    select  @status = 'error', @messageText =  error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractAllOutbreak @isRestart = 1;
  end

  return 0;

end

