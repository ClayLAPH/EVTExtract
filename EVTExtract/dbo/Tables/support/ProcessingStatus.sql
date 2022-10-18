create table dbo.ProcessingStatus
(
  CycleId
    int not null,

  Id 
    int not null
    constraint [ProcessingStatus.Id.Default.Process.StatusSequence]
      default( next value for dbo.StatusSequence ),

  StepOccurred
    datetime not null 
    constraint[ProcessingStatus.StepOccurred.Default.getdate()] 
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
    bigint null

  constraint [ProcessingStatusId.PrimaryKey]
    primary key clustered (Id) 
)
