create procedure dbo.ExtractAllDiseaseCodes
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'ALL_DISEASE_CODES',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  begin try
    execute dbo.SetProcessingStatus @status, @name, @instance;
    truncate table dbo.All_Disease_Codes;
    insert dbo.All_Disease_Codes 
    ( 
      Id, FullName, ShortName
    )
    select
      c.ID, c.fullName, c.shortName
    from
      [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet c
    where 
      Domain_Id = 10

    select @rows = @@rowcount, @status = 'ends';
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
    execute dbo.ExtractAllDiseaseCodes @isRestart = 1;
  end

  return 0;

end

