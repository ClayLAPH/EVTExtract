create procedure dbo.ExtractAll as
begin

  set nocount on;

  execute dbo.ExtractAllIncidentPersonalRecordKeys;
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllIncident';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllPerson';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllUdfData';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllLab';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllProcessStatusHistory';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllSpecimen';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllOutbreak';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllOutbreakLinkedContact';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllOutbreakLinkedIncident';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllOutbreakProcessStatusHistory';

end
