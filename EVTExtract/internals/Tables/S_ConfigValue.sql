create table internals.S_ConfigValue
(
	ID int not null
    constraint [S_ConfigValue.ID.PrimaryKey]
      primary key clustered,
	configDefinition_ID int not null,
	LastUpdated datetime not null,
	Value varchar(max) null,
	specialValue varchar(max) null,
)
