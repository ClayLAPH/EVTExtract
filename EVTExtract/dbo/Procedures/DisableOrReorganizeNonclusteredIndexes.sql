create procedure dbo.DisableOrRebuildNonclusteredIndexes 
  @disableOrRebuild varchar(128) = 'disable', 
  @schemaName varchar(128) = 'dbo',
  @tableName varchar( 128 ) = null
as
begin
  set nocount on;

  declare @sql varchar(max) = '';

  select @disableOrRebuild += case when @disableOrRebuild = 'rebuild' then ' with ( online = on )' end;

  select @sql += 'alter index [' + i.name + '] on [' + @schemaName + '].[' + o.name + '] ' + @disableOrRebuild + ';' + char(13) + char(10)
  from
    sys.indexes i
    inner join
    sys.objects o
    on
      i.object_id = o.object_id
  where
    i.type_desc = 'NONCLUSTERED' and
    isnull(@tableName, o.name) = o.name and
    o.type_desc = 'USER_TABLE' and
    o.schema_id = schema_id( @schemaName );

  execute( @sql );

  return 0;
end
