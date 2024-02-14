CREATE TABLE [Sync].[DataQueue] (
    [SiteCode]           NVARCHAR (5)    NOT NULL,
    [SeqNo]              BIGINT          IDENTITY (1, 1) NOT NULL,
    [PayloadType]        NVARCHAR (4)    NOT NULL,
    [CreateDateTime]     DATETIME        NOT NULL,
    [Payload]            VARBINARY (MAX) NULL,
    [MinCommitOrder]     BIGINT          NULL,
    [MaxCommitOrder]     BIGINT          NOT NULL,
    [LastCommitDateTime] DATETIME        NOT NULL,
    CONSTRAINT [PK_Sync_DataQueue] PRIMARY KEY CLUSTERED ([SeqNo] ASC) ON [Sync_DataGroup],
    CONSTRAINT [FK_Sync_DataQueue_Sync_PublisherInfo] FOREIGN KEY ([SiteCode]) REFERENCES [Sync].[PublisherInfo] ([SiteCode])
) ON [Sync_DataGroup] TEXTIMAGE_ON [Sync_TextDataGroup];

