CREATE TABLE [dbo].[R_Access] (
    [approachSiteCode_OrTx] VARCHAR (50) NULL,
    [targetSiteCode_OrTx]   VARCHAR (50) NULL,
    [gaugeQuantity]         REAL         NULL,
    [gaugeQuantity_Unit]    VARCHAR (50) NULL,
    [gaugeQuantity_UnPr]    VARCHAR (50) NULL,
    [approachSiteCode_ID]   INT          NULL,
    [targetSiteCode_ID]     INT          NULL,
    [ID]                    INT          NOT NULL,
    CONSTRAINT [R_Access_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_R_Access_approachSiteCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([approachSiteCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_R_Access_targetSiteCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([targetSiteCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_R_Access_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[R_Access] NOCHECK CONSTRAINT [FK_A_R_Access_approachSiteCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[R_Access] NOCHECK CONSTRAINT [FK_A_R_Access_targetSiteCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[R_Access] NOCHECK CONSTRAINT [R_Role_R_Access_FK1];

