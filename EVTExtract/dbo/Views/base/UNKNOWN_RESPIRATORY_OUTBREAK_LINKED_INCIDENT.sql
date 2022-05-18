create view dbo.UNKNOWN_RESPIRATORY_OUTBREAK_LINKED_INCIDENT as 
select 
  dvob_rowid, 
  LinkedIndividuals, 
  IncidentID, 
  RecordType, 
  concatendated 
from 
  [$(PRD_APHIM_UODS)].covid.UNKNOWN_RESPIRATORY_OUTBREAK_LINKED_INCIDENT;
