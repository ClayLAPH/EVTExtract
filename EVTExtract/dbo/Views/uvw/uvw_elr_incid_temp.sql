create view dbo.uvw_elr_incid_temp as
(
  select *, lab_cat = 'nCOV-2019'
  from 
    dbo.uvw_COVID_LAB a with (nolock)
    left outer join 
    dbo.uvw_Covid_Incident as b
    on 
      a.IncidentID = b.Incident_ID
)
union all
(
  select *, lab_cat = 'SARS-CoV-2'
  from 
    dbo.uvw_SARS2_LAB as c with (nolock) 
    left join 
    dbo.uvw_SARS2_INCIDENT d with (nolock)
    on 
      c.IncidentID=d.Incident_ID
)

