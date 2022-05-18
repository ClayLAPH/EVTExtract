create function internals.AttributeStringByEntity
(
  @entityId int,
  @name varchar(50)
)
returns table as return
(
  select
    att.VALUESTRING attributeString,
    att.VALUESTRING_TXT attributeStringTxt,
    att.VALUECODE_ORTX attributeCodeOrTx
  from      
    [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE att with (nolock)
  where
    att.ENTITY_ID = @entityId 
    and 
    att.NAME = @name
)
