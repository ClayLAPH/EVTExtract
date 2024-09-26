CREATE TABLE [dbo].[S_AuditMain] (
    [ID]            BIGINT        IDENTITY (1, 1) NOT NULL,
    [RecordID]      VARCHAR (200) NULL,
    [FormName]      VARCHAR (50)  NULL,
    [TableName]     VARCHAR (300) NULL,
    [InstanceID]    VARCHAR (100) NULL,
    [sqlAction]     VARCHAR (50)  NULL,
    [ActionDate]    DATETIME      NULL,
    [Notes]         VARCHAR (MAX) NULL,
    [UserIP]        VARCHAR (250) NULL,
    [reasonCode_ID] INT           NULL,
    [entityID]      INT           NULL,
    [USERID]        INT           NULL,
    CONSTRAINT [S_AuditMain_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95) ON [AUDIT_DATA_GROUP],
    CONSTRAINT [E_Entity_S_AuditMain_FK1] FOREIGN KEY ([USERID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [E_Entity_S_AuditMain_FK2] FOREIGN KEY ([entityID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_AuditMain_reasonCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([reasonCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
) ON [AUDIT_DATA_GROUP] TEXTIMAGE_ON [AUDIT_DATA_GROUP];


GO
ALTER TABLE [dbo].[S_AuditMain] NOCHECK CONSTRAINT [E_Entity_S_AuditMain_FK1];


GO
ALTER TABLE [dbo].[S_AuditMain] NOCHECK CONSTRAINT [E_Entity_S_AuditMain_FK2];


GO
ALTER TABLE [dbo].[S_AuditMain] NOCHECK CONSTRAINT [FK_A_S_AuditMain_reasonCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_AuditMain] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_S_AuditMain_1]
    ON [dbo].[S_AuditMain]([TableName] ASC, [sqlAction] ASC, [USERID] ASC) WITH (FILLFACTOR = 80)
    ON [AUDIT_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_S_AuditMain_2]
    ON [dbo].[S_AuditMain]([RecordID] ASC, [FormName] ASC, [TableName] ASC) WITH (FILLFACTOR = 80)
    ON [AUDIT_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_S_AuditMain_3]
    ON [dbo].[S_AuditMain]([FormName] ASC, [RecordID] ASC) WITH (FILLFACTOR = 80)
    ON [AUDIT_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_S_AuditMain_4]
    ON [dbo].[S_AuditMain]([entityID] ASC, [ActionDate] ASC) WITH (FILLFACTOR = 80)
    ON [AUDIT_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_S_AuditMain_InstanceID]
    ON [dbo].[S_AuditMain]([InstanceID] ASC)
    INCLUDE([FormName], [TableName]) WITH (FILLFACTOR = 80)
    ON [AUDIT_IDX_GROUP];

