CREATE TABLE [dbo].[E_Device] (
    [formCode_OrTx]                    VARCHAR (50) NULL,
    [lotNumberText]                    VARCHAR (50) NULL,
    [expirationTime_Beg]               DATETIME     NULL,
    [expirationTime_End]               DATETIME     NULL,
    [stabilityTime_Beg]                DATETIME     NULL,
    [stabilityTime_End]                DATETIME     NULL,
    [manufacturerModelName]            VARCHAR (50) NULL,
    [softwareName]                     VARCHAR (50) NULL,
    [localRemoteControlStateCode_OrTx] VARCHAR (50) NULL,
    [alertLevelCode_OrTx]              VARCHAR (50) NULL,
    [lastCalibrationTime]              DATETIME     NULL,
    [alertLevelCode_ID]                INT          NULL,
    [formCode_ID]                      INT          NULL,
    [localRemoteControlStateCode_ID]   INT          NULL,
    [ServerId]                         INT          NULL,
    [ID]                               INT          NOT NULL,
    CONSTRAINT [E_Device_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Entity_E_Device_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Device_alertLevelCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([alertLevelCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Device_formCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([formCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Device_localRemoteControlStateCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([localRemoteControlStateCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[E_Device] NOCHECK CONSTRAINT [E_Entity_E_Device_FK1];


GO
ALTER TABLE [dbo].[E_Device] NOCHECK CONSTRAINT [FK_A_E_Device_alertLevelCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_Device] NOCHECK CONSTRAINT [FK_A_E_Device_formCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_Device] NOCHECK CONSTRAINT [FK_A_E_Device_localRemoteControlStateCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_E_Device]
    ON [dbo].[E_Device]([manufacturerModelName] ASC, [softwareName] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_manufacturerModelName]
    ON [dbo].[E_Device]([manufacturerModelName]);


GO
CREATE STATISTICS [IX_WA_softwareName]
    ON [dbo].[E_Device]([softwareName]);

