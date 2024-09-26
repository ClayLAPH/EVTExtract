create table dbo.All_Outbreak_Process_Status_History
(
  Disease int not null,
	OUTB_RowID varchar(200) NULL,
  OUTB_RowID_Int as try_cast( OUTB_RowID as int ) persisted,
	AUD_ID bigint NULL,
	AUD_OldValue nvarchar(256) NULL,
	AUD_NewValue nvarchar(256) NULL,
	AUD_ActionDate datetime NULL,
	AUD_Username varchar(202) NULL
)
go
create clustered index [All_Outbreak_Process_Status_History.Fake.PrimaryKey]
on dbo.All_Outbreak_Process_Status_History( OUTB_RowID_Int, AUD_ID, Disease )
 