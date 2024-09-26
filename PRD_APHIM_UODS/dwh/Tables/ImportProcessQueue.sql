CREATE TABLE [dwh].[ImportProcessQueue] (
    [IPQ_RowID]                    BIGINT         IDENTITY (1, 1) NOT NULL,
    [IPQ_QDRowID]                  INT            NULL,
    [IPQ_MessagePriority]          TINYINT        DEFAULT ((3)) NULL,
    [IPQ_MessageStatus]            TINYINT        DEFAULT ((1)) NULL,
    [IPQ_MessageIdentifier]        VARCHAR (50)   NOT NULL,
    [IPQ_MessageData]              NVARCHAR (MAX) NULL,
    [IPQ_OwnerProcessIdentifier]   NVARCHAR (50)  NULL,
    [IPQ_OwnerAppID]               INT            NULL,
    [IPQ_MessageIdentifierNumeric] AS             (TRY_CAST([IPQ_MessageIdentifier] AS [float])) PERSISTED,
    CONSTRAINT [ImportProcessQueue_PK] PRIMARY KEY CLUSTERED ([IPQ_RowID] ASC) ON [DWHQueue_DataIndexGroup],
    CONSTRAINT [CHK_MessageStatus] CHECK ([IPQ_MessageStatus]>=(0) AND [IPQ_MessageStatus]<=(6)),
    CONSTRAINT [CHK_MessgePriority] CHECK ([IPQ_MessagePriority]>=(0) AND [IPQ_MessagePriority]<=(5))
) ON [DWHQueue_DataIndexGroup] TEXTIMAGE_ON [DWHQueue_DataIndexGroup];


GO
CREATE NONCLUSTERED INDEX [ImportProcessQueue_MessageIdentifierNumeric_NonClustered]
    ON [dwh].[ImportProcessQueue]([IPQ_MessageIdentifierNumeric] ASC) WITH (FILLFACTOR = 80)
    ON [DWHQueue_DataIndexGroup];

