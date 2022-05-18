create function internals.Lab_Act_ID ( @Id int ) returns table as return
(
    select top 1 aa.ID Id
    from 
      [$(PRD_APHIM_UODS)].dbo.A_ACT aa with (nolock)
    where 
      aa.METACODE='DILR_ID' and 
      aa.Act_Parent_ID=@ID
    order by 
      aa.AvailabilityTime desc, 
      aa.ID desc
)
