create table Availability
(
  view_name
    sysname not null,

  cycle
    int not null,

  constraint [Availability.view_name.cycle.PrimaryKey]
    primary key clustered( view_name, cycle ),

  available
    datetime not null

)
