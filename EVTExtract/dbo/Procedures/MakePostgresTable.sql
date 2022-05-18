create procedure dbo.MakePostgresTable
  @viewName sysname
as
begin

  set nocount on;

  declare 
    @crlf nvarchar(2) = char(13) + char(10),
    @sql nvarchar(max) = '',
    @cols nvarchar(max) = '';


  select @sql  += 
    @crlf + 'drop table if exists "' + @viewName + '";' + @crlf +
    @crlf + 'create unlogged table  "' + @viewName +'"' + @crlf + '(' ;
  select @cols = '';

  select @cols += 
    ',' +  @crlf + '  "' + c.name + '" ' + 
    case type_name(c.user_type_id)
      when 'smalldatetime'  then 'timestamp(0)'
      when 'datetime'       then 'timestamp(3)'
      when 'datetime2'      then 'timestamp(3)'
      when 'time'           then 'time('                                                 + convert( varchar, c.scale )      + ')'
      when 'char'           then 'char('                                                 + convert( varchar, c.max_length ) + ')'
      when 'nchar'          then 'char('                                                 + convert( varchar, c.max_length ) + ')'
      when 'varchar'        then case when c.max_length = -1 then 'text' else 'varchar(' + convert( varchar, c.max_length ) + ')' end
      when 'nvarchar'       then case when c.max_length = -1 then 'text' else 'varchar(' + convert( varchar, c.max_length ) + ')' end
      when 'sysname'        then 'varchar(128)'
      when 'ntext'          then 'text'
      when 'double'         then 'double precision'
      when 'bit'            then 'boolean'
      else type_name(c.user_type_id)
    end +
    ' ' + case when c.is_nullable = 0 then 'not ' else '' end + 'null'
  from
    sys.objects o 
    inner join 
    sys.columns c 
    on o.object_id = c.object_id 
  where 
    o.name = @viewName and o.schema_id = schema_id('dbo') and o.type = 'v' 
  order by
    c.column_id;

  select @sql += stuff(@cols,1,1,'') + @crlf +') TABLESPACE pg_default;' + @crlf;

  select @sql += 
    'ALTER TABLE IF EXISTS public."' + @viewName + '" OWNER to migrationuser;' + @crlf +
    'GRANT ALL ON TABLE public."' + @viewName + '" TO migrationuser;' + @crlf + 
    'GRANT SELECT ON TABLE public."' + @viewName + '" TO read_only_user;'+ @crlf;

  select @sql;

end

