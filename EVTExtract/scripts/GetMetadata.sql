select 
  oName    = convert(nchar(55),o.name),
  pos      = convert(nchar(2),column_id),
  name     = convert(nchar(55),c.name),
  type     = convert(nchar(10),type_name(c.user_type_id)),
  length   = case when c.max_length=-1 then 'max' else convert(nchar(5),c.max_length) end,
  nullable = case when c.is_nullable=1 then 'yes' else 'no ' end
from 
  sys.objects o
  inner join
  sys.columns c
  on
    o.object_id = c.object_id
where 
  o.name in('?')
  and 
  o.schema_id in ( schema_id('?') )
order by
  o.name,
  c.column_id