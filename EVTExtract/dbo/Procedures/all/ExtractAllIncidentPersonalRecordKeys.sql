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
    select pr.DVPR_RowID, pr.DVPR_PersonDR
    from
    [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr
    inner join
    (
      select pr.DVPR_IncidentID IncidentID, max( pr.DVPR_RowID ) RowID
      from
        ( --6214676
          select pr.DVPR_IncidentID IncidentID, max( pr.DVPR_CreateDate ) CreateDate 
          from [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr
          where pr.DVPR_DiseaseCode_ID not in ( 543030, 544041, 509985 ) and pr.DVPR_DiseaseCode_ID is not null
          group by pr.DVPR_IncidentID
        ) keys
        inner join
        [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr
        on
          keys.IncidentID = pr.DVPR_IncidentID
          and
          keys.CreateDate = pr.DVPR_CreateDate
      where 
        pr.DVPR_DiseaseCode_ID is not null
      group by 
        pr.DVPR_IncidentID
      ) y
      on 
        pr.DVPR_RowID = y.RowID
    where
      pr.DVPR_DiseaseCode_ID is not null


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
