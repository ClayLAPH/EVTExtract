create function internals.Hospital ( @actId int ) returns table as return
(
  select 
    role.player_ID,
    hospitalEntity.trivialName
  from
    [$(PRD_APHIM_UODS)].dbo.P_Participation part with (nolock)
    left outer join
    [$(PRD_APHIM_UODS)].dbo.R_Role role with (nolock)
    on 
      role.ID = part.Role_ID and
      role.classCode = 'QUAL' 
    left outer join
    [$(PRD_APHIM_UODS)].dbo.T_EntityName hospitalEntity with (nolock)
    on 
      hospitalEntity.Entity_ID = role.player_ID and 
      hospitalEntity.useCode = 'SRCH' and 
      hospitalEntity.metaCode = 'LOC_NAME' 
  where
    part.Act_Id = @actId and
    part.metaCode = 'PR_HOSPITALDR'
)
