CREATE TABLE [Sync].[OB_TrackedChanges] (
    [DVOB_RowID]               INT         NOT NULL,
    [ChangeType]               VARCHAR (1) NOT NULL,
    [DVOB_NurseInvestigatorDR] INT         NULL,
    [DVOB_LocationDR]          INT         NULL,
    [DVOB_ProcessStatusDR]     INT         NULL
);

