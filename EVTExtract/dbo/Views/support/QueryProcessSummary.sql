create view dbo.QueryProcessSummary as
select s.starts, e.ends, x.errors, j.jobs, t.totaltime, j.CycleId cycleid
from
( select count(*) starts from dbo.ProcessingStatus ps where ps.Status = 'starts' ) s
cross join
( select count(*) ends from dbo.ProcessingStatus ps where ps.Status = 'ends' ) e
cross join
( select count(*) errors from dbo.ProcessingStatus ps where ps.Status = 'error' ) x
cross join
( select c.TotalJobs jobs, c.CycleId from dbo.ProcessingStatusCycle c where c.CycleId in (select max(CycleId) from dbo.ProcessingStatusCycle ) ) j
cross join
( select convert( varchar( 8 ), dateadd( minute, datediff( minute,min( started ),max( ended ) ), 0 ), 8 ) totaltime from dbo.QueryProcessJobs ) t
