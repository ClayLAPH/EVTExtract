create view dbo.uvw_SARS2_OB_PROCESS_STATUS as
select
  P.OUTB_RowID                                               Row_ID,
  O.OUTB_OUTBREAKID                                          Outbreak_ID,
  O.OUTB_OutbreakNumber                                      Outbreak_Number,
  O.OUTB_OutbreakLocation                                    Location,
  P.AUD_ID                                                   AUD_ID,
  P.AUD_OldValue                                             Old_Value,
  P.AUD_NewValue                                             New_Value,
  try_convert(datetime,P.AUD_ActionDate)                     Action_Date,
  P.AUD_Username                                             Username
from    
  dbo.SARS2_OUTBREAK_PROCESS_STATUS_HISTORY as P with (nolock) 
	inner join
  dbo.SARS2_OUTBREAK as O with (nolock)
  on 
    P.OUTB_RowID = O.OUTB_RowID

