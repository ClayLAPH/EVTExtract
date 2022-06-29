create table internals.SARS2ActsAndAtts
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
create unique clustered index [SARS2ActsAndAtts.PrimaryKey] 
on internals.SARS2ActsAndAtts( id, kind )
