CREATE TABLE dbo.All_Outbreak_Linked_Contact
(
  Disease int not null,
	DVOB_RowID int NULL,
	LinkedPatientContacts varchar(202) NOT NULL,
	IncidentID int NOT NULL,
	concatenated varchar(233) NULL
)
go
create clustered index [All_Outbreak_Linked_Contact.Fake.PrimaryKey] on dbo.All_Outbreak_Linked_Contact( IncidentID, Disease );