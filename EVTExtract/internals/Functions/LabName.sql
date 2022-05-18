create function internals.LabName ( @prRowId int ) returns table as return
(
  select
    entityName.trivialName
  from
    [$(PRD_APHIM_UODS)].dbo.P_Participation         part with (nolock)
    left outer join
    [$(PRD_APHIM_UODS)].dbo.R_Role                  role with (nolock)
    on
      role.ID = part.Role_ID and 
      role.classCode = 'QUAL' 
    left outer join
    [$(PRD_APHIM_UODS)].dbo.T_EntityName            entityName with (nolock)
    on 
        entityName.Entity_ID = role.player_ID AND 
        entityName.useCode = 'SRCH' 
  where
    part.Act_ID = @prRowId and
    part.typeCode = 'ELOC' and
    part.metaCode = 'PR_LABORATORYDR' 
)
