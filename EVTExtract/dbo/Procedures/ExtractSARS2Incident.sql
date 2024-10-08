﻿create procedure dbo.ExtractSARS2Incident
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'SARS2_INCIDENT',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot
  
  execute dbo.SetProcessingStatus @status, @name, @instance;

  begin try
    select @rows = count(*) 
    from 
        [$(LACCovid)].covid.SARS2_INCIDENT si
    where 
        si.PR_INCIDENTID not in ( select sa.DVPR_IncidentID from internals.Sars2Archive sa ) and
        si.PR_INCIDENTID not in ( select sa.DVPR_IncidentID from internals.Sars2Archive2 sa);

    select @status = 'ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows;
  end try
  begin catch
    select  @status ='error', @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractSARS2Incident @isRestart = 1;
  end


  return 0;

end


