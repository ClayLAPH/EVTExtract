create table dbo.All_Specimen
(
  Disease                   int not null,
	PR_INCIDENTID             int not null,
	[Specimen Types]          varchar(255) null,
	[Specimen Collected Date] datetime null,
	[Specimen Received Date]  datetime null,
	[Result]                  varchar(4000) null,
	[Specimen Notes]          varchar(max) null,
	[Lab Report ID]           int not null
)
go
create clustered index [All_Specimen.Fake.PrimaryKey] 
on dbo.All_Specimen(PR_INCIDENTID, [Lab Report ID], Disease );
go
create index [All_Specimen.Lab Report ID.Index]
on dbo.All_Specimen([Lab Report ID]);