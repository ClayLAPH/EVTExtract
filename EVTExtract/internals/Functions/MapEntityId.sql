
create function internals.MapEntityId( @entityId int )  
returns table as return
(	 
	with m as
	(
		select r.scoper_ID, r.player_ID, r.classCode, r.statusCode, 1 height
    from 
      [$(PRD_APHIM_UODS)].dbo.R_Role          r with (nolock) 
    where 
      r.player_ID = @entityId and
      r.classCode = 'SUBY' and 
      r.statusCode = 'Completed' and 
      r.player_ID != r.scoper_ID
		union all
		select r.scoper_ID, r.player_ID, r.classCode, r.statusCode, m.height + 1
    from  
      m 
      inner join 
      [$(PRD_APHIM_UODS)].dbo.R_Role          r with (nolock) 
      on 
        r.player_ID = m.scoper_ID and 
        r.classCode = m.classCode and 
        r.statusCode = m.statusCode  
	)
	select top 1 m.scoper_ID MappedEntityId
  from 
    m
		inner join
    [$(PRD_APHIM_UODS)].dbo.E_Entity          e with (nolock) 
    on 
      e.ID = m.scoper_ID and 
      e.statusCode <> 'TERMINATED'
  order by
    height desc
  union all 
	select r.scoper_ID
  from 
    [$(PRD_APHIM_UODS)].dbo. R_Role           r with (nolock)	
  where 
    r.classCode = 'SUBY'  and 
    r.statusCode = 'Completed' and 
    r.player_ID = r.scoper_ID 	and 
    r.player_ID = @entityId
)
