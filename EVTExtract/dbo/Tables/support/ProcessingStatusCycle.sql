create table dbo.ProcessingStatusCycle
(
  CycleId 
    int not null
    constraint [ProcessingStatusCycle.CycleId.PrimaryKey] 
      primary key clustered,

  OccurredOn
    datetime not null
    constraint [ProcessingStatusCycle.OccurredOn.Default.GetDate]
      default( getdate( ) ),

  TotalJobs
    int not null
    constraint [ProcessingStatusCycle.TotalJobs.Default.0]
      default( 0 )

)
