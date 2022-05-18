create view dbo.QueryProcessJobs as
with 
s as (select ps.Status status, ps.Name name, ps.Instance instance, ps.CycleId cycle, ps.StepOccurred, ps.MessageText message, ps.NumberOfRows rows from dbo.ProcessingStatus ps where ps.Status = 'starts'),
e as (select ps.Status status, ps.Name name, ps.Instance instance, ps.CycleId cycle, ps.StepOccurred, ps.MessageText message, ps.NumberOfRows rows from dbo.ProcessingStatus ps where ps.Status = 'ends' ),
x as (select ps.Status status, ps.Name name, ps.Instance instance, ps.CycleId cycle, ps.StepOccurred, ps.MessageText message, ps.NumberOfRows rows from dbo.ProcessingStatus ps where ps.Status = 'error'),
n as (select 'not started' status, pd.Name name, -1 instance, -1 cycle, convert(datetime,null) StepOccurred, convert(varchar(max),null) message, 0 rows from dbo.ProcessingDocuments pd  )

select
  'finished' status, s.name, s.instance, s.StepOccurred started, e.StepOccurred ended, 
  datediff( minute, s.StepOccurred, e.StepOccurred ) elapsedMinutes, 
  e.rows, e.message, e.cycle
from
  s inner join e 
  on 
    s.name = e.name and 
    s.instance = e.instance

union all
select
  x.status, s.name, s.instance, s.StepOccurred started, x.StepOccurred ended, 
  datediff( minute, s.StepOccurred, x.StepOccurred ) elapsedMinutes, 
  x.rows, x.message, x.cycle
from
  s inner join x 
  on 
    s.name = x.name and 
    s.instance = x.instance

union all
select
  'pending', s.name, s.instance, s.StepOccurred started, a.StepOccurred ended, 
  datediff( minute, s.StepOccurred, getdate( ) ) elapsedMinutes, 
  s.rows, s.message, s.cycle
from
  s left outer join ( select * from e union all select * from x  ) a 
  on 
    s.name = a.name 
where
  a.StepOccurred is null

union all
select
  'pending', n.name, n.instance, n.StepOccurred started, n.StepOccurred ended, 
  convert(int, null) elapsedMinutes, 
  n.rows, n.message, n.cycle
from
  n where name not in ( select Name from dbo.ProcessingStatus where status='starts' ) 

