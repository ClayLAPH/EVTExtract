CREATE TABLE [internals].[covidacts](
	[PR_NOTES] [varchar](max) NULL, --*
	[PR_DATEINVESTIGATORRECEIVED] [datetime] NULL, --*
	[PR_LEGACY_ROWID] [varchar](50) NULL, --*
	[PR_DATEADMITTED] [datetime] NULL, --*
	[PR_DATEDISCHARGED] [datetime] NULL, --*
	[PR_ROWID] [int] NOT NULL, --*
	[PR_REPORTEDBYWEB] [bit] NULL, --*
	[PR_REPORTEDBYLAB] [bit] NULL, --*
	[PR_REPORTEDBYEHR] [bit] NULL, --*
	[PR_TRANSMISSIONSTATUS] [varchar](255) NULL, --*
	[PR_DIAGSPECIMENTYPES] [nvarchar](max) NULL, --*
	[PR_EXPEXPOSURETYPES] [nvarchar](max) NULL, --*
	[PR_HEPATITISDRS] [nvarchar](max) NULL, --*
	[PR_DISEASEGROUPS] [nvarchar](max) NULL, --*
	[PR_OTHERDISEASE] [varchar](200) NULL, --*
	[PR_RESULTVALUE] [varchar](200) NULL, --*
	[PR_LIPTESTORDERED] [varchar](255) NULL, --*
	[PR_ISPREGNANT] [bit] NULL, --*
	[PR_EXPECTEDDELIVERYDATE] [datetime] NULL, --*
	[PR_DATEOFDEATH] [datetime] NULL, --*
	[PR_ISSYMPTOMATIC] [bit] NULL, --*
	[PR_ISPATIENTDIEDOFTHEILLNESS] [bit] NULL, --*
	[PR_ISPATIENTHOSPITALIZED] [bit] NULL, --*
	[PR_LABSPECIMENCOLLECTEDDATE] [datetime] NULL, --*
	[PR_LABSPECIMENRESULTDATE] [datetime] NULL, --*
	[PR_OUTPATIENT] [bit] NULL, --*
	[PR_INPATIENT] [bit] NULL, --*
	[PR_NAMEOFSUBMITTER] [varchar](8000) NULL, --*
	[PR_HOSPITAL] [varchar](250) NULL, --*
	[PR_HOSPITALDR] [int] NULL, --*
	[PR_ANIMALREPORTID] [int] NULL, --*
	[PR_FBIDR] [int] NULL, --*
	[PR_FBINumber] [varchar](50) NULL

)
go
create clustered index [covidacts.pr_rowid.fakeprimaryKey]
on internals.covidacts( PR_ROWID )
  