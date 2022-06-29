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

  begin try

    insert dbo.ProcessingStatus 
      ( Status,  Name,  Instance,  NumberOfRows,  MessageText, CycleId ) 
    select 
        @status, @name, @instance, @numberOfRows, @messageText, max( CycleID )
    from 
      dbo.ProcessingStatusCycle

  end try
  begin catch

    insert dbo.ProcessingStatus 
      ( Status,  Name,  Instance,  NumberOfRows,  MessageText, CycleId ) 
    select 
        @status, @name, @instance, @numberOfRows, @messageText, max( CycleID )
    from 
      dbo.ProcessingStatusCycle

  end catch 

  return 0;

end