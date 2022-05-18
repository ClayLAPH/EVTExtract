create procedure dbo.ExtractAllIncidentActs
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'i.all.incidentacts',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try

   truncate table internals.allincidentacts;
   insert internals.allincidentacts
    (
      PR_NOTES, 
      PR_DATEINVESTIGATORRECEIVED, 
      PR_LEGACY_ROWID, 
      PR_DATEADMITTED, PR_DATEDISCHARGED, 
      PR_ROWID, 
      PR_REPORTEDBYWEB, PR_REPORTEDBYLAB, PR_REPORTEDBYEHR, PR_TRANSMISSIONSTATUS, PR_DIAGSPECIMENTYPES, PR_EXPEXPOSURETYPES, PR_HEPATITISDRS, PR_DISEASEGROUPS, PR_OTHERDISEASE, PR_RESULTVALUE, PR_LIPTESTORDERED, PR_ISPREGNANT, PR_EXPECTEDDELIVERYDATE, PR_DATEOFDEATH, PR_ISSYMPTOMATIC, PR_ISPATIENTDIEDOFTHEILLNESS, PR_ISPATIENTHOSPITALIZED, PR_LABSPECIMENCOLLECTEDDATE, PR_LABSPECIMENRESULTDATE, PR_OUTPATIENT, PR_INPATIENT, PR_NAMEOFSUBMITTER, PR_HOSPITAL, PR_HOSPITALDR, PR_ANIMALREPORTID, PR_FBIDR, PR_FBINumber
    )
    select
      PR_NOTES, 
      PR_DATEINVESTIGATORRECEIVED, 
      PR_LEGACY_ROWID, 
      PR_DATEADMITTED, PR_DATEDISCHARGED, 
      a.PR_ROWID, 
      PR_REPORTEDBYWEB, PR_REPORTEDBYLAB, PR_REPORTEDBYEHR, PR_TRANSMISSIONSTATUS, PR_DIAGSPECIMENTYPES, PR_EXPEXPOSURETYPES, PR_HEPATITISDRS, PR_DISEASEGROUPS, PR_OTHERDISEASE, PR_RESULTVALUE, PR_LIPTESTORDERED, PR_ISPREGNANT, PR_EXPECTEDDELIVERYDATE, PR_DATEOFDEATH, PR_ISSYMPTOMATIC, PR_ISPATIENTDIEDOFTHEILLNESS, PR_ISPATIENTHOSPITALIZED, PR_LABSPECIMENCOLLECTEDDATE, PR_LABSPECIMENRESULTDATE, PR_OUTPATIENT, PR_INPATIENT, PR_NAMEOFSUBMITTER, PR_HOSPITAL, PR_HOSPITALDR, PR_ANIMALREPORTID, PR_FBIDR, PR_FBINumber
    from
      internals.allincidentpersonalrecordkeys pr 
      inner join
      internals.Acts a
      on
        pr.pr_rowid = a.PR_ROWID
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
    execute dbo.ExtractAllIncidentActs @isRestart = 1;
  end

  return 0;

end
