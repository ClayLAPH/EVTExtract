﻿create procedure dbo.ExtractSARS2Lab 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'SARS2_LAB',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  begin try
    execute dbo.SetProcessingStatus @status, @name, @instance;
    truncate table dbo.SARS2_LAB;
    insert dbo.SARS2_LAB 
    (       
      INCIDENTID, PHRECORDID, LabReportID, ACCESSIONNUMBER, HL7FILENAME, RESULTTEXT, ABNORMALFLAG, IMPORTSTATUS, ISFROMHL7, LABRESULTSTATUS, ORDERSTATUS, LOCALORGANISMCODE, LOCALORGANISMDESCRIPTION, LOCALTESTCODE, LOCALTESTDESCRIPTION, NOTES, ORGANISMCODE, ORGANISMCODINGSYSTEM, ORGANISMDESCRIPTION, PATIENTNAME, PERFORMINGFACILITYID, PERSONVERIFIEDRESULT, PFGEPATTERN1ST, PFGEPATTERN2ND, REFERENCERANGE, RESULTDATE, RESULTSTATUS, RESULTUNIT, RESULTVALUE, SEROGROUP, SEROLOGY, SEROTYPE, SPECIES, SPECBODYSITE, SPECCOLLECTEDDATE, SPECIMENSOURCE, SPECIMENSOURCETEXT, SPECRECEIVEDDATE, TESTCODE, TESTCODINGSYSTEM, TESTDESCRIPTION, PROVIDERNAME, PROVIDERID, PROVIDERADDRESS, PROVIDERCITY, PROVIDERSTATE, PROVIDERCOUNTY, PROVIDERZIP, PROVIDERPHONE, PROVIDEREMAIL, PROVIDERFAX, FACILITYNAME, FACILITYADDRESS, FACILITYCITY, FACILITYSTATE, FACILITYCOUNTY, FACILITYZIP, FACILITYPHONE, PLACERORDERNO, FACILITYEMAIL, FACILITYID, DILR_StatusCode, EXTENDEDRESULTVALUE, RELEVANTCLINICALINFORMATION, REASONFORSTUDY, RESULTEDORGANISM, LOCALORGANISMDESCRIPTIONTEXT, LOCALORGANISMCODETEXT
    )
    select
      INCIDENTID, PHRECORDID, LabReportID, ACCESSIONNUMBER, HL7FILENAME, RESULTTEXT, ABNORMALFLAG, IMPORTSTATUS, ISFROMHL7, LABRESULTSTATUS, LABRESULTSTATUS, LOCALORGANISMCODE, LOCALORGANISMDESCRIPTION, LOCALTESTCODE, LOCALTESTDESCRIPTION, NOTES, ORGANISMCODE, ORGANISMCODINGSYSTEM, ORGANISMDESCRIPTION, PATIENTNAME, PERFORMINGFACILITYID, PERSONVERIFIEDRESULT, PFGEPATTERN1ST, PFGEPATTERN2ND, REFERENCERANGE, RESULTDATE, RESULTSTATUS, RESULTUNIT, RESULTVALUE, SEROGROUP, SEROLOGY, SEROTYPE, SPECIES, SPECBODYSITE, SPECCOLLECTEDDATE, SPECIMENSOURCE, SPECIMENSOURCETEXT, SPECRECEIVEDDATE, TESTCODE, TESTCODINGSYSTEM, TESTDESCRIPTION, PROVIDERNAME, PROVIDERID, PROVIDERADDRESS, PROVIDERCITY, PROVIDERSTATE, PROVIDERCOUNTY, PROVIDERZIP, PROVIDERPHONE, PROVIDEREMAIL, PROVIDERFAX, FACILITYNAME, FACILITYADDRESS, FACILITYCITY, FACILITYSTATE, FACILITYCOUNTY, FACILITYZIP, FACILITYPHONE, PLACERORDERNO, FACILITYEMAIL, FACILITYID, DILR_StatusCode, EXTENDEDRESULTVALUE, RELEVANTCLINICALINFORMATION, REASONFORSTUDY, RESULTEDORGANISM, LOCALORGANISMDESCRIPTIONTEXT, LOCALORGANISMCODETEXT
    from
      internals.Lab 
    where 
      PHRECORDID in ( select pr.DVPR_RowID from [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock) where pr.DVPR_DiseaseCode_ID = 544041 )
    option
      ( recompile, maxdop 4, use hint( 'enable_parallel_plan_preference' ) );      

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
    execute dbo.ExtractSARS2Lab @isRestart = 1;
  end

  return 0;

end
