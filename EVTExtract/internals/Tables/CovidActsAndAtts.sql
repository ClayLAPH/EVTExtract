create table internals.CovidActsAndAtts
(
	id 
    int not null,

	kind 
    varchar( 50 ) not null,

	valueString_Txt 
    varchar( 255 ) null,

	valueBool 
    bit null,

	valueTS 
    datetime null,

	effectiveTime_Beg 
    datetime null,

	valueString 
    varchar( 8000 ) null,

  valueCode_Id
    int null
)
go
create unique clustered index [CovidAttsAndActs.PrimaryKey] 
on internals.CovidActsAndAtts( id, kind )
