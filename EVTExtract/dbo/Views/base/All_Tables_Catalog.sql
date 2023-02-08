create view dbo.All_Tables_Catalog as
select 
  o.name table_name,
  c.name column_name,
  case when c.max_length=-1 then 'max' else convert(nvarchar(128),c.max_length) end max_length,
  t.name [type_name],
  case c.is_nullable when 1 then 'yes' else 'no' end is_nullable
from 
  sys.objects o 
  inner join 
  sys.columns c 
  on 
    o.object_id = c.object_id 
  inner join
  sys.types t
  on
    c.user_type_id = t.user_type_id
where
  ( o.name like 'all\_%' escape '\' or
    o.name in( 'UnifiedCodeSet', 'Domain', 'UDF_CATALOG','DrugSusceptibility' )
  ) and
  ( o.name not like '%view'
  )
