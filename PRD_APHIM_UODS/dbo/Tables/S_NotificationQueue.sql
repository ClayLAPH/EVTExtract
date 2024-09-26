CREATE TABLE [dbo].[S_NotificationQueue] (
    [ID]                INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FromAddress]       VARCHAR (100)   NULL,
    [ToAddress]         VARCHAR (4000)  NOT NULL,
    [MailSubject]       NVARCHAR (255)  NULL,
    [MailBody]          VARBINARY (MAX) NULL,
    [MailAttachments]   VARBINARY (MAX) NULL,
    [SentStatus]        VARCHAR (25)    DEFAULT ('Enqueued') NULL,
    [DateRequestSent]   DATETIME        DEFAULT (getdate()) NOT NULL,
    [DateProcessed]     DATETIME        DEFAULT (getdate()) NOT NULL,
    [ThreadID]          INT             NULL,
    [AttemptCounts]     INT             DEFAULT ((0)) NOT NULL,
    [SendingUserInfo]   NVARCHAR (400)  NULL,
    [SenderIP]          NVARCHAR (40)   NULL,
    [DetailStatus]      NVARCHAR (MAX)  NULL,
    [CommunicationType] TINYINT         NULL,
    CONSTRAINT [S_EMailQueue_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95) ON [PRIMARY_IDX]
) ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_S_EMailQueue_SentStatus_ThreadID]
    ON [dbo].[S_NotificationQueue]([SentStatus] ASC, [ThreadID] ASC)
    INCLUDE([ID], [DateProcessed]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

