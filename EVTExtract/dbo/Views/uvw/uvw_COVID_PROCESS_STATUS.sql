create view dbo.uvw_COVID_PROCESS_STATUS as
select
  stat.PR_RowID_INT Row_ID, 
  incident.PR_INCIDENTID Incident_ID, 
  person.PER_ClientID Person_ID, 
  person.PER_LASTNAME Last_Name, 
  person.PER_FIRSTNAME First_Name, 
  stat.AUD_ID AUD_ID, 
  stat.AUD_OldValue Old_Value, 
  stat.AUD_NewValue New_Value, 
  try_convert(datetime, stat.AUD_ActionDate) Action_Date, 
  stat.AUD_Username Username
from   
  dbo.COVID_PROCESS_STATUS_HISTORY  stat with (nolock)
  inner join 
  dbo.COVID_INCIDENT incident with (nolock)
  on 
    stat.PR_RowID_INT = incident.PR_ROWID
  inner join 
  dbo.COVID_PERSON person with (nolock)
  on
    person.PER_ROWID = incident.PR_PersonDR

