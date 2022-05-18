create function internals.DiagnosticTypes ( @actId int, @metaCode varchar( 50 ) ) returns table as return
(
  select
    typeNames =[$(PRD_APHIM_UODS)].dbo.STRCONCAT(ucs.fullName)
  from     
    [$(PRD_APHIM_UODS)].dbo.A_Act                   obs with (nolock)
    inner join
    [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet        ucs with (nolock)
    on
      obs.code_ID = ucs.ID
  where 
    obs.metaCode = @metaCode and 
    obs.Act_CaseCmr_ID = @actId
   
)
