CREATE TABLE [Sync].[PublisherInfo] (
    [SiteCode]                               NVARCHAR (5)    NOT NULL,
    [Description]                            NVARCHAR (1000) NULL,
    [DataQueueRetentionPeriodInSeconds]      INT             NOT NULL,
    [SubscriberRequestLogRetantionInSeconds] INT             NOT NULL,
    [IsActive]                               BIT             NOT NULL,
    CONSTRAINT [PK_Sync_PublisherInfo] PRIMARY KEY CLUSTERED ([SiteCode] ASC) ON [Sync_DataGroup],
    CONSTRAINT [CHK_PublisherInfo_HasRow] CHECK ([sync].[IsPublisherInfoHasRow]()<>(1))
) ON [Sync_DataGroup];

