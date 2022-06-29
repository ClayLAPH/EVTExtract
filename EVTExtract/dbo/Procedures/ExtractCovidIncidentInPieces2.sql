create procedure dbo.ExtractCovidIncidentInPieces2 as
begin

  set nocount on;

  declare @t dbo.NamesType
  insert @t( Name ) values 
  ('i.covid.incidentacts'),
  ('i.covid.incidentperson'),
  ('i.covid.incidentpersonalrecord'),
  ('i.covid.incidentlab')

  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidIncidentActs';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidIncidentPersonalRecord';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidIncidentPerson';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractCovidIncidentLAB';

  execute dbo.WaitForSpecificJobs @t


end