CREATE TABLE [Sync].[PR_TrackedChanges] (
    [DVPR_RowID]               INT         NOT NULL,
    [DVPER_RowID]              INT         NOT NULL,
    [ChangeType]               VARCHAR (1) NOT NULL,
    [DVPR_NurseInvestigatorDR] INT         NULL,
    [DVPR_ReportSourceDR]      INT         NULL,
    [DVPR_ProcessStatusDR]     INT         NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [PK_PR_TrackedChanges]
    ON [Sync].[PR_TrackedChanges]([DVPR_RowID] ASC) WITH (FILLFACTOR = 95);


GO
CREATE NONCLUSTERED INDEX [IX_ChangeType]
    ON [Sync].[PR_TrackedChanges]([ChangeType] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_DVPER_RowID]
    ON [Sync].[PR_TrackedChanges]([DVPER_RowID] ASC) WITH (FILLFACTOR = 70);

