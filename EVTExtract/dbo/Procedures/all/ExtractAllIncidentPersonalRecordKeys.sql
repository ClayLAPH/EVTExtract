create procedure dbo.ExtractAllIncidentPersonalRecordKeys 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'i.all.incidentpersonalrecordkeys',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  -- this table must be brought local to remove computed columns w/ scalar functions
  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try 
    truncate table internals.allincidentpersonalrecordkeys; 
    insert internals.allincidentpersonalrecordkeys
    ( PR_ROWID, PR_PERSONID )
    select 
      pr.DVPR_RowID, pr.DVPR_PersonDR
    from [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
    where pr.DVPR_DiseaseCode_ID not in ( 543030, 544041, 509985 ) -- covid, sars2, unknown respiratory 
    select @rows = @@rowcount, @status = 'ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows
  end try
  begin catch
    select  @status = 'error', @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractAllIncidentPersonalRecordKeys @isRestart = 1;
  end
  
  return 0;
end;
