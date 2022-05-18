select 
  viewName = convert(nvarchar(55),o.name),
  columnCount = max(column_id) over( partition by o.object_id ),
  columnPosition = column_id,
  columnName = convert(nvarchar(55),c.name),
  columnType = convert(varchar(10),type_name(c.user_type_id)),
  columnLength = c.max_length,
  columnIsNullable = c.is_nullable
from 
  sys.objects o
  inner join
  sys.columns c
  on
    o.object_id = c.object_id
where 
  o.name in ('uvw_covid_incident','uvw_covid_lab','uvw_sars2_incident', 'uvw_sars2_lab')
  and 
  o.schema_id = schema_id('dbo')
order by
  o.name,
  c.column_id