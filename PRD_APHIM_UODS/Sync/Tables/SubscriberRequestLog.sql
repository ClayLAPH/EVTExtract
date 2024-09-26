CREATE TABLE [Sync].[SubscriberRequestLog] (
    [RowID]               BIGINT       IDENTITY (1, 1) NOT NULL,
    [SiteCode]            NVARCHAR (5) NOT NULL,
    [RequestSeqNo]        BIGINT       NOT NULL,
    [RequestCommitOrder]  BIGINT       NULL,
    [RequestSyncDateTime] DATETIME     NOT NULL,
    [RequestDateTime]     DATETIME     NOT NULL,
    CONSTRAINT [PK_Sync_SubscriberRequestLog] PRIMARY KEY CLUSTERED ([RowID] ASC) ON [Sync_DataGroup]
) ON [Sync_DataGroup];

