﻿CREATE TABLE dbo.COVID_OUTBREAK_PROCESS_STATUS_HISTORY
(
	OUTB_RowID varchar(200) NULL,
	AUD_ID bigint NULL,
	AUD_OldValue nvarchar(256) NULL,
	AUD_NewValue nvarchar(256) NULL,
	AUD_ActionDate datetime NULL,
	AUD_Username varchar(202) NULL
)
go
create clustered index [COVID_OUTBREAK_PROCESS_STATUS_HISTORY.OUTB_RowID.AUD_ID.Fake.PrimaryKey]
on dbo.COVID_OUTBREAK_PROCESS_STATUS_HISTORY(OUTB_RowID,AUD_ID)
 