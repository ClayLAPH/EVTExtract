﻿create procedure dbo.StartSARS2Jobs as
begin

  set nocount on;

  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2Person';
  waitfor delay '00:01'
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2Specimen';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2Lab';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2UdfData';

  --execute dbo.WaitForJobs 'SARS2 jobs'

  return 0;

end