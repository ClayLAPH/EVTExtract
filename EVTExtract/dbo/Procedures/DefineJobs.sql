create procedure dbo.DefineJobs as
begin

  set nocount on;

  declare 
      @rc int = 0,
      @jobId uniqueidentifier,
      @jobName sysname,
      @jobCommand sysname,
      @jobSubsystem sysname = N'TSQL',
      @jobStep sysname = N'one',
      @jobCategory sysname = N'evt extract jobs',
      @jobDB sysname = N'evt_extract',
      @jobServer sysname = N'(LOCAL)',
      @jobStepId int,
      @jobRetries int = 1,
      @jobRetryInterval int = 1,
      @jobOwner sysname = N'IRISExtract';


  truncate table dbo.ProcessingDocuments;
  insert dbo.ProcessingDocuments( Name )
  values

  --> covid
  ('COVID_CONTACT'),
  ('COVID_INCIDENT'),
  ('COVID_LAB'),
  ('COVID_OUTBREAK'),
  ('COVID_OUTBREAK_LINKED_CONTACT'),
  ('COVID_OUTBREAK_LINKED_INCIDENT'),
  ('COVID_OUTBREAK_PROCESS_STATUS_HISTORY'),
  ('COVID_OUTBREAK_UDF_DATA'),
  ('COVID_PERSON'),
  ('COVID_PROCESS_STATUS_HISTORY'),
  ('COVID_SPECIMEN'),
  ('COVID_UDF_DATA'),

  --> sars2
  ('SARS2_CONTACT'),
  ('SARS2_LAB'),
  ('SARS2_PERSON'),
  ('SARS2_SPECIMEN'),
  ('SARS2_UDF_DATA'),

  --> views
  ('SARS2_OUTBREAK'),
  ('SARS2_INCIDENT'),
  ('SARS2_OUTBREAK_PROCESS_STATUS_HISTORY'),
  ('UNKNOWN_REPSIRATORY_PROCESS_STATUS_HISTORY'),
  ('UNKNOWN_RESPIRATORY_OUTBREAK'),
  ('UNKNOWN_RESPIRATORY_OUTBREAK_LINKED_CONTACT'),
  ('UNKNOWN_RESPIRATORY_OUTBREAK_LINKED_INCIDENT')



  declare c cursor local for select x.jobName, x.retries from 
  ( values
    --setup
    ('InitializeExtract', 0 ),    
    ('InitializeSars2Archive', 0 ),    
    ('ExtractDVPerson', 1 ),
    ('ExtractAXLabReport', 1 ),
    ('ExtractBirthCountry', 1 ),
    ('ExtractConfigData', 1 ),
    ('ExtractCovidActsAndAtts', 1 ),    

    --no-op (count nonly)
    ('ExtractSARS2Incident', 1 ),
    ('ExtractSARS2Outbreak', 1 ),
    ('ExtractSARS2OutbreakProcessStatusHistory', 1 ),
    ('ExtractUnknownRespiratoryOutbreak', 1 ),
    ('ExtractUnknownRespiratoryOutbreakLinkedContact', 1 ),
    ('ExtractUnknownRespiratoryOutbreakLinkedIncident', 1 ),
    ('ExtractUnknownRespiratoryProcessStatusHistory', 1 ),

    --covid
    ('ExtractCovidIncident', 1 ),
    ('ExtractCovidSpecimen', 1 ),
    ('ExtractCovidPerson', 1 ),
    ('ExtractCovidLab', 1 ),
    ('ExtractCovidOutbreak', 1 ),
    ('ExtractCovidOutbreakLinkedContact', 1 ),
    ('ExtractCovidOutbreakLinkedIncident', 1 ),
    ('ExtractCovidUdfData', 1 ),
    ('ExtractCovidOutbreakUdfData', 1 ),
    ('ExtractCovidOutbreakProcessStatusHistory', 1 ),
    ('ExtractCovidProcessStatusHistory', 1 ),

    ('ExtractCovidIncidentActs', 1 ),
    ('ExtractCovidIncidentPerson', 1 ),
    ('ExtractCovidIncidentPersonalRecord', 1 ),
    ('ExtractCovidIncidentLab', 1 ),
    
    --sars2
    ('ExtractSARS2Person', 1 ),
    ('ExtractSARS2Lab', 1 ),
    ('ExtractSARS2Specimen', 1 ),
    ('ExtractSARS2UdfData', 1 ),

    --sars2 archive
    ('ExtractSARS2IncidentArchive', 1 ),
    ('ExtractSARS2LabArchive', 1 ),
    ('ExtractSARS2OutbreakArchive', 1 ),   
    ('ExtractSARS2OutbreakProcessStatusHistoryArchive', 1 ),
    ('ExtractSARS2PersonArchive', 1 ),
    ('ExtractSARS2SpecimenArchive', 1 ),
    ('ExtractSARS2UdfDataArchive', 1 ),

    --combined
    ('ExtractContacts', 1 ),

    --all diseases
    ('ExtractAllDiseaseCodes', 1 ),
    ('ExtractAllIncidentActs', 1 ),
    ('ExtractAllIncidentPerson', 1 ),
    ('ExtractAllIncidentPersonalRecord', 1 ),
    ('ExtractAllIncidentLab', 1 ),
    
    ('ExtractAllIncident', 1 ),
    ('ExtractAllPerson', 1 ),
    ('ExtractAllUdfData', 1 ),
    ('ExtractAllLab', 1 ),
    ('ExtractAllProcessStatusHistory', 1 ),
    ('ExtractAllSpecimen', 1 ),
    ('ExtractAllOutbreak', 1 ),
    ('ExtractAllOutbreakLinkedContact', 1 ),
    ('ExtractAllOutbreakProcessStatusHistory', 1 ),
    ('ExtractAllOutbreakLinkedIncident', 1 ),

    ('ExtractAll', 1 )


  ) as x( jobName, retries )

  open c
  while ( 1 = 1 )
  begin

    fetch next from c into @jobName, @jobRetries
    if ( @@fetch_status != 0 ) break;

    select @jobCommand = 'execute dbo.' + @jobName;

    if not exists ( select * from msdb.dbo.sysjobs j where j.name = @jobName )
    begin

      exec @rc = msdb.dbo.sp_add_job 
        @job_name = @jobName, 
        @enabled = 0,
        @owner_login_name = @jobOwner;

      exec @rc = msdb.dbo.sp_add_jobstep 
        @job_name       = @jobName, 
        @step_name      = @jobStep, 
        @subsystem      = @jobSubsystem, 
        @command        = @jobCommand, 
        @database_name  = @jobDB,
        @retry_attempts = @jobRetries,
        @retry_interval = @jobRetryInterval;

      exec @rc = msdb.dbo.sp_add_jobserver 
        @job_name = @jobName,
        @server_name = @jobServer;
    
    end
    else
    begin

      select @jobStepId = s.step_id, @jobId = j.job_id
      from
        msdb.dbo.sysjobs j
        inner join
        msdb.dbo.sysjobsteps s
        on
          j.job_id = s.job_id
      where
        j.name = @jobName and
        s.step_name = @jobStep

print ( @jobId );
print ( @jobOwner );

      exec @rc = msdb.dbo.sp_update_job 
        @job_id = @jobId--, 
        --@owner_login_name = @jobOwner

      exec @rc = msdb.dbo.sp_update_jobstep
        @step_id        = @jobStepId,
        @job_name       = @jobName, 
        @step_name      = @jobStep, 
        @subsystem      = @jobSubsystem,
        @command        = @jobCommand, 
        @database_name  = @jobDB,
        @retry_attempts = @jobRetries,
        @retry_interval = @jobRetryInterval;

    end

  end

  return 0;
end