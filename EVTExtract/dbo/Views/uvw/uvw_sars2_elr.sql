create view dbo.uvw_sars2_elr as
select 
  * 
from 
  dbo.uvw_sars2_lab lab with (nolock)
  left outer join 
  dbo.uvw_sars2_incident incident with (nolock)
  on 
    lab.IncidentID = incident.Incident_ID