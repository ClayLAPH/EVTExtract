create view internals.ActCodeIdToDiseaseGroups as
select
  x.code_Id, [$(PRD_APHIM_UODS)].dbo.STRCONCAT( ucs.FullName ) names
from
  (
  select a.code_id, count(*) c from  [$(PRD_APHIM_UODS)].dbo.A_Act a where a.metaCode='PR_ROWID' group by a.code_ID
  ) x
  inner join
  [$(PRD_APHIM_UODS)].dbo.V_CODEPROPERTY VCP with (nolock)		
  on
    VCP.VALUECODE_ID =x.code_Id
  inner join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCS with (nolock) 
  ON 
    VCP.subjCode_ID=UCS.id 
  inner join  
  [$(PRD_APHIM_UODS)].dbo.V_TermDictionary VTD with (nolock) 
  ON 
    VTD.termCode_ID= UCS.id AND 
    VTD.ACTIVE = 1
group by
  x.code_ID