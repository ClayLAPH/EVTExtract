create procedure dbo.PreserveProcessingStatus as 
begin
  set nocount on;


  insert dbo.ProcessingStatusHistory
  (
    CycleId, Id, StepOccurred, Name, Instance, NumberOfRows, MessageText, Status
  )
  select 
    CycleId, Id, StepOccurred, Name, Instance, NumberOfRows, MessageText, Status
  from
    dbo.ProcessingStatus;

  insert dbo.Availability 
  (
    cycle, view_name, available
  )
  select
    cycle, view_name, available
  from
    dbo.QueryViewReadiness

  declare @historyId int = next value for dbo.CycleSequence;

  truncate table dbo.ProcessingStatus;

  declare @jobCount int;
  
  select @jobCount = 1 + count(*) from msdb.dbo.sysjobs where name like 'Extract%' and name not like 'ExtractAll%'; --> + 1 for one job that does two documents

  insert dbo.ProcessingStatusCycle( CycleId , TotalJobs ) values( @historyId, @jobCount )

  return 0;
end