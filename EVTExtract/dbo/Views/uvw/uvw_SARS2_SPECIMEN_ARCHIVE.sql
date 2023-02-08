create view dbo.uvw_SARS2_SPECIMEN_ARCHIVE as
select
  Incident_ID             = c.[PR_INCIDENTID],
  Specimen_Collected_Date = c.[Specimen Collected Date],
  Specimen_Received_Date  = c.[Specimen Received Date],
  Result                  = c.[Result],
  Specimen_Notes          = c.[Specimen Notes],
  Specimen_Types          = c.[Specimen Types]
from
  dbo.SARS2_SPECIMEN_ARCHIVE        c with (nolock)