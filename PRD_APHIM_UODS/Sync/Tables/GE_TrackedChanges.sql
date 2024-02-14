CREATE TABLE [Sync].[GE_TrackedChanges] (
    [GE_RowID]           INT         NOT NULL,
    [ChangeType]         VARCHAR (1) NOT NULL,
    [GE_InvestigatorDR]  INT         NULL,
    [GE_LocationDR]      INT         NULL,
    [GE_ProcessStatusDR] INT         NULL
);

