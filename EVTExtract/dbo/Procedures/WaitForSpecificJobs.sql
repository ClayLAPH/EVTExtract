create procedure dbo.WaitForSpecificJobs 
  @names dbo.NamesType readonly
as
begin

  set nocount on;

  declare 
    @message nvarchar(max),
    @status sysname = 'debug',
    @completeCount int,
    @targetCount int,
    @category nvarchar( 4000 ) = '',
    @instance int = next value for dbo.InstanceSequence;

  select @category += ', ' + name from @names;
  select @category = stuff( @category, 1, 2, '' );
  select @targetCount = count(*) from @names;

  if ( isnull( @targetCount, 0 ) = 0 ) return; --> we were told to wait on nothing

  select @message = 'Waiting for ' + @category + ' to start';
  execute dbo.SetProcessingStatus @status, @category, @instance, null, @message;

  waitfor delay '00:03';  --> give time for all waited for jobs to start

  select @message = 'Waiting for ' + @category + ' to complete';
  execute dbo.SetProcessingStatus @status, @category, @instance, null, @message;

  while ( 1 = 1 )
  begin
    select 
      @completeCount = count(*)
    from 
      dbo.QueryProcessJobs j
    where
      j.name in (select Name from @names )
      and
      j.status = 'finished';

    if 
      @completeCount is null or 
      @completeCount < @targetCount
    begin
      waitfor delay '00:01';
    end
    else
    begin

      select @message = @category + ' completed';
      execute dbo.SetProcessingStatus @status, @category, @instance, null, @message;
      break;

    end
  end

  return 0;

end
