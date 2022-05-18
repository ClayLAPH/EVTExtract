create function internals.IncidentSpecimensNotes( @pr_rowId int )returns table as return
(
  select 
    notes = [$(PRD_APHIM_UODS)].dbo.STRCONCAT(DILR_Notes)
  from
    [$(PRD_APHIM_UODS)].dbo.A_Act a with (nolock) 
    inner join
    internals.AX_LabReport lr with (nolock)       
    on
      a.ID=lr.DILR_ID 
  where
    a.Act_Parent_ID =  @pr_rowId
)