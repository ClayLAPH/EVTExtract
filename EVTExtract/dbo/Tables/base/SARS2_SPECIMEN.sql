create table dbo.SARS2_SPECIMEN
(
	PR_INCIDENTID 
    int not null,
	[Specimen Types] 
    varchar(255) null,
	[Specimen Collected Date] 
    datetime null,
	[Specimen Received Date] 
    datetime null,
	[Result] 
    varchar(4000) null,
	[Specimen Notes] 
    varchar(max) null,
	[Lab Report ID] 
    int not null
)
go
create clustered index [SARS2_SPECIMEN.PR_INCIDENTID,Lab Report ID.Fake.PrimaryKey] 
on dbo.SARS2_SPECIMEN(PR_INCIDENTID, [Lab Report ID]);
go
create index [SARS2_SPECIMEN.Lab Report ID.Index]
on dbo.SARS2_SPECIMEN([Lab Report ID]);