create procedure dbo.ExtractAllLab 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'ALL_LAB',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  begin try
    execute dbo.SetProcessingStatus @status, @name, @instance;
    truncate table dbo.All_Lab;
    insert dbo.All_Lab 
    (       
      Disease,
      INCIDENTID, PHRECORDID, LabReportID, ACCESSIONNUMBER, HL7FILENAME, RESULTTEXT, ABNORMALFLAG, IMPORTSTATUS, ISFROMHL7, LABRESULTSTATUS, ORDERSTATUS, LOCALORGANISMCODE, LOCALORGANISMDESCRIPTION, LOCALTESTCODE, LOCALTESTDESCRIPTION, NOTES, ORGANISMCODE, ORGANISMCODINGSYSTEM, ORGANISMDESCRIPTION, PATIENTNAME, PERFORMINGFACILITYID, PERSONVERIFIEDRESULT, PFGEPATTERN1ST, PFGEPATTERN2ND, REFERENCERANGE, RESULTDATE, RESULTSTATUS, RESULTUNIT, RESULTVALUE, SEROGROUP, SEROLOGY, SEROTYPE, SPECIES, SPECBODYSITE, SPECCOLLECTEDDATE, SPECIMENSOURCE, SPECIMENSOURCETEXT, SPECRECEIVEDDATE, TESTCODE, TESTCODINGSYSTEM, TESTDESCRIPTION, PROVIDERNAME, PROVIDERID, PROVIDERADDRESS, PROVIDERCITY, PROVIDERSTATE, PROVIDERCOUNTY, PROVIDERZIP, PROVIDERPHONE, PROVIDEREMAIL, PROVIDERFAX, FACILITYNAME, FACILITYADDRESS, FACILITYCITY, FACILITYSTATE, FACILITYCOUNTY, FACILITYZIP, FACILITYPHONE, PLACERORDERNO, FACILITYEMAIL, FACILITYID, DILR_StatusCode, EXTENDEDRESULTVALUE, RELEVANTCLINICALINFORMATION, REASONFORSTUDY, RESULTEDORGANISM, LOCALORGANISMDESCRIPTIONTEXT, LOCALORGANISMCODETEXT,
      LABNAME, CLIA, LABADDR1, LABADDR2, LABADDR3, HL7TimestampOfMessage, TimestampMessageReceived,
      CaseIncidentId

    )
    select
      pr.DVPR_DiseaseCode_ID,
      INCIDENTID, PHRECORDID, LabReportID, ACCESSIONNUMBER, HL7FILENAME, RESULTTEXT, ABNORMALFLAG, IMPORTSTATUS, ISFROMHL7, LABRESULTSTATUS, LABRESULTSTATUS, LOCALORGANISMCODE, LOCALORGANISMDESCRIPTION, LOCALTESTCODE, LOCALTESTDESCRIPTION, NOTES, ORGANISMCODE, ORGANISMCODINGSYSTEM, ORGANISMDESCRIPTION, PATIENTNAME, PERFORMINGFACILITYID, PERSONVERIFIEDRESULT, PFGEPATTERN1ST, PFGEPATTERN2ND, REFERENCERANGE, RESULTDATE, RESULTSTATUS, RESULTUNIT, RESULTVALUE, SEROGROUP, SEROLOGY, SEROTYPE, SPECIES, SPECBODYSITE, SPECCOLLECTEDDATE, SPECIMENSOURCE, SPECIMENSOURCETEXT, SPECRECEIVEDDATE, TESTCODE, TESTCODINGSYSTEM, TESTDESCRIPTION, PROVIDERNAME, PROVIDERID, PROVIDERADDRESS, PROVIDERCITY, PROVIDERSTATE, PROVIDERCOUNTY, PROVIDERZIP, PROVIDERPHONE, PROVIDEREMAIL, PROVIDERFAX, FACILITYNAME, FACILITYADDRESS, FACILITYCITY, FACILITYSTATE, FACILITYCOUNTY, FACILITYZIP, FACILITYPHONE, PLACERORDERNO, FACILITYEMAIL, FACILITYID, DILR_StatusCode, EXTENDEDRESULTVALUE, RELEVANTCLINICALINFORMATION, REASONFORSTUDY, RESULTEDORGANISM, LOCALORGANISMDESCRIPTIONTEXT, LOCALORGANISMCODETEXT,
      LABNAME, CLIA, LABADDR1, LABADDR2, LABADDR3, HL7TimestampOfMessage, TimestampMessageReceived,
      try_convert(int,case when l.IMPORTSTATUS like ('%Case%') then substring(l.IMPORTSTATUS,len('Attached to Case ID - ')+1,100) else null end ) as CaseIncidentId
    from
      internals.Lab l with (nolock)
      inner join
      internals.allincidentpersonalrecordkeys prk with (nolock)
      on
        l.PHRECORDID = prk.PR_ROWID
      inner join
      [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (rowlock)
      on
        pr.DVPR_RowID = prk.PR_ROWID
    option
      ( recompile, maxdop 4, use hint( 'enable_parallel_plan_preference' ) );


    --> Clean up up manually entered lab reports: issue 2265
    update all_lab 
    set RESULTEDORGANISM = x.fullName
    from 
      all_lab inner join 
      ( select id, fullName from UnifiedCodeSet ) x
    on 
      convert(int, RESULTEDORGANISM ) = x.ID
    where 
      isnull(try_convert(int, RESULTEDORGANISM ),0) != 0 

    --> Clean up up manually entered lab reports: issue 2264
    update all_lab 
    set TESTDESCRIPTION = x.fullName
    from 
      all_lab inner join 
      ( select id, fullName from UnifiedCodeSet ) x
    on 
      convert(int, TESTDESCRIPTION ) = x.ID
    where 
      isnull(try_convert(int, TESTDESCRIPTION ),0) != 0 


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
    execute dbo.ExtractAllLab @isRestart = 1;
  end

  return 0;

end

