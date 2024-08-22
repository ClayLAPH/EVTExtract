create view dbo.SARS2_OUTBREAK_PROCESS_STATUS_HISTORY_COMBINED as
select
  OUTB_RowID, AUD_ID, AUD_OldValue, AUD_NewValue, AUD_ActionDate, AUD_Username
from dbo.SARS2_OUTBREAK_PROCESS_STATUS_HISTORY_ARCHIVE
union all
select
  OUTB_RowID, AUD_ID, AUD_OldValue, AUD_NewValue, AUD_ActionDate, AUD_Username
from dbo.SARS2_OUTBREAK_PROCESS_STATUS_HISTORY_ARCHIVE2
union all
select
  OUTB_RowID, AUD_ID, AUD_OldValue, AUD_NewValue, AUD_ActionDate, AUD_Username
from dbo.SARS2_OUTBREAK_PROCESS_STATUS_HISTORY