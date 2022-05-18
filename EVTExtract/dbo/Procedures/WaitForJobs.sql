create procedure dbo.WaitForJobs 
  @category sysname
as
begin

  declare 
    @message nvarchar(max),
    @status sysname = 'debug',
    @instance int = next value for dbo.InstanceSequence;

  set nocount on;

  select @message = 'Waiting for ' + @category + ' to start';
  execute dbo.SetProcessingStatus @status, @category, @instance, null, @message;

  waitfor delay '00:03';  -- give time for all scheduled jobs to start

  declare
    @starts int,
    @ends int,
    @errors int,
    @jobName sysname

  select @message = 'Waiting for ' + @category + ' to complete';
  execute dbo.SetProcessingStatus @status, @category, @instance, null, @message;

  while ( 1 = 1 )
  begin
    select 
      @starts = q.starts, 
      @ends = q.ends, 
      @errors = q.errors 
    from 
      dbo.QueryProcessSummary q;

    if 
      @starts is null or 
      @starts = 0 or 
      @starts > ( @ends + @errors )
    begin
      waitfor delay '00:01';
    end
    else
    begin

      select @message = 
        @category + ' completed. So far there have been: '+
        convert(varchar,@starts ) + ' started, ' + 
        convert(varchar,@ends)    + ' completed and ' + 
        convert(varchar,@errors)  + ' failed';

      execute dbo.SetProcessingStatus @status, @category, @instance, null, @message;

      break;

    end
  end

  return 0;

end
