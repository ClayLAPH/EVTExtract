create view dbo.UNKNOWN_RESPIRATORY_OUTBREAK_LINKED_CONTACT as 
select 
  DVOB_RowID, 
  LinkedPatientContacts, 
  IncidentID, 
  concatenated 
from 
  [$(PRD_APHIM_UODS)].covid.UNKNOWN_RESPIRATORY_OUTBREAK_LINKED_CONTACT;
