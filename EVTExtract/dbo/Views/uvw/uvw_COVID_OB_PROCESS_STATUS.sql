create view dbo.uvw_COVID_OB_PROCESS_STATUS as
select 
  Row_ID          = history.OUTB_RowID,
  Outbreak_ID     = outbreak.OUTB_OUTBREAKID,
  Outbreak_Number = outbreak.OUTB_OutbreakNumber,
  Location        = outbreak.OUTB_OutbreakLocation,
  AUD_ID          = history.AUD_ID,
  Old_Value       = history.AUD_OldValue,
  New_Value       = history.AUD_NewValue,
  Action_Date     = history.AUD_ActionDate,
  Username        = history.AUD_Username
from 
  dbo.COVID_OUTBREAK_PROCESS_STATUS_HISTORY     history with (nolock) 
	inner join 
  dbo.COVID_OUTBREAK                            outbreak with (nolock)
  on 
    try_convert(int,history.OUTB_RowID) = outbreak.OUTB_RowID
