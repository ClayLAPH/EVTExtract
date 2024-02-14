CREATE TABLE [Sync].[PublisherDataQueueStatus] (
    [SiteCode]                NVARCHAR (5)  NOT NULL,
    [MinDataQueueCommitOrder] BIGINT        NULL,
    [LastSyncCommitOrder]     BIGINT        NOT NULL,
    [LastSyncCommitDateTime]  DATETIME2 (7) NOT NULL,
    [LastUpdateDateTime]      DATETIME      NOT NULL,
    CONSTRAINT [PK_Sync_PublisherDataQueueStatus] PRIMARY KEY CLUSTERED ([SiteCode] ASC) ON [Sync_DataGroup],
    CONSTRAINT [CHK_PublisherDataQueueStatus_HasRow] CHECK ([sync].[IsPublisherDataQueueStatusHasRow]()<>(1)),
    CONSTRAINT [FK_Sync_PublisherDataQueueStatus_Sync_PublisherInfo] FOREIGN KEY ([SiteCode]) REFERENCES [Sync].[PublisherInfo] ([SiteCode])
) ON [Sync_DataGroup];

