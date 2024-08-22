create table dbo.SARS2_SPECIMEN_ARCHIVE2(
	PR_INCIDENTID int NOT NULL,
	[Specimen Types] varchar(255) NULL,
	[Specimen Collected Date] datetime NULL,
	[Specimen Received Date] datetime NULL,
	Result varchar(4000) NULL,
	[Specimen Notes] varchar(max) NULL,
	[Lab Report ID] int NOT NULL
)
