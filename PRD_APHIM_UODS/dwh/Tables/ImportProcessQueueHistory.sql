CREATE TABLE [dwh].[ImportProcessQueueHistory] (
    [IPQH_IPQRowID]               BIGINT         NOT NULL,
    [IPQH_QDRowID]                INT            NULL,
    [IPQH_MessagePriority]        TINYINT        DEFAULT ((3)) NULL,
    [IPQH_MessageStatus]          TINYINT        DEFAULT ((0)) NULL,
    [IPQH_MessageIdentifier]      VARCHAR (50)   NOT NULL,
    [IPQH_MessageData]            NVARCHAR (MAX) NULL,
    [IPQH_OwnerProcessIdentifier] NVARCHAR (50)  NULL,
    [IPQH_OwnerAppID]             INT            NULL,
    [IPQH_CreateDate]             DATETIME       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [ImportProcessQueueHistory_PK] PRIMARY KEY NONCLUSTERED ([IPQH_IPQRowID] ASC) ON [DWHQueue_DataIndexGroup]
) ON [DWHQueue_DataIndexGroup] TEXTIMAGE_ON [DWHQueue_DataIndexGroup];

