create procedure dbo.MakePostgresInsertStatements
  @targetView sysname = null
as
begin

  set nocount on;

  declare 
    @viewName sysname,
    @writeToTemp bit = 0,
    @crlf nvarchar(2) = char(13) + char(10),
    @sql nvarchar(max) = '',
    @cols nvarchar(max) = '',
    @jobName sysname,
    @jobStepName sysname =  'one';

  declare @except table( name sysname );
  insert @except select o.name from sys.objects o where name like 'uvw%elr%';

  declare c cursor local for 
    select o.name
    from sys.objects o 
    where 
      o.name = isnull( @targetView, o.name ) and
      o.name like 'uvw%' and 
      o.schema_id = schema_id('dbo') and 
      o.type = 'v' and
      o.name not in ( select name from @except )
    order by o.name;

  open c

  while ( 1 = 1 )
  begin

    fetch next from c into @viewName;
    if ( @@fetch_status != 0 ) break;

    select @jobName = 'evt_push_' + @viewName;

    if not exists( select * from msdb.dbo.sysjobs j where j.name = @jobName )
    begin
      execute msdb.dbo.sp_add_job @job_name = @jobName, @enabled = 0;
      execute msdb.dbo.sp_add_jobserver @job_name=@jobName;
      print(@jobName);
    end

    select @sql =
      @crlf + '  truncate table "' + @viewName + '"' +
      @crlf + ' insert into "' + @viewName + '"' + @crlf + '(' ;    

    select @cols = '';
    select @cols += 
      ',' +  @crlf + '  "' + c.name + '"' 
    from
      sys.objects o 
      inner join 
      sys.columns c 
      on o.object_id = c.object_id 
    where 
      o.name = @viewName and o.schema_id = schema_id('dbo') and o.type = 'v' 
    order by
      c.column_id;

    select @sql += 
      stuff( @cols, 1, 1, '' ) + 
      @crlf +')' + 
      @crlf + 'select* from (' + 
      @crlf + 'dblink(''conn_string_goes_here'', ''select ' +
      @crlf;

    select @cols = '';
    select @cols += ',' +  @crlf + '  ' + c.name 
    from
      sys.objects o 
      inner join 
      sys.columns c 
      on o.object_id = c.object_id 
    where 
      o.name = @viewName and o.schema_id = schema_id('dbo') and o.type = 'v' 
    order by
      c.column_id;

    select @sql += 
      stuff(@cols,1,1,'') + 
      @crlf + 'from dbo.'+ @viewName + ' with (nolock)'')' + 
      @crlf + 'as x (' + 
      @crlf;

    select @cols = '';
    select @cols += 
      ',' +  @crlf + '  "' + c.name + '" ' + 
      case type_name(c.user_type_id)
        when 'smalldatetime'  then 'timestamp(0)'
        when 'datetime'       then 'timestamp(3)'
        when 'datetime2'      then 'timestamp(3)'
        when 'time'           then 'time(0)'
        when 'char'           then 'char('                                                 + convert( varchar, c.max_length ) + ')'
        when 'nchar'          then 'char('                                                 + convert( varchar, c.max_length ) + ')'
        when 'varchar'        then case when c.max_length = -1 then 'text' else 'varchar(' + convert( varchar, c.max_length ) + ')' end
        when 'nvarchar'       then case when c.max_length = -1 then 'text' else 'varchar(' + convert( varchar, c.max_length ) + ')' end
        when 'ntext'          then 'text'
        when 'double'         then 'double precision'
        when 'bit'            then 'boolean'
        else type_name(c.user_type_id)
      end -- +
      -- ' ' + case when c.is_nullable = 0 then 'not ' else '' end + 'null'
    from
      sys.objects o 
      inner join 
      sys.columns c 
      on o.object_id = c.object_id 
    where 
      o.name = @viewName and o.schema_id = schema_id('dbo') and o.type = 'v' 
    order by
      c.column_id;

    select @sql += stuff(@cols,1,1,'') + ')';
    select  @sql;
  
  end

  close c;

  deallocate c;

end
