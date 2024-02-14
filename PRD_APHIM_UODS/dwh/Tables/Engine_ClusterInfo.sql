CREATE TABLE [dwh].[Engine_ClusterInfo] (
    [CI_RowID]    INT            IDENTITY (1, 1) NOT NULL,
    [CI_Name]     NVARCHAR (100) DEFAULT ('') NOT NULL,
    [CI_IsActive] BIT            DEFAULT ((1)) NULL,
    CONSTRAINT [EngineClusterInfo_PK] PRIMARY KEY CLUSTERED ([CI_RowID] ASC) ON [DWHQueue_DataIndexGroup]
) ON [DWHQueue_DataIndexGroup];

