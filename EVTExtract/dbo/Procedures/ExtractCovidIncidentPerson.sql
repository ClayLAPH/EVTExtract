create procedure dbo.ExtractCovidIncidentPerson
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'i.covid.incidentperson',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try

    truncate table internals.covidperson;
    insert internals.covidperson
    (
      DVPER_MaritalStatus, 
      DVPER_Namespace, 
      DVPER_RowID, 
      DVPER_CensusTract, 
      DVPER_OccupationSettingTypeSpecify, 
      DVPER_GuardianName, 
      American_Indian_or_Alaska_Native, Asian___Specify, Black_or_African_American___Spec, Native_Hawaiian_or_Other_Pacific, Other___Specify, Unknown___Specify, White___Specify, Country_of_Birth
    )
    select 
      DVPER_MaritalStatus, 
      DVPER_Namespace, 
      DVPER_RowID, 
      DVPER_CensusTract, 
      DVPER_OccupationSettingTypeSpecify, 
      DVPER_GuardianName, 
      American_Indian_or_Alaska_Native, Asian___Specify, Black_or_African_American___Spec, Native_Hawaiian_or_Other_Pacific, Other___Specify, Unknown___Specify, White___Specify, Country_of_Birth
    from
      ( select distinct phpr.dvpr_persondr  from  [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord phpr with (nolock) where DVPR_DiseaseCode_ID = 543030 ) pr
      inner join 
      internals.IncidentPersons per with (nolock)
      on 
        pr.dvpr_persondr = per.dvper_rowid
    where
      per.DVPER_Namespace = 'LIVE'
    option
      ( recompile, maxdop 4, use hint( 'enable_parallel_plan_preference' ) );

    select  @rows = @@rowcount, @status = 'ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows;
  end try
  begin catch
    select @status ='error' , @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractCovidIncidentPerson @isRestart = 1;
  end

  return 0;

end
