create table dbo.COVID_SPECIMEN
(
	PR_INCIDENTID             int not null,
	[Specimen Types]          varchar(255) null,
	[Specimen Collected Date] datetime null,
	[Specimen Received Date]  datetime null,
	[Result]                  varchar(4000) null,
	[Specimen Notes]          varchar(max) null,
	[Lab Report ID]           int not null
)
go
create clustered index [COVID_SPECIMEN.PR_INCIDENTID,Lab Report ID.Fake.PrimaryKey] 
on dbo.COVID_SPECIMEN(PR_INCIDENTID, [Lab Report ID]);
go
create index [COVID_SPECIMEN.Lab Report ID.Index]
on dbo.COVID_SPECIMEN([Lab Report ID]);