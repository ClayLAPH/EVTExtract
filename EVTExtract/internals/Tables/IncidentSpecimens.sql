create table internals.IncidentSpecimens
(
	DVIS_CollectionDate datetime null,
	DVIS_ReceivedDate datetime null,
	DVIS_SpecimenTypeCode_ID int null,
	DVIS_IncidentDR int null,
	DVIS_RowID int not null,
	DVIS_SpecimenResults varchar(4000) null
)
go
create clustered index [IncidentSpecimens.DVIS_RowID.Index]
on internals.IncidentSpecimens( DVIS_RowID, DVIS_CollectionDate )
