create procedure InitializeExtract
as
begin

  set nocount on;

  --dbcc shrinkfile ('evt_extract_log') with no_infomsgs;
  checkpoint;
  checkpoint;

  --set transaction isolation level snapshot

  declare 
    @status sysname = 'debug',
    @name sysname = 'Workflow Manager',
    @instance int = next value for dbo.InstanceSequence;

  execute dbo.PreserveProcessingStatus;

  execute dbo.SetProcessingStatus @status, @name, @instance;

  --if ( @@serverName in ( 'PDSQLAO04', 'PDSQLDL01' ) )
  --begin
    execute dbo.StartAndWaitForPrerequisiteJobs;
    execute dbo.StartCovidJobs;
    waitfor delay '00:30'; 
    execute dbo.StartSARS2Jobs;
  --end
  --else
  --begin
  --  execute dbo.StartAndWaitForPrerequisiteJobs;
  --  execute dbo.StartSARS2Jobs;Welcome5555!W
  --  waitfor delay '00:40'; WWkjfjfewoikefinkjwe
  --  execute dbo.StartCovidJobs;
  --end

  execute dbo.SetProcessingStatus @status, @name, @instance;

  return 0;

end
