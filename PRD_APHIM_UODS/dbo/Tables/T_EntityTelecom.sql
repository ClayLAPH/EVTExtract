CREATE TABLE [dbo].[T_EntityTelecom] (
    [useCode]          VARCHAR (50)  NULL,
    [useCode_OrTx]     VARCHAR (50)  NULL,
    [validTime_Beg]    DATETIME      CONSTRAINT [DF_T_EntityTelecom_validTime_Beg] DEFAULT (getdate()) NULL,
    [validTime_End]    DATETIME      NULL,
    [address]          VARCHAR (100) NULL,
    [scheme]           VARCHAR (50)  NULL,
    [scheme_OrTx]      VARCHAR (50)  NULL,
    [metaCode]         VARCHAR (50)  NULL,
    [ServerId]         INT           NULL,
    [PartPhoneAlphaUp] AS            ([dbo].[ALPHAUP]([address])) PERSISTED,
    [ID]               INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Entity_ID]        INT           NULL,
    [Role_ID]          INT           NULL,
    CONSTRAINT [T_EntityTelecom_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Entity_T_EntityTelecom_FK1] FOREIGN KEY ([Entity_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_T_EntityTelecom_FK1] FOREIGN KEY ([Role_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_EntityTelecom] NOCHECK CONSTRAINT [E_Entity_T_EntityTelecom_FK1];


GO
ALTER TABLE [dbo].[T_EntityTelecom] NOCHECK CONSTRAINT [R_Role_T_EntityTelecom_FK1];


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityTelecom_1]
    ON [dbo].[T_EntityTelecom]([PartPhoneAlphaUp] ASC, [scheme] ASC) WITH (FILLFACTOR = 100)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityTelecom_2]
    ON [dbo].[T_EntityTelecom]([useCode] ASC, [scheme] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityTelecom_RoleID]
    ON [dbo].[T_EntityTelecom]([Role_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityTelecom]
    ON [dbo].[T_EntityTelecom]([Entity_ID] ASC, [useCode] ASC, [scheme] ASC)
    INCLUDE([address]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_scheme]
    ON [dbo].[T_EntityTelecom]([scheme]);


GO
CREATE STATISTICS [IX_WA_useCode]
    ON [dbo].[T_EntityTelecom]([useCode]);

