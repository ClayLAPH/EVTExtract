CREATE TABLE [dbo].[A_DiagnosticImage] (
    [interpretationCode_OrTx]     VARCHAR (50) NULL,
    [methodCode_OrTx]             VARCHAR (50) NULL,
    [targetSiteCode_OrTx]         VARCHAR (50) NULL,
    [subjectOrientationCode_OrTx] VARCHAR (50) NULL,
    [interpretationCode_ID]       INT          NULL,
    [methodCode_ID]               INT          NULL,
    [subjectOrientationCode_ID]   INT          NULL,
    [targetSiteCode_ID]           INT          NULL,
    [ID]                          INT          NOT NULL,
    CONSTRAINT [A_DiagnosticImage_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_DiagnosticImage_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_DiagnosticImage_interpretationCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([interpretationCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_DiagnosticImage_methodCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([methodCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_DiagnosticImage_subjectOrientationCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([subjectOrientationCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_DiagnosticImage_targetSiteCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([targetSiteCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_DiagnosticImage] NOCHECK CONSTRAINT [A_Act_A_DiagnosticImage_FK1];


GO
ALTER TABLE [dbo].[A_DiagnosticImage] NOCHECK CONSTRAINT [FK_A_A_DiagnosticImage_interpretationCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_DiagnosticImage] NOCHECK CONSTRAINT [FK_A_A_DiagnosticImage_methodCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_DiagnosticImage] NOCHECK CONSTRAINT [FK_A_A_DiagnosticImage_subjectOrientationCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_DiagnosticImage] NOCHECK CONSTRAINT [FK_A_A_DiagnosticImage_targetSiteCode_ID_V_UNIFIEDCODESET];

