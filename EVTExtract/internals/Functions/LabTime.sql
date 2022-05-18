create function internals.LabTime( @parentAct int ) returns table as return
(
  select top 1 
    lab.availabilityTime
  from
    [$(PRD_APHIM_UODS)].dbo.a_act lab with (nolock)
  where
    lab.metaCode = 'DILR_ID' 
    and
    lab.Act_Parent_ID = @parentAct
  order by
    lab.availabilityTime desc
)
