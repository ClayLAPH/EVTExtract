create function internals.GetMultiInstanceFormNumber( @actId int, @isMultiInstance bit , @udFormNumber int ) returns table as return
( select 
    SecActID = aa.ID, 
    MultiInstanceFormNumber = row_number() over (partition by aa.code_ID order by aa.ID)  
  from
    [$(PRD_APHIM_UODS)].dbo.A_Act                 aa with (nolock) 
    inner join
    [$(PRD_APHIM_UODS)].dbo.A_ActRelationship     ar with (nolock) 
    on 
      ar.target_ID = aa.ID
    inner join 
    [$(PRD_APHIM_UODS)].dbo.VCP_UDForm            vcp with (nolock) 
    on
      vcp.SubjCode_ID = aa.code_ID
  where 
    @isMultiInstance = 1 and
    ar.source_ID = @actId and
    aa.id = @udFormNumber
)