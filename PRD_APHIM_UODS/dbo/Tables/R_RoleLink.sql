CREATE TABLE [dbo].[R_RoleLink] (
    [typeCode]          VARCHAR (50) NULL,
    [effectiveTime_Beg] DATETIME     CONSTRAINT [DF_R_RoleLink_effectiveTime_Beg] DEFAULT (getdate()) NULL,
    [effectiveTime_End] DATETIME     NULL,
    [metaCode]          VARCHAR (50) NULL,
    [priorityNumber]    INT          NULL,
    [localId]           VARCHAR (50) NULL,
    [ServerId]          INT          NULL,
    [ID]                INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [sourceRole_ID]     INT          NULL,
    [targetRole_ID]     INT          NULL,
    CONSTRAINT [R_RoleLink_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [R_Role_R_RoleLink_FK1] FOREIGN KEY ([sourceRole_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_R_RoleLink_FK2] FOREIGN KEY ([targetRole_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[R_RoleLink] NOCHECK CONSTRAINT [R_Role_R_RoleLink_FK1];


GO
ALTER TABLE [dbo].[R_RoleLink] NOCHECK CONSTRAINT [R_Role_R_RoleLink_FK2];


GO
CREATE NONCLUSTERED INDEX [IX_R_RoleLink]
    ON [dbo].[R_RoleLink]([targetRole_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_R_RoleLink]
    ON [dbo].[R_RoleLink] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_R_RoleLink_1]
    ON [dbo].[R_RoleLink]([targetRole_ID] ASC, [metaCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_R_RoleLink_SourceRole]
    ON [dbo].[R_RoleLink]([sourceRole_ID] ASC)
    INCLUDE([metaCode]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_R_RoleLink_typeCode_metaCode_inc]
    ON [dbo].[R_RoleLink]([typeCode] ASC, [metaCode] ASC)
    INCLUDE([sourceRole_ID], [targetRole_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_metaCode]
    ON [dbo].[R_RoleLink]([metaCode]);


GO
CREATE STATISTICS [IX_WA_typeCode]
    ON [dbo].[R_RoleLink]([typeCode]);

