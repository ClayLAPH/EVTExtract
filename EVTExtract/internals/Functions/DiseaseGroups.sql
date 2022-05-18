create function internals.DiseaseGroups (@valueCodeId int) returns table as return
select
  names = [$(PRD_APHIM_UODS)].dbo.STRCONCAT(DISTINCT UCS.fullName) 
from
  [$(PRD_APHIM_UODS)].dbo.V_CODEPROPERTY VCP with (nolock)		
  inner join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet UCS with (nolock) 
  ON 
    VCP.subjCode_ID=UCS.id
  inner join  
  [$(PRD_APHIM_UODS)].dbo.V_TermDictionary VTD with (nolock) 
  ON 
    VTD.termCode_ID= UCS.id AND 
    VTD.ACTIVE = 1
where
  VCP.VALUECODE_ID =@valueCodeId

	

