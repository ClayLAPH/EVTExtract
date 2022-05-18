create table internals.allincidentlab
(
	Id int not NULL,
	availabilityTime datetime NULL,
	Most_Recent_Lab_Result varchar(1100) NOT NULL,
	Most_Recent_Lab_Result_Value varchar(4000) NULL
)
go
create clustered index [allincidentlab.fake.primarykey] on internals.allincidentlab( Id )