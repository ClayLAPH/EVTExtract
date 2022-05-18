create procedure dbo.ExtractConfigData 
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'ConfigData',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try

    truncate table internals.S_ConfigDefinition;
    insert internals.S_ConfigDefinition 
    ( ID, [key], type_UCSId, description, application_UCSId, required, TermName, defaultValue                       )
    select 
      ID, [key], type_UCSId, description, application_UCSId, required, TermName, convert(varchar(max), defaultValue )
    from 
      [$(PRD_APHIM_UODS)].dbo.S_ConfigDefinition with (nolock);
    select @rows += @@rowcount;

    truncate table internals.S_ConfigValue;
    insert internals.S_ConfigValue
    ( ID, configDefinition_ID, LastUpdated, Value,                       specialValue )
    select 
      ID, configDefinition_ID, LastUpdated, convert(varchar(max),Value), specialValue
    from 
      [$(PRD_APHIM_UODS)].dbo.S_ConfigValue with (nolock);
    select @rows += @@rowcount, @status = 'ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows;

  end try
  begin catch
    select  @status = 'error', @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractConfigData @isRestart = 1;
  end


  return 0;

end

