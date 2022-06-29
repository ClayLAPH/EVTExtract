create procedure dbo.ExtractAllUdfData 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'ALL_UDF_DATA',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try

    truncate table dbo.All_UDF_Data;
    insert dbo.All_UDF_Data 
    (       
      Disease,
      RECORD_ID, FORM_INSTANCE_ID, FORM_DEF_DR, Form_DEF_ID, FORM_NAME, FORM_SHOW_IN_CMR, FORM_SHOW_IN_NCM, FORM_DESCRIPTION, FORM_CREATEDATE, FORM_NUMBER, FORM_IsMultipleInstance, SECTION_INSTANCE_ID, SECTION_DEF_DR, SECTION_NAME, SECTION_STATUS, SECTION_TYPE, SECTION_NUMBER, FIELD_INSTANCE_ID, FIELD_DEF_DR, FIELD_NAME, FIELD_IS_REQUIRED, FIELD_VALUE, FIELD_CONCEPT_CODE_VALUE, FIELD_STATUS, FIELD_TYPE
    )
    select 
      pr.DVPR_DiseaseCode_ID,
      RECORD_ID, FORM_INSTANCE_ID, FORM_DEF_DR, Form_DEF_ID, FORM_NAME, FORM_SHOW_IN_CMR, FORM_SHOW_IN_NCM, FORM_DESCRIPTION, FORM_CREATEDATE, FORM_NUMBER, FORM_IsMultipleInstance, SECTION_INSTANCE_ID, SECTION_DEF_DR, SECTION_NAME, SECTION_STATUS, SECTION_TYPE, SECTION_NUMBER, FIELD_INSTANCE_ID, FIELD_DEF_DR, FIELD_NAME, FIELD_IS_REQUIRED, FIELD_VALUE, FIELD_CONCEPT_CODE_VALUE, FIELD_STATUS, FIELD_TYPE
    from 
      internals.UDFData u with (nolock) 
      inner join
      internals.allincidentpersonalrecordkeys prk with (nolock)
      on
        u.RECORD_ID = prk.PR_ROWID 
      inner join
      [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
      on
        prk.PR_ROWID = pr.DVPR_RowID
    option
      ( recompile, maxdop 4, use hint( 'enable_parallel_plan_preference' ) );

    select @rows = @@rowcount, @status = 'ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows;
  end try
  begin catch
    select  @status = 'error', @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractAllUdfData @isRestart = 1;
  end

  return 0;

end

