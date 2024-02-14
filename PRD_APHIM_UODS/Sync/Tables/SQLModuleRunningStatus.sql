CREATE TABLE [Sync].[SQLModuleRunningStatus] (
    [SQLBlockName]             NVARCHAR (250)  NOT NULL,
    [BlockDescription]         NVARCHAR (1000) NULL,
    [LastExecutionUTCDateTime] DATETIME        NOT NULL,
    [LastExecutionDateTime]    DATETIME        NOT NULL,
    CONSTRAINT [PK_SQLModuleRunningStatus] PRIMARY KEY CLUSTERED ([SQLBlockName] ASC) ON [Sync_DataGroup]
) ON [Sync_DataGroup];

