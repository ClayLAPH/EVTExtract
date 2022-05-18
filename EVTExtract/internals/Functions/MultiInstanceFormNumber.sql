create function internals.MultiInstanceFormNumber ( @RecordActID as int , @blnIsMultiInstanceForm as bit )  
returns table as return
(
  select 
    SecActID = A_Act.ID, 
    MultiInstanceFormNumber = row_number() over (partition by Code_ID order by A_Act.ID) 
  from   
    [$(PRD_APHIM_UODS)].dbo.A_Act with (nolock) 
    inner join 
    [$(PRD_APHIM_UODS)].dbo.A_ActRelationship with (nolock) 
    on 
      target_ID = A_Act.ID
    inner join 
    [$(PRD_APHIM_UODS)].dbo.VCP_UDForm VCP with (nolock) 
    on 
      VCP.SubjCode_ID = code_ID
  where 
    source_ID = @RecordActID  and 
    @blnIsMultiInstanceForm = 1
)