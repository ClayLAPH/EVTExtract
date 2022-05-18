create procedure dbo.ExtractAllIncidentInPieces as
begin

  set nocount on;

  declare @t dbo.NamesType
  insert @t( Name ) values 
  ('i.all.incidentperson'),
  ('i.all.incidentpersonalrecord'),
  ('i.all.incidentacts'),
  ('i.all.incidentlab')

  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllIncidentPerson';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllIncidentPersonalRecord';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllIncidentActs';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractAllIncidentLab';

  execute dbo.WaitForSpecificJobs @t


end
