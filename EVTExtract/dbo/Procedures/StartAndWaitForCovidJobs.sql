create procedure dbo.StartAndWaitForCovidJobs as
begin
  set nocount on;

  --covid 
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidIncident';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidSpecimen';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidPerson';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidLab';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidOutbreak';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidOutbreakLinkedContact';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidOutbreakLinkedIncident';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidUdfData';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidOutbreakUdfData';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidOutbreakProcessStatusHistory';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidProcessStatusHistory';

  --combined
  execute msdb.dbo.sp_start_job @job_name = 'ExtractContacts';

  --wait...
  execute dbo.WaitForJobs 'Covid jobs';

  return 0;

end
