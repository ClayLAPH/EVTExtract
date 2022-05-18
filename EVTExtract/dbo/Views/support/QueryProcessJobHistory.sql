create view dbo.QueryProcessJobHistory as
with 
s as (select ps.Status status, ps.Name name, ps.Instance instance, ps.CycleId cycle, ps.StepOccurred, ps.MessageText message, ps.NumberOfRows rows from dbo.ProcessingStatusHistory ps where ps.Status = 'starts'),
e as (select ps.Status status, ps.Name name, ps.Instance instance, ps.CycleId cycle, ps.StepOccurred, ps.MessageText message, ps.NumberOfRows rows from dbo.ProcessingStatusHistory ps where ps.Status = 'ends' ),
x as (select ps.Status status, ps.Name name, ps.Instance instance, ps.CycleId cycle, ps.StepOccurred, ps.MessageText message, ps.NumberOfRows rows from dbo.ProcessingStatusHistory ps where ps.Status = 'error')

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


