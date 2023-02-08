create view dbo.SARS2_SPECIMEN_COMBINED as
select
  PR_INCIDENTID, [Specimen Types], [Specimen Collected Date], [Specimen Received Date], Result, [Specimen Notes], [Lab Report ID]
from dbo.SARS2_SPECIMEN_ARCHIVE
union all
select
  PR_INCIDENTID, [Specimen Types], [Specimen Collected Date], [Specimen Received Date], Result, [Specimen Notes], [Lab Report ID]
from dbo.SARS2_SPECIMEN
