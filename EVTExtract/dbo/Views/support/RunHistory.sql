create view dbo.RunHistory as
select top 100 percent
  CycleId, 
  convert( varchar( 8 ), dateadd( minute, datediff( minute,min( StepOccurred ),max( StepOccurred ) ), 0 ), 8 ) RunTime,
  convert( varchar( 10 ) , min( StepOccurred ) , 110 ) RunDate,
  datename( weekday, min( StepOccurred ) ) RunDay
from 
  ( select CycleId, StepOccurred  from dbo.ProcessingStatus  
    union all 
    select CycleId, StepOccurred  from dbo.ProcessingStatusHistory 
  ) runs
group by CycleId

