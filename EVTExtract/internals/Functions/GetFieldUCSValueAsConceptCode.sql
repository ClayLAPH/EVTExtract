create function internals.GetUDFFieldUCSValueAsConceptCode( @ucsID int ) returns table as return
(
  select ucs.conceptCode
  from
    [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet ucs with (nolock)
  where
    ucs.ID = @ucsID
)