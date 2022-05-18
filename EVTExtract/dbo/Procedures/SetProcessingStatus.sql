create procedure dbo.SetProcessingStatus
  -- required
  @status sysname,
  @name sysname,
  -- optional
  @instance int = 0,
  @numberOfRows bigint = null,
  @messageText nvarchar( max ) = null
as
begin

  set nocount on;

  insert dbo.ProcessingStatus 
    ( Status,  Name,  Instance,  NumberOfRows,  MessageText, CycleId ) 
  select 
      @status, @name, @instance, @numberOfRows, @messageText, max( CycleID )
  from 
    dbo.ProcessingStatusCycle

  return 0;

end