CREATE TABLE [dwh].[Engine_QueueAppRelation] (
    [QAR_RowID]       INT IDENTITY (1, 1) NOT NULL,
    [QAR_QDRowID]     INT NOT NULL,
    [QAR_ADRowID]     INT NOT NULL,
    [QAR_IsAppActive] BIT NULL,
    CONSTRAINT [EngineQueueAppRelation_PK] PRIMARY KEY CLUSTERED ([QAR_RowID] ASC) ON [DWHQueue_DataIndexGroup],
    CONSTRAINT [CHK_QARAppRelation] CHECK ([DWH].[FN_RMR_CheckQueueAndRelation]([QAR_RowID],[QAR_QDRowID],[QAR_ADRowID])=(1)),
    CONSTRAINT [CHK_QueueAndAPPIdsUnique] UNIQUE NONCLUSTERED ([QAR_QDRowID] ASC, [QAR_ADRowID] ASC) ON [DWHQueue_DataIndexGroup]
) ON [DWHQueue_DataIndexGroup];

