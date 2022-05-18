create function internals.AttributeDateTimeByEntity
(
  @entityId int,
  @name varchar(50)
)
returns table as return
(
  select
    att.VALUETS attributeDateTime,
    att.VALUETSEND attributeDateTimeEnd
  from      
    [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE att with (nolock)
  where
    att.ENTITY_ID = @entityId 
    and 
    att.NAME = @name
)