create procedure dbo.ExtractCovidSpecimen 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'COVID_SPECIMEN',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try
    truncate table dbo.COVID_SPECIMEN;
    insert dbo.COVID_SPECIMEN 
    (       
      [PR_INCIDENTID], [Specimen Types], [Specimen Collected Date], [Specimen Received Date], [Result], [Specimen Notes], [Lab Report ID]
    )
    select 
      [PR_INCIDENTID], [Specimen Types], [Specimen Collected Date], [Specimen Received Date], [Result], [Specimen Notes], [Lab Report ID]
    from 
      internals.Specimens c 
    where 
      DiseaseCode = 543030 
    --order by
    --  PR_INCIDENTID, [Lab Report ID]
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
    execute dbo.ExtractCovidSpecimen @isRestart = 1;
  end

  return 0;

end

