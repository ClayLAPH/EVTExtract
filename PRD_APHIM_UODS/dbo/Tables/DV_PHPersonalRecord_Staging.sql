CREATE TABLE [dbo].[DV_PHPersonalRecord_Staging] (
    [DVPR_RowID]         INT      NOT NULL,
    [DVPR_IncidentID]    INT      NOT NULL,
    [DVPR_CreateDate]    DATETIME NULL,
    [DVPR_DateOfMessage] DATETIME NULL,
    CONSTRAINT [PK_DV_PHPersonalRecord_Staging] PRIMARY KEY CLUSTERED ([DVPR_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_DV_PHPersonalRecord_Staging_DV_PHPersonalRecord] FOREIGN KEY ([DVPR_RowID]) REFERENCES [dbo].[DV_PHPersonalRecord] ([DVPR_RowID])
);


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord_Staging] NOCHECK CONSTRAINT [FK_DV_PHPersonalRecord_Staging_DV_PHPersonalRecord];


GO
CREATE NONCLUSTERED INDEX [IX_DV_PHPersonalRecord_Staging_CreateDate]
    ON [dbo].[DV_PHPersonalRecord_Staging]([DVPR_CreateDate] DESC, [DVPR_IncidentID] DESC)
    INCLUDE([DVPR_DateOfMessage]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_PHPersonalRecord_Staging_DateOfMessage]
    ON [dbo].[DV_PHPersonalRecord_Staging]([DVPR_DateOfMessage] DESC, [DVPR_IncidentID] DESC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

