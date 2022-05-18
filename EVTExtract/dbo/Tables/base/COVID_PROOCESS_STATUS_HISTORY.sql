CREATE TABLE dbo.COVID_PROCESS_STATUS_HISTORY
(
	PR_RowID varchar(200) NULL,
  PR_ROWID_INT as try_cast(PR_ROWID as int) persisted,
	AUD_ID bigint NULL,
	AUD_OldValue varchar(255) NULL,
	AUD_NewValue varchar(255) NULL,
	AUD_ActionDate datetime NULL,
	AUD_Username varchar(202) NULL
)
go 
create clustered index [COVID_PROCESS_STATUS_HISTORY.PR_ROWID_INT.Fake.PrimaryKey]
on dbo.COVID_PROCESS_STATUS_HISTORY(PR_ROWID_INT)