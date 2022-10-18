create view internals.PersonRacesPivoted as
select 
  PersonId,
  [American Indian or Alaska Native],
  [Asian],
  [Black or African American],
  [Native Hawaiian or Other Pacific Islander],
  [Other],
  [Unknown],
  [White]
from
( select 
    PersonId,
    Category,
    Races =isnull([$(PRD_APHIM_UODS)].dbo.STRCONCAT(Specify),N'')
  from
    internals.PersonRacesSource prs with (nolock)
  group by
    PersonId,
    Category
) as sourceData
pivot
(
  max( Races ) -- there's only 0 or 1 - so no penalty/no comparison performed
  for Category in 
  (
    [American Indian or Alaska Native],
    [Asian],
    [Black or African American],
    [Native Hawaiian or Other Pacific Islander],
    [Other],
    [Unknown],
    [White]
  )
) as pivotData
