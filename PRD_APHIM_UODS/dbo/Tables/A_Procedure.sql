CREATE TABLE [dbo].[A_Procedure] (
    [methodCode_OrTx]       VARCHAR (50) NULL,
    [approachSiteCode_OrTx] VARCHAR (50) NULL,
    [targetSiteCode_OrTx]   VARCHAR (50) NULL,
    [approachSiteCode_ID]   INT          NULL,
    [methodCode_ID]         INT          NULL,
    [targetSiteCode_ID]     INT          NULL,
    [ID]                    INT          NOT NULL,
    CONSTRAINT [A_Procedure_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_Procedure_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Procedure_approachSiteCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([approachSiteCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Procedure_methodCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([methodCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Procedure_targetSiteCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([targetSiteCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_Procedure] NOCHECK CONSTRAINT [A_Act_A_Procedure_FK1];


GO
ALTER TABLE [dbo].[A_Procedure] NOCHECK CONSTRAINT [FK_A_A_Procedure_approachSiteCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Procedure] NOCHECK CONSTRAINT [FK_A_A_Procedure_methodCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Procedure] NOCHECK CONSTRAINT [FK_A_A_Procedure_targetSiteCode_ID_V_UNIFIEDCODESET];

