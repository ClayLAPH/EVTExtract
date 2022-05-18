create table dbo.ProcessingStatusHistory
(
  CycleId
    int not null,    

  Id 
    int not null,

  StepOccurred
    datetime not null
    constraint[ProcessingStatusHistory.StepOccurred.Default.getdate()] 
      default ( getdate( ) ),

  Name
    sysname not null,

  Instance 
    int not null,

  MessageText
    nvarchar( max ) null,

  Status
    nvarchar( 20 ) not null,

  NumberOfRows 
    bigint null,

  constraint [ProcessingStatusHistory.CycleId.Id.PrimaryKey]
    primary key clustered( CycleId, Id ),
)