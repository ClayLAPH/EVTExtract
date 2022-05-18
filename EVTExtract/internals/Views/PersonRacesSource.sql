create view internals.PersonRacesSource as
select 
  p.DVPER_RowID PersonId,
  detailName.fullName Specify,
  ucs.fullName Category
from   
  internals.DV_Person                               p with (nolock)
  inner join  
  [$(PRD_APHIM_UODS)].dbo.T_Race                    tr with (nolock)
  on
    p.DVPER_RowID = tr.Entity_ID
  inner join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          detailName with (nolock)
  on
    tr.raceCode_ID = detailName.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_CodeProperty            cp with (nolock)
  on
    tr.raceCode_ID = cp.subjCode_ID and
    cp.property = 'Race_CategoryDR'
  inner join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          ucs with (nolock)
  on
    cp.valueCode_ID = ucs.ID
where 
  tr.metaCode = 'PER_MultipleRaceDR' 

