create procedure dbo.ExtractSARS2Specimen
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'SARS2_SPECIMEN',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try

    truncate table dbo.SARS2_SPECIMEN;

    insert dbo.SARS2_SPECIMEN 
      (       
        [PR_INCIDENTID], [Specimen Types], [Specimen Collected Date], [Specimen Received Date], [Result], [Specimen Notes], [Lab Report ID]
      )
      select 
        [PR_INCIDENTID], [Specimen Types], [Specimen Collected Date], [Specimen Received Date], [Result], [Specimen Notes], [Lab Report ID]
      from 
        internals.Specimens c 
      where 
        DiseaseCode = 544041
      --order by 
      --  [PR_INCIDENTID], [Lab Report ID]
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
    execute dbo.ExtractSARS2Specimen @isRestart = 1;
  end

  return 0;

end


