CREATE TABLE [dbo].[T_EntityName] (
    [useCode]       VARCHAR (50)  NULL,
    [useCode_OrTx]  VARCHAR (50)  NULL,
    [validTime_Beg] DATETIME      CONSTRAINT [DF_T_EntityName_validTime_Beg] DEFAULT (getdate()) NULL,
    [validTime_End] DATETIME      NULL,
    [trivialName]   VARCHAR (250) NULL,
    [searchName]    VARCHAR (100) NULL,
    [metaCode]      VARCHAR (50)  NULL,
    [partFAM]       VARCHAR (100) NULL,
    [partGIV]       VARCHAR (100) NULL,
    [partMID]       VARCHAR (100) NULL,
    [partInitFull]  VARCHAR (100) NULL,
    [partSfx]       VARCHAR (50)  NULL,
    [ServerId]      INT           NULL,
    [ID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Entity_ID]     INT           NULL,
    [Role_ID]       INT           NULL,
    [partThird]     VARCHAR (100) NULL,
    [partFourth]    VARCHAR (100) NULL,
    [partPrefix]    VARCHAR (50)  NULL,
    CONSTRAINT [T_EntityName_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [E_Entity_T_EntityName_FK1] FOREIGN KEY ([Entity_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_T_EntityName_FK1] FOREIGN KEY ([Role_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_EntityName] NOCHECK CONSTRAINT [E_Entity_T_EntityName_FK1];


GO
ALTER TABLE [dbo].[T_EntityName] NOCHECK CONSTRAINT [R_Role_T_EntityName_FK1];


GO
ALTER TABLE [dbo].[T_EntityName] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityName]
    ON [dbo].[T_EntityName]([useCode] ASC, [metaCode] ASC, [trivialName] ASC, [Entity_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityName_1]
    ON [dbo].[T_EntityName]([trivialName] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_T_EntityName_1]
    ON [dbo].[T_EntityName] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityName_2]
    ON [dbo].[T_EntityName]([partFAM] ASC, [partGIV] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityName_3]
    ON [dbo].[T_EntityName]([useCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_T_EntityName_3]
    ON [dbo].[T_EntityName] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityName_4]
    ON [dbo].[T_EntityName]([Entity_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityName_RoleID]
    ON [dbo].[T_EntityName]([Role_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_Entity_ID]
    ON [dbo].[T_EntityName]([Entity_ID]);


GO
CREATE STATISTICS [IX_WA_metaCode]
    ON [dbo].[T_EntityName]([metaCode]);


GO
CREATE STATISTICS [IX_WA_useCode]
    ON [dbo].[T_EntityName]([useCode]);

