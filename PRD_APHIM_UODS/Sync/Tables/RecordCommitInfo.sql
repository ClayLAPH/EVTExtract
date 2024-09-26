CREATE TABLE [Sync].[RecordCommitInfo] (
    [Record_RowID]   BIGINT   NOT NULL,
    [Record_TypeDR]  TINYINT  NOT NULL,
    [LastCommitTime] DATETIME NOT NULL,
    [CommitOrder]    BIGINT   NOT NULL,
    [Status]         CHAR (1) NOT NULL,
    [LastUpdated]    BIGINT   NOT NULL,
    CONSTRAINT [PK_DWH_SyncQueue] PRIMARY KEY CLUSTERED ([Record_RowID] ASC, [Record_TypeDR] ASC) ON [Sync_DataGroup],
    CONSTRAINT [FK_RecordCommitInfo_CommitInfoRecordType] FOREIGN KEY ([Record_TypeDR]) REFERENCES [Sync].[CommitInfoRecordType] ([ID])
) ON [Sync_DataGroup];


GO
CREATE NONCLUSTERED INDEX [IX_RecordCommitInfo_CommitOrder]
    ON [Sync].[RecordCommitInfo]([CommitOrder] ASC)
    INCLUDE([LastCommitTime])
    ON [Sync_DataGroup];

