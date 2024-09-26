create view dbo.uvw_SARS2_SPECIMEN_ARCHIVE as
select
  Incident_ID             = c.[PR_INCIDENTID],
  Specimen_Collected_Date = c.[Specimen Collected Date],
  Specimen_Received_Date  = c.[Specimen Received Date],
  Result                  = c.[Result],
  Specimen_Notes          = c.[Specimen Notes],
  Specimen_Types          = c.[Specimen Types],
  ArchiveVersion          = 1

from
  dbo.SARS2_SPECIMEN_ARCHIVE        c 

union all

select
  Incident_ID             = c2.[PR_INCIDENTID],
  Specimen_Collected_Date = c2.[Specimen Collected Date],
  Specimen_Received_Date  = c2.[Specimen Received Date],
  Result                  = c2.[Result],
  Specimen_Notes          = c2.[Specimen Notes],
  Specimen_Types          = c2.[Specimen Types],
  ArchiveVersion          = 2

from
  dbo.SARS2_SPECIMEN_ARCHIVE2        c2;