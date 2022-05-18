create procedure dbo.ExtractCovidOutbreakLinkedIncident 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'COVID_OUTBREAK_LINKED_INCIDENT',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try
    truncate table dbo.COVID_OUTBREAK_LINKED_INCIDENT;
    insert dbo.COVID_OUTBREAK_LINKED_INCIDENT 
    (
      dvob_rowid, LinkedIndividuals, IncidentID, RecordType, concatendated
    )
    select 
      dvob_rowid, LinkedIndividuals, IncidentID, RecordType, concatendated
    from 
      dbo.COVID_OUTBREAK_LINKED_INCIDENT_VIEW
    --order by
    --  dvob_rowid,IncidentID
    option
      ( recompile, maxdop 4, use hint( 'enable_parallel_plan_preference' ) );

    select @rows = @@rowcount, @status = 'ends';
    execute dbo.SetProcessingStatus @status,@name, @instance, @rows;
  end try
  begin catch
    select  @status = 'error', @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractCovidOutbreakLinkedIncident @isRestart = 1;
  end

  return 0;

end
