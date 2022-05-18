create table internals.PersonBirthCountry
(
	PersonId 
    int not null
    constraint [PersonBirthCountry.PersonId.PrimaryKey]
      primary key clustered,

  CountryName
    varchar(255) not null
)