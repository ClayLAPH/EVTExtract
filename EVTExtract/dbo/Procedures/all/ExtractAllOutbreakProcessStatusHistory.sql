create procedure dbo.ExtractAllOutbreakProcessStatusHistory 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'ALL_OUTBREAK_PROCESS_STATUS_HISTORY',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try
    truncate table dbo.ALL_OUTBREAK_PROCESS_STATUS_HISTORY;
    insert dbo.ALL_OUTBREAK_PROCESS_STATUS_HISTORY 
    (
      Disease,
      OUTB_RowID, AUD_ID, AUD_OldValue, AUD_NewValue, AUD_ActionDate, AUD_Username
    )
    select 
      Disease,
      OUTB_RowID, AUD_ID, AUD_OldValue, AUD_NewValue, AUD_ActionDate, AUD_Username
    from 
       dbo.ALL_OUTBREAK_PROCESS_STATUS_HISTORY_VIEW
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
    execute dbo.ExtractAllOutbreakProcessStatusHistory @isRestart = 1;
  end

  return 0;

end
