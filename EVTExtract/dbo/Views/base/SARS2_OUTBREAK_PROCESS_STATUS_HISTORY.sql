create view dbo.SARS2_OUTBREAK_PROCESS_STATUS_HISTORY as 
select 
  OUTB_RowID, 
  AUD_ID, 
  AUD_OldValue, 
  AUD_NewValue, 
  AUD_ActionDate, 
  AUD_Username 
from 
  [$(PRD_APHIM_UODS)].covid.SARS2_OUTBREAK_PROCESS_STATUS_HISTORY;
