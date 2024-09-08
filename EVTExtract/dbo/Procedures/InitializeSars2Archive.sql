create procedure InitializeSars2Archive
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
  declare @keys table( DVPR_RowID int, DVPR_IncidentID int, DVPR_PersonDR int ) 
  truncate table internals.Sars2Archive;
  
  insert @keys ( DVPR_RowID, DVPR_IncidentID, DVPR_PersonDR ) 
  select pr.DVPR_RowID, pr.DVPR_IncidentID, pr.DVPR_PersonDR 
  from [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr 
  where DVPR_DiseaseCode_ID = 544041 and pr.DVPR_CreateDate < '2024-07-01'

  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2Person';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2Specimen';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2Lab';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2UdfData';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2Incident';
  execute dbo.WaitForJobs 'SARS2 jobs'

  insert internals.Sars2Archive ( DVPR_RowID, DVPR_IncidentID, DVPR_PersonDR ) select DVPR_RowID, DVPR_IncidentID, DVPR_PersonDR from @keys

  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2IncidentArchive';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2PersonArchive';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2LabArchive';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2OutbreakArchive';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2OutbreakProcessStatusHistoryArchive';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2SpecimenArchive';
  execute msdb.dbo.sp_start_job @job_name = 'ExtractSARS2UdfDataArchive';
  execute dbo.WaitForJobs 'SARS2 Archive jobs'


    delete
        SARS2_INCIDENT_ARCHIVE2
    from 
        SARS2_INCIDENT_ARCHIVE a1
        inner join
        SARS2_INCIDENT_ARCHIVE2 a2
        on
        a1.PR_INCIDENTID = a2.PR_INCIDENTID
        and
        a1.PR_ROWID = a2.PR_ROWID;

    delete SARS2_LAB_ARCHIVE2
    from 
        SARS2_LAB_ARCHIVE a1
        inner join 
        SARS2_LAB_ARCHIVE2 a2
        on
        a1.LabReportID = a2.LabReportID;

    delete  
        SARS2_SPECIMEN_ARCHIVE2
    from 
        SARS2_SPECIMEN_ARCHIVE a1
        inner join 
        SARS2_SPECIMEN_ARCHIVE2 a2
        on
        a1.[Lab Report ID] = a2.[Lab Report ID];


    delete SARS2_PERSON_ARCHIVE2
    from
        SARS2_PERSON_ARCHIVE a1
        inner join
        SARS2_PERSON_ARCHIVE2 a2
        on
        a1.PER_ROWID = a2.PER_ROWID

    delete SARS2_UDF_DATA_ARCHIVE2
    from 
        SARS2_UDF_DATA_ARCHIVE a1
        inner join
        SARS2_UDF_DATA_ARCHIVE2 a2
        on
        a1.RECORD_ID = a2.RECORD_ID
        and
        a1.FIELD_DEF_DR = a2.FIELD_DEF_DR;

  execute dbo.SetProcessingStatus @status, @name, @instance;

  return 0;

end
