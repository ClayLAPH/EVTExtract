create view QueryViewReadiness as
(
  select base.name view_name, base.StepOccurred available, base.CycleId cycle
  from
    dbo.ProcessingStatus base
  where
    base.Status = 'ends'
)
union all
(
  select r.view_name, d.available, d.cycle
  from
    ( select 
        distinct v.view_name
      from
        INFORMATION_SCHEMA.VIEW_TABLE_USAGE v
        inner join
        QueryProcessJobs j
        on
          v.TABLE_NAME = j.name
      where    
        v.view_name like 'uvw%' 
        and 
        v.view_name not like '%elr%' 
        and
        v.view_name not in 
        ( select x.view_name from
          (    
            select v.name view_name
            from
              sys.views v
              left outer join
              INFORMATION_SCHEMA.VIEW_TABLE_USAGE vtu
              on
                v.name = vtu.view_name
                left outer join
              dbo.QueryProcessJobs qpj
              on
                vtu.TABLE_NAME = qpj.Name
            where
              v.name like 'uvw%' 
              and 
              v.name not like '%elr%' 
              and
              qpj.status in ( 'pending','error' )
            group by 
              v.name, vtu.table_name
          ) x
        )
    ) r
    inner join
    (
      select 
        v.view_name name, j.cycle, max(j.ended) available
      from
        INFORMATION_SCHEMA.VIEW_TABLE_USAGE v
        inner join
        QueryProcessJobs j
        on
          v.TABLE_NAME = j.name
      where    
        v.view_name like 'uvw%' 
        and 
        v.view_name not like '%elr%' 
        and
        j.status = 'finished'
      group by
        v.view_name, j.cycle
    ) d
    on
      r.view_name = d.name
)