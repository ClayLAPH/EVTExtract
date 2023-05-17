create procedure dbo.ExtractSARS2ActsAndAtts 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'SARS2ActsAndAtts',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  declare @persons dbo.IdsType

  -- this preloads a lot of A_Acts and T_Attribute values for covid incident
  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try 

    truncate table internals.SARS2ActsAndAtts; 

    insert @persons( Id ) 
    select distinct per.DVPER_RowID
    from
      internals.DV_Person per with (nolock)
      inner join
      [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
      on 
        per.DVPER_RowID = pr.DVPR_PersonDR
    where 
      pr.DVPR_DiseaseCode_ID = 544041
      and
      pr.DVPR_RowID not in ( select DVPR_RowID from internals.Sars2Archive )


    insert internals.SARS2ActsAndAtts( id, kind, valueBool, valueString_Txt, valueCode_Id )
    select
      per.Id, 
      att.name, 
      att.valueBool, 
      att.valueString_Txt, 
      att.valueCode_ID
    from
      [$(PRD_APHIM_UODS)].dbo.T_Attribute att with (nolock)
      inner join
      @persons per
      on
        att.Entity_ID = per.Id
    where
      att.name in
      ( 'PER_DATEOFUSARRIVAL',
        'PER_OCCUPATIONLOCATION',
        'PER_OCCUPATIONDR',
        'PER_StateNumber',
        'PER_RESIDENCECOUNTYDR')


    insert internals.SARS2ActsAndAtts( id, kind, valueString )
    select
      per.Id, 
      att.name, 
      att.valueString
    from
      [$(PRD_APHIM_UODS)].dbo.T_Attribute att with (nolock)
      inner join
      @persons per
      on
        att.Entity_ID = per.Id
    where
      att.name in
      ( 'PER_WorkSchoolContact',
        'PSNID_EMAILID',
        'PSNID_ELECTRONICCONTACT' )

    update internals.SARS2ActsAndAtts 
    set 
      valueString     = att.valueString
    from
      @persons per
      inner join
      [$(PRD_APHIM_UODS)].dbo.S_Link s_link with (nolock)
      on
        s_link.Entity1_ID = per.Id and
        s_link.name = 'Person-Primary'
      inner join
      [$(PRD_APHIM_UODS)].dbo.T_Attribute att with (nolock)
      on
        att.Act_ID = s_link.Entity2_ID
    where
      internals.SARS2ActsAndAtts.id = att.Act_ID and
      internals.SARS2ActsAndAtts.kind = att.name and
      att.name in
      ( 'PSNID_EMAILID',
        'PSNID_ELECTRONICCONTACT' )

    select @rows += @@rowcount, @status = 'ends';

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
    execute dbo.ExtractCovidActsAndAtts @isRestart = 1;
  end
  
  return 0;
end;

