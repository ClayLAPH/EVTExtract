CREATE TABLE [dbo].[RMR_RuleRecordStatistics] (
    [RRS_RowID]              BIGINT         IDENTITY (1, 1) NOT NULL,
    [RRS_RIRowID]            INT            NOT NULL,
    [RRS_RecordType]         VARCHAR (10)   NOT NULL,
    [RRS_RecordRowID]        INT            NOT NULL,
    [RRS_IsImportFailed]     BIT            DEFAULT ((0)) NOT NULL,
    [RRS_ErrorMessage]       NVARCHAR (MAX) NULL,
    [RRS_DateCreated]        DATETIME       DEFAULT (getdate()) NOT NULL,
    [RRS_RecordRowIDNumeric] AS             (CONVERT([float],case when isnumeric([RRS_RecordRowID])=(1) then [RRS_RecordRowID]  end)) PERSISTED,
    CONSTRAINT [PK_RuleRecordStatistics] PRIMARY KEY CLUSTERED ([RRS_RowID] ASC) ON [RMR_DataIndexGroup],
    CONSTRAINT [FK_RuleRecordStatistics_RuleIdentifier] FOREIGN KEY ([RRS_RIRowID]) REFERENCES [dbo].[RMR_RuleIdentifier] ([RI_RowID])
) ON [RMR_DataIndexGroup] TEXTIMAGE_ON [RMR_DataIndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_RuleRecordStatistics]
    ON [dbo].[RMR_RuleRecordStatistics]([RRS_RecordRowID] ASC, [RRS_RecordType] ASC, [RRS_RowID] ASC) WITH (FILLFACTOR = 80)
    ON [RMR_DataIndexGroup];

