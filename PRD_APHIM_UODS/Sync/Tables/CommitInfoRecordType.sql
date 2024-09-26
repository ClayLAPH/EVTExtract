CREATE TABLE [Sync].[CommitInfoRecordType] (
    [ID]              TINYINT       NOT NULL,
    [Type]            VARCHAR (10)  NOT NULL,
    [TypeDescription] VARCHAR (100) NULL,
    CONSTRAINT [PK_RecordType] PRIMARY KEY CLUSTERED ([ID] ASC) ON [Sync_DataGroup]
) ON [Sync_DataGroup];

