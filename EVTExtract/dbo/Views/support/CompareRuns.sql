create view dbo.CompareRuns as
with qp as (select 
  l.name,
  run_date       = convert(date,r.started),
  prev_start     = convert(time(0),l.started),
  run_start      = convert(time(0),r.started),
  prev_end       = convert(time(0),l.ended),
  run_end        = convert(time(0),r.ended),
  prev_run       = l.cycle, 
  this_run       = r.cycle,
  prev_mins      = l.elapsedMinutes,
  run_mins       = r.elapsedMinutes,
  prev_row_count = l.rows,
  row_count      = r.rows,
  delta          = r.rows - l.rows
from   
(
  select lj.* from dbo.QueryProcessJobs lj
  union all
  select lh.* from dbo.QueryProcessJobHistory lh
) l
inner join
(
  select rj.* from dbo.QueryProcessJobs rj
  union all
  select rh.* from dbo.QueryProcessJobHistory rh
) r
on
  l.name = r.name and
  l.cycle != r.cycle
)
select 
  o.this_run run_nbr,
  o.name, 
  o.prev_mins, o.run_mins, 
  o.prev_row_count, o.row_count, o.delta,
  o.run_date, o.prev_start, o.run_start, o.prev_end, o.run_end
from qp o 
where 
  o.prev_run in 
  ( select max(i.prev_run) 
    from qp i  
    where i.prev_run < o.this_run
  ) 
  and 
  ( o.name like 'covid&_%' escape '&' or 
    o.name like 'sars2&_%' escape '&' or 
    o.name like 'unknown%' 
  );