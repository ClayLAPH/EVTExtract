create view dbo.uvw_COVID_SPECIMEN as
select
  Incident_ID             = c.[PR_INCIDENTID],
  Specimen_Collected_Date = c.[Specimen Collected Date],
  Specimen_Received_Date  = c.[Specimen Received Date],
  Result                  = c.[Result],
  Specimen_Notes          = c.[Specimen Notes],
  Specimen_Types          = c.[Specimen Types]
from
  dbo.COVID_SPECIMEN        c with (nolock)
