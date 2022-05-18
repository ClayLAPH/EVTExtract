create procedure dbo.ExtractAllIncident 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'ALL_INCIDENT',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try
    execute dbo.ExtractAllIncidentInPieces;
    select  @status = 'ends', @rows = count(*) from dbo.ALL_INCIDENT;
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
    execute dbo.ExtractAllIncident @isRestart = 1;
  end

  return 0;

end
