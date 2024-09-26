create procedure dbo.ExtractSARS2OutbreakProcessStatusHistoryArchive
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'SARS2_OUTBREAK_PROCESS_STATUS_HISTORY_ARCHIVE',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot
  
  execute dbo.SetProcessingStatus @status, @name, @instance;

  begin try
    truncate table dbo.SARS2_OUTBREAK_PROCESS_STATUS_HISTORY_ARCHIVE2;
    insert dbo.SARS2_OUTBREAK_PROCESS_STATUS_HISTORY_ARCHIVE2
    ( OUTB_RowID, AUD_ID, AUD_OldValue, AUD_NewValue, AUD_ActionDate, AUD_Username )
    select 
      OUTB_RowID, AUD_ID, AUD_OldValue, AUD_NewValue, AUD_ActionDate, AUD_Username 
    from 
      dbo.SARS2_OUTBREAK_PROCESS_STATUS_HISTORY;
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
    execute dbo.ExtractSARS2OutbreakProcessStatusHistoryArchive @isRestart = 1;
  end


  return 0;

end


