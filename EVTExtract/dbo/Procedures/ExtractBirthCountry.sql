create procedure dbo.ExtractBirthCountry
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'BirthCountry',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;
   
  -- this table must be brought local to collect BirthCountry
  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try
    select @rows = 0;
    update internals.PersonBirthCountry 
    set CountryName = x.CountryName
    from
    (
      select source.PersonId,source.CountryName from
      (
        select PersonId, CountryName, binary_checksum(*) crc
        from internals.SourceBirthCountry with (nolock)
      ) source
      full outer join
      (
        select PersonId, binary_checksum(*) crc
        from internals.PersonBirthCountry with (nolock)
      ) as target
        on source.PersonId = target.PersonId
      where source.crc != target.crc
    ) x
    where PersonBirthCountry.PersonId = x.PersonId
    
    select @rows += @@rowcount;

    insert internals.PersonBirthCountry( PersonId, CountryName )
    select source.PersonId, source.CountryName
    from internals.SourceBirthCountry source with (nolock)
    where source.PersonId not in ( select PersonId from internals.PersonBirthCountry target with (nolock) )
    
    select @rows += @@rowcount;
    select @status = 'ends';
    execute dbo.SetProcessingStatus @status,@name, @instance, @rows;

  end try
  begin catch
    select  @status = 'error', @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractBirthCountry @isRestart = 1;
  end
  
  return 0;
end;