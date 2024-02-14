CREATE TABLE [dwh].[Engine_QueueDef] (
    [QD_RowID]     INT            IDENTITY (1, 1) NOT NULL,
    [QD_CIRowID]   INT            NULL,
    [QD_QueueName] NVARCHAR (100) NULL,
    [QD_IsActive]  BIT            NULL,
    CONSTRAINT [EngineQueueDef_PK] PRIMARY KEY CLUSTERED ([QD_RowID] ASC) ON [DWHQueue_DataIndexGroup],
    CONSTRAINT [CHK_QueueNameUnique] UNIQUE NONCLUSTERED ([QD_QueueName] ASC) ON [DWHQueue_DataIndexGroup]
) ON [DWHQueue_DataIndexGroup];

