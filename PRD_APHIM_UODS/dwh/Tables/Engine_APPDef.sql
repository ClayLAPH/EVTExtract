CREATE TABLE [dwh].[Engine_APPDef] (
    [AD_RowID]                 INT             IDENTITY (1, 1) NOT NULL,
    [AD_CIRowID]               INT             NULL,
    [AD_AppIdentifier]         NVARCHAR (100)  NOT NULL,
    [AD_QueueNames]            NVARCHAR (2000) NOT NULL,
    [AD_AppWeightInCluster]    TINYINT         DEFAULT ((0)) NOT NULL,
    [AD_HeartBeatFailDuration] INT             DEFAULT ((30)) NOT NULL,
    [AD_IsActive]              BIT             DEFAULT ((0)) NULL,
    CONSTRAINT [EngineAPPDef_PK] PRIMARY KEY CLUSTERED ([AD_RowID] ASC) ON [DWHQueue_DataIndexGroup],
    CONSTRAINT [CHK_APPDefHeartBeatFailDuration] CHECK ([AD_HeartBeatFailDuration]>(10)),
    CONSTRAINT [CHK_AppNameUnique] UNIQUE NONCLUSTERED ([AD_AppIdentifier] ASC) ON [DWHQueue_DataIndexGroup]
) ON [DWHQueue_DataIndexGroup];

