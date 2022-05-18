CREATE TABLE [internals].[allincidentperson](
	[DVPER_MaritalStatus] [varchar](255) NULL, --*
	[DVPER_Namespace] [varchar](4) NOT NULL, --*
	[DVPER_RowID] [int] NOT NULL, 
	[DVPER_CensusTract] [varchar](100) NULL, --*
	[DVPER_OccupationSettingTypeSpecify] [varchar](255) NULL, --*
	[DVPER_GuardianName] [varchar](50) NULL, --*
	[American_Indian_or_Alaska_Native] [nvarchar](max) NULL, --*
	[Asian___Specify] [nvarchar](max) NULL, --*
	[Black_or_African_American___Spec] [nvarchar](max) NULL, --*
	[Native_Hawaiian_or_Other_Pacific] [nvarchar](max) NULL, --*
	[Other___Specify] [nvarchar](max) NULL, --*
	[Unknown___Specify] [nvarchar](max) NULL, --*
	[White___Specify] [nvarchar](max) NULL, --*
	[Country_of_Birth] [varchar](255) NULL --*
)
go
create clustered index [allincidentperson.DVPER_ROWID.Fake.PrimaryKey] 
on internals.allincidentperson( DVPER_RowID )
