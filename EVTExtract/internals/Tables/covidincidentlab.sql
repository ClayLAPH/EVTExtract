create table internals.covidincidentlab
(
	Id int not NULL
    constraint [covidincidentlab.primarykey]
      primary key clustered,
	availabilityTime datetime NULL,
	Most_Recent_Lab_Result varchar(1100) NOT NULL,
	Most_Recent_Lab_Result_Value varchar(4000) NULL
)