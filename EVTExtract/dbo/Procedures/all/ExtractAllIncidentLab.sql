create procedure dbo.ExtractAllIncidentLab
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'i.all.incidentlab',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try

   truncate table internals.allincidentlab;
   insert internals.allincidentlab
    (
      id,availabilityTime,Most_Recent_Lab_Result,Most_Recent_Lab_Result_Value
    )
    select
      Id, availabilityTime, Most_Recent_Lab_Result, Most_Recent_Lab_Result_Value
    from
      ( select 
          Id = a.Act_Parent_ID, 
          availabilityTime = a.availabilityTime,
          Most_Recent_Lab_Result  =   
            isnull
            ( case
                when charindex(' - ', isnull(ax.DILR_ResultTest, '')) > 1 
                then ax.DILR_ResultTest 
                else ax.DILR_LocalTestDescription 
              end, ''),
          Most_Recent_Lab_Result_Value  = ax.DILR_ResultValue,
          rn = row_number() over ( partition by a.Act_Parent_ID order by a.availabilityTime desc, a.ID desc )
        from 
          [$(PRD_APHIM_UODS)].dbo.A_Act a with (nolock)
          inner join
          internals.AX_LabReport ax with (nolock)
          on
            ax.DILR_ID = a.ID
        where
          a.metaCode = 'DILR_ID'
      ) x
    where 
      x.rn = 1 and
      x.Id in ( select PR_RowID from internals.allincidentpersonalrecordkeys  with (nolock)  )
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
    execute dbo.ExtractAllIncidentLab @isRestart = 1;
  end

  return 0;

end
