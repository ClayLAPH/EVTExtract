create table dbo.All_Outbreak_Linked_Incident
(
  Disease int not null,
	dvob_rowid int not null,
	LinkedIndividuals varchar(202) null,
	IncidentID int not null,
	RecordType varchar(50) not null,
	concatendated varchar(284) null
)
go
create clustered index [All_Outbreak_Linked_Incident.Fake.PrimaryKey] on All_Outbreak_Linked_Incident( dvob_rowid, IncidentID, Disease )