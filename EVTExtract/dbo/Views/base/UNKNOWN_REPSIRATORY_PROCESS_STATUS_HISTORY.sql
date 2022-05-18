create view dbo.UNKNOWN_REPSIRATORY_PROCESS_STATUS_HISTORY as 
select 
  OUTB_RowID, 
  AUD_ID, 
  AUD_OldValue, 
  AUD_NewValue, 
  AUD_ActionDate, 
  AUD_Username 
from 
  [$(PRD_APHIM_UODS)].covid.UNKNOWN_REPSIRATORY_PROCESS_STATUS_HISTORY;
