create view dbo.uvw_covid_elr as
select 
  *
from 
  dbo.uvw_covid_lab lab with (nolock)
  left outer join 
  dbo.uvw_covid_incident incident with (nolock)
  on 
    lab.IncidentID = incident.Incident_ID
