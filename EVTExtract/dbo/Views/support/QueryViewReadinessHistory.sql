create view dbo.QueryViewReadinessHistory as
select q.cycle, q.view_name, q.available
from dbo.QueryViewReadiness q
union all
select a.cycle, a.view_name, a.available
from dbo.Availability a
