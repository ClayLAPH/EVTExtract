create table dbo.COVID_OUTBREAK_LINKED_INCIDENT
(
	dvob_rowid int not null,
	LinkedIndividuals varchar(202) null,
	IncidentID int not null,
	RecordType varchar(50) not null,
	concatendated varchar(284) null
)
go
create clustered index [COVID_OUTBREAK_LINKED_INCIDENT.dvob_rowid.IncidentID.Fake.PrimaryKey]
on COVID_OUTBREAK_LINKED_INCIDENT(dvob_rowid,IncidentID)