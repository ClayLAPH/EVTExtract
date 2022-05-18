CREATE TABLE dbo.COVID_OUTBREAK_LINKED_CONTACT
(
	DVOB_RowID int NULL,
	LinkedPatientContacts varchar(202) NOT NULL,
	IncidentID int NOT NULL,
	concatenated varchar(233) NULL
)
go
create clustered index [COVID_OUTBREAK_LINKED_CONTACT.IncidentID.Fake.PrimaryKey] 
on dbo.COVID_OUTBREAK_LINKED_CONTACT(IncidentID);