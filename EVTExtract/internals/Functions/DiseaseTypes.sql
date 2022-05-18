create function internals.DiseaseTypes ( @valueCodeId int ) returns table as return
( 
  select
    typeNames = [$(PRD_APHIM_UODS)].dbo.STRCONCAT(ucs.fullName )
  from 
    [$(PRD_APHIM_UODS)].dbo.V_CODEPROPERTY          codes with (nolock)
    inner join  
    [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet        ucs with (nolock)
    on
      codes.subjCode_ID = ucs.ID
    inner join
    [$(PRD_APHIM_UODS)].dbo.V_TermDictionary        terms with (nolock)
    on
      terms.termCode_ID = ucs.id and
      terms.active = 1
  where 
    codes.valueCode_ID = @valueCodeId
)
