CREATE TABLE internals.S_ConfigDefinition
(
	ID int not null
    constraint [S_ConfigDefinition.ID.PrimaryKey]
      primary key clustered,
	[key] varchar(100) not null,
	type_UCSId int not null,
	description varchar(max) null,
	application_UCSId int not null,
	required bit null,
	TermName varchar(100) null,
	defaultValue varchar(max) null
)