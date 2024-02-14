CREATE TABLE [dwh].[Engine_APPHeartBeat] (
    [AHB_ADRowID]           INT        NOT NULL,
    [AHB_PingTime]          DATETIME   NULL,
    [AHB_PingExpires]       DATETIME   NULL,
    [AHB_ProcessIdentifier] NCHAR (32) NULL,
    CONSTRAINT [Engine_APPHeartBeat_PK] PRIMARY KEY CLUSTERED ([AHB_ADRowID] ASC) ON [DWHQueue_DataIndexGroup]
) ON [DWHQueue_DataIndexGroup];

