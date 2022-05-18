create procedure dbo.StartAndWaitForPrerequisiteJobs as
begin

  set nocount on;

  execute msdb.dbo.sp_start_job @job_name = 'ExtractConfigData';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractBirthCountry';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAXLabReport';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractDVPerson';

  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2Incident';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2Outbreak';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2OutbreakProcessStatusHistory';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractUnknownRespiratoryOutbreak';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractUnknownRespiratoryOutbreakLinkedContact';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractUnknownRespiratoryOutbreakLinkedIncident';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractUnknownRespiratoryProcessStatusHistory';


  execute dbo.WaitForJobs 'Pre-Processing and Count Only jobs';  
  return 0;

end
