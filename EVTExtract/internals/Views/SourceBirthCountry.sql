create view internals.SourceBirthCountry as
select
  b.Entity_ID PersonId, 
  u.fullName CountryName
from
( select Entity_ID, partCountry
  from
  ( select Entity_ID, try_convert(int,partCountry) partCountry
    from [$(PRD_APHIM_UODS)].dbo.T_EntityAddress with (nolock)
    where useCode='BIR' 
  ) a
  where isnull(a.partCountry,0) !=0
) b
inner join
[$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet u with (nolock)
  on u.ID = b.partCountry
