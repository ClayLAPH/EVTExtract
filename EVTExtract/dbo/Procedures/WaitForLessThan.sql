create procedure dbo.WaitForLessThan 
  @jobCount int
as
begin

  set nocount on;
  waitfor delay '00:03';  -- give time for previous scheduled job(s) to start

  declare @pending int

  while ( 1 = 1 )
  begin
    select @pending = count(*) from dbo.QueryProcessJobs where status = 'pending'
    if @pending >= @jobCount waitfor delay '00:01' else break;
  end

  return 0;

end

