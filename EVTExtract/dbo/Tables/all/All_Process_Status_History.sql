create table dbo.All_Process_Status_History
(
  Disease int not null,
	PR_RowID varchar(200) NULL,
  PR_ROWID_INT as try_cast(PR_ROWID as int) persisted,
	AUD_ID bigint NULL,
	AUD_OldValue varchar(255) NULL,
	AUD_NewValue varchar(255) NULL,
	AUD_ActionDate datetime NULL,
	AUD_Username varchar(202) NULL
)
go 
create clustered index [All_Process_Status_History.Fake.PrimaryKey]
on dbo.All_Process_Status_History( PR_ROWID_INT, AUD_ID, Disease )