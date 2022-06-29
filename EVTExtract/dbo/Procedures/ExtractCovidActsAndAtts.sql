create procedure dbo.ExtractCovidActsAndAtts 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'CovidActsAndAtts',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  -- this preloads a lot of A_Acts and T_Attribute values for covid incident
  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try 
    truncate table internals.CovidActsAndAtts; 
    insert internals.CovidActsAndAtts
    ( id, 
      kind, 
      valueString_Txt, 
      valueBool, 
      valueTS, 
      effectiveTime_Beg, 
      valueString )
    select 
      pr.DVPR_RowID pr_rowId,
      a.metaCode,
      a.valueString_Txt,
      a.valueBool,
      a.valueTS,
      a.effectiveTime_Beg,
      convert( varchar( 8000 ), null ) valueString
    from
      [$(PRD_APHIM_UODS)].dbo.A_Act a with (nolock)
      inner join
      [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
      on
        a.Act_Parent_ID = pr.DVPR_RowID
    where
      pr.DVPR_DiseaseCode_ID = 543030
      and
      a.metaCode in (
        'PR_OTHERDISEASENAME',
        'PR_LIPRESULTVALUE',
        'PR_ISPREGNANT',
        'PR_EXPECTEDDELIVERYDATE',
        'PR_DATEOFDEATH',
        'PR_ISASYMPTOMATIC',
        'PR_ISPATIENTDIEDOFTHEILLNESS',
        'PR_LABSPECIMENCOLLECTEDDATE',
        'PR_LABSPECIMENRESULTDATE' ) --  10 448 397

    select @rows = @@rowcount;

    insert internals.CovidActsAndAtts
    ( id, 
      kind, 
      valueString_Txt )
    select 
      pr.DVPR_RowID,
      a.metaCode,
      [$(PRD_APHIM_UODS)].dbo.STRCONCAT( distinct ucs.fullName )
    from
      [$(PRD_APHIM_UODS)].dbo.A_Act a with (nolock)
      inner join
      [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
      on
        a.Act_CaseCmr_ID = pr.DVPR_RowID
      inner join
      [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet ucs with (nolock)
      on
        a.code_ID = ucs.ID
    where
      pr.DVPR_DiseaseCode_ID = 543030
      and
      a.metaCode in (
        'DIST_ROWID',
        'DIET_ROWID',
        'DIHT_HEPATITISTESTDR' ) 
    group by
      pr.DVPR_RowID, a.metaCode

    select @rows += @@rowcount;


    insert internals.CovidActsAndAtts( id, kind, valueString )
    select
      pr.DVPR_RowID, a.metacode, [$(PRD_APHIM_UODS)].dbo.STRCONCAT( ucs.FullName ) names
    from
      [$(PRD_APHIM_UODS)].dbo.A_Act a with (nolock)
      inner join
      [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
      on
        a.Id = pr.DVPR_RowID
      inner join
      [$(PRD_APHIM_UODS)].dbo.V_CODEPROPERTY vcp with (nolock)		
      on
        vcp.valueCode_ID = a.code_Id
      inner join
      [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet ucs with (nolock) 
      on 
        vcp.subjCode_ID = ucs.id 
      inner join  
      [$(PRD_APHIM_UODS)].dbo.V_TermDictionary vtd with (nolock) 
      on 
        vtd.termCode_ID = ucs.id 
        and 
        vtd.active = 1
    where
      pr.DVPR_DiseaseCode_ID = 543030
      and
      a.metaCode = 'PR_ROWID'
    group by
      pr.DVPR_RowID, a.metaCode  

    select @rows += @@rowcount;


    insert internals.CovidActsAndAtts( id, kind, valueBool, valueString_Txt, valueCode_Id, valueString )
    select
      att.Act_ID, att.name, att.valueBool, att.valueString_Txt, att.valueCode_ID, att.valueString
    from
      [$(PRD_APHIM_UODS)].dbo.T_Attribute att with (nolock)
      inner join
      [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
      on
        att.Act_ID = pr.DVPR_RowID
    where
      pr.DVPR_DiseaseCode_ID = 543030 and
      att.name in
      ( 'PR_REPORTEDBYWEB',
        'PR_REPORTEDBYLAB',
        'PR_REPORTEDBYEHR',
        'PR_TRANSMISSIONSTATUS',
        'PR_LIPTESTORDERED',
        'PR_OUTPATIENT',
        'PR_INPATIENT',
        'PR_NAMEOFSUBMITTER' )

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
