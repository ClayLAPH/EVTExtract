create function internals.ListSectionNumber ( @UDFormActID as int , @bIndependentSection as bit)  
returns table as return
(
  select 
    SecActID = ID, 
    ListSectionNumber = row_number () over (partition by Code_ID order by ID) 
  from [$(PRD_APHIM_UODS)].dbo.A_Act with (nolock) 
  where 
    @bIndependentSection = 0 and 
    Code_ID in ( select SubjCode_ID from [$(PRD_APHIM_UODS)].dbo.VCP_UDSection with (nolock) where SEC_IsListSection = 1) and 
    Act_Parent_ID = @UDFormActID 

  union all

  select 
    SecActID = A_Act.ID , 
    ListSectionNumber = row_number () over (partition by A_Act.Code_ID order by A_Act.ID) 
  from   
	  [$(PRD_APHIM_UODS)].dbo.A_Act with (nolock) 
    INNER JOIN 
    [$(PRD_APHIM_UODS)].dbo.A_ActRelationship with (nolock) 
    ON 
      target_ID = A_Act.ID
  where 
    @bIndependentSection = 1 and 
    Code_ID in ( select SubjCode_ID from [$(PRD_APHIM_UODS)].dbo.VCP_UDSection with (nolock) where SEC_IsListSection = 1) and 
    source_ID = @UDFormActID    
)