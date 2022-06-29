create procedure dbo.ExtractAllIncidentPersonalRecord
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'i.all.incidentpersonalrecord',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try

  truncate table internals.allincidentpersonalrecord;
  insert internals.allincidentpersonalrecord
  (
    PR_INCIDENTID, PR_CMRID, PR_MRN, PR_CREATEDATE, PR_ONSETDATE, PR_EPISODEDATE, PR_CLOSEDDATE, PR_DATEREPORTEDBY, PR_STANDARDAGE, PR_DATESUBMITTED, PR_ISINDEXCASE, PR_CLUSTERID, PR_DATEOFDIAGNOSIS, 
    PR_DISEASECODE_DR, PR_DISTRICTCODE_DR, 
    PR_PROCESSSTATUSCODE_DR, PR_RESOLUTIONSTATUSCODE_DR, 
    Secondary_District, 
    PR_NURSEINVESTIGATORDR, PR_PERSONDR, PR_REPORTSOURCEDR, PR_ROWID, PR_USERDR, PR_TYPEDR, PR_OUTBREAKDRSTEXT, PR_OUTBREAKNUMBERS, PR_OUTBREAKTYPES, PR_RECEIVEDDATE, 
    PR_IMPORTEDSTATUS, 
    Final_Disposition, 
    PR_LIPRESULTVALUE, Lab_Report_Test_Name, 
    PR_PROVIDERNAME, PR_REPORTEDBYLAB, 
    PR_LIPRESULTNOTES, PR_HEALTHCAREPROVIDERLOCATIONDR, 
    PR_DATESENT, PR_LASTCDCUPDATE, PR_LIPRESULTNAME, 
    PR_DATELASTEDITED, 
    PR_DISEASE, PR_DISEASESHORTNAME, PR_DISTRICT, 
    PR_PROCESSSTATUS, PR_RESOLUTIONSTATUS, 
    PR_PHTYPE, PR_SPA, PR_SPACODE_DR, Health_District_Number, PR_SPECIMENTYPE, PR_SPECIMENDATECOLLECTED, PR_SPECIMENDATERECEIVED, PR_SPECIMENRESULT, PR_SPECIMENNOTE, 
    PR_LABORATORY, PR_NURSEINVESTIGATOR, Additional_Provider, Additional_Laboratory, Created_By, ImportedBy, Priority, Report_Source, Suspected_Exposure_Types, Type_of_Contact
  )
  select 
    PR_INCIDENTID, PR_CMRID, PR_MRN, PR_CREATEDATE, PR_ONSETDATE, PR_EPISODEDATE, PR_CLOSEDDATE, PR_DATEREPORTEDBY, PR_STANDARDAGE, PR_DATESUBMITTED, PR_ISINDEXCASE, PR_CLUSTERID, PR_DATEOFDIAGNOSIS, 
    PR_DISEASECODE_DR, PR_DISTRICTCODE_DR, 
    PR_PROCESSSTATUSCODE_DR, PR_RESOLUTIONSTATUSCODE_DR, 
    Secondary_District, 
    PR_NURSEINVESTIGATORDR, PR_PERSONDR, PR_REPORTSOURCEDR, pr.PR_ROWID, PR_USERDR, PR_TYPEDR, PR_OUTBREAKDRSTEXT, PR_OUTBREAKNUMBERS, PR_OUTBREAKTYPES, PR_RECEIVEDDATE, 
    PR_IMPORTEDSTATUS, 
    Final_Disposition, 
    PR_LIPRESULTVALUE, Lab_Report_Test_Name, 
    PR_PROVIDERNAME, PR_REPORTEDBYLAB, 
    PR_LIPRESULTNOTES, PR_HEALTHCAREPROVIDERLOCATIONDR, 
    PR_DATESENT, PR_LASTCDCUPDATE, PR_LIPRESULTNAME, 
    PR_DATELASTEDITED, 
    PR_DISEASE, PR_DISEASESHORTNAME, PR_DISTRICT, 
    PR_PROCESSSTATUS, PR_RESOLUTIONSTATUS, 
    PR_PHTYPE, PR_SPA, PR_SPACODE_DR, Health_District_Number, PR_SPECIMENTYPE, PR_SPECIMENDATECOLLECTED, PR_SPECIMENDATERECEIVED, PR_SPECIMENRESULT, PR_SPECIMENNOTE, 
    PR_LABORATORY, PR_NURSEINVESTIGATOR, Additional_Provider, Additional_Laboratory, Created_By, ImportedBy, Priority, Report_Source, Suspected_Exposure_Types, Type_of_Contact
  from 
    internals.IncidentPersonalRecords pr with (nolock)
    inner join
    internals.allincidentpersonalrecordkeys prk with (nolock)
    on
      pr.PR_ROWID = prk.PR_ROWID
  option 
    ( recompile, maxdop 4, use hint( 'enable_parallel_plan_preference' ) );

    select  @rows = @@rowcount, @status = 'ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows;
  end try
  begin catch
    select @status ='error' , @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractAllIncidentPersonalRecord @isRestart = 1;
  end

  return 0;

end
