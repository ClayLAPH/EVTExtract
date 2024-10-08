﻿create procedure InitializeExtract
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

    execute dbo.StartAndWaitForPrerequisiteJobs;
    execute dbo.StartCovidJobs;
    waitfor delay '00:30'; 
    execute dbo.StartSARS2Jobs;
    waitfor delay '00:30'; 
    execute dbo.ExtractAll;

  execute dbo.SetProcessingStatus @status, @name, @instance;

  return 0;

end
