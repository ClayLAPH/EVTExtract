create function internals.GetDependentListSectionNumber( @udfFormActId int ) returns table as return
( select 
    SecActID = aa.ID, 
    ListSectionNumber = row_number() over (partition by aa.code_ID order by aa.ID)  
  from
    [$(PRD_APHIM_UODS)].dbo.A_Act aa with (nolock) 
  where 
    aa.Act_Parent_ID = @udfFormActId and
    aa.code_ID in 
    ( select uds.SubjCode_ID 
      from [$(PRD_APHIM_UODS)].dbo.VCP_UDSection uds with (nolock)  
      where uds.SEC_IsListSection = 1
    ) 
)