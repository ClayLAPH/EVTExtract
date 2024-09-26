CREATE TABLE [dbo].[A_Outbreak] (
    [numberOfCases]               INT          NULL,
    [interpretationCode_OrTx]     VARCHAR (50) NULL,
    [methodCode_OrTx]             VARCHAR (50) NULL,
    [targetSiteCode_OrTx]         VARCHAR (50) NULL,
    [detectionMethodCode_OrTx]    VARCHAR (50) NULL,
    [transmissionMethodCode_OrTx] VARCHAR (50) NULL,
    [diseaseImportedCode_OrTx]    VARCHAR (50) NULL,
    [caseOutcomeCode_OrTx]        VARCHAR (50) NULL,
    [caseOutcomeDate]             DATETIME     NULL,
    [dxDate]                      DATETIME     NULL,
    [sxDate]                      DATETIME     NULL,
    [caseOutcomeCode_ID]          INT          NULL,
    [detectionMethodCode_ID]      INT          NULL,
    [diseaseImportedCode_ID]      INT          NULL,
    [interpretationCode_ID]       INT          NULL,
    [methodCode_ID]               INT          NULL,
    [targetSiteCode_ID]           INT          NULL,
    [transmissionMethodCode_ID]   INT          NULL,
    [ID]                          INT          NOT NULL,
    CONSTRAINT [A_Outbreak_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_Outbreak_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Outbreak_caseOutcomeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([caseOutcomeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Outbreak_detectionMethodCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([detectionMethodCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Outbreak_diseaseImportedCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([diseaseImportedCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Outbreak_interpretationCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([interpretationCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Outbreak_methodCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([methodCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Outbreak_targetSiteCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([targetSiteCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Outbreak_transmissionMethodCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([transmissionMethodCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_Outbreak] NOCHECK CONSTRAINT [A_Act_A_Outbreak_FK1];


GO
ALTER TABLE [dbo].[A_Outbreak] NOCHECK CONSTRAINT [FK_A_A_Outbreak_caseOutcomeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Outbreak] NOCHECK CONSTRAINT [FK_A_A_Outbreak_detectionMethodCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Outbreak] NOCHECK CONSTRAINT [FK_A_A_Outbreak_diseaseImportedCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Outbreak] NOCHECK CONSTRAINT [FK_A_A_Outbreak_interpretationCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Outbreak] NOCHECK CONSTRAINT [FK_A_A_Outbreak_methodCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Outbreak] NOCHECK CONSTRAINT [FK_A_A_Outbreak_targetSiteCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Outbreak] NOCHECK CONSTRAINT [FK_A_A_Outbreak_transmissionMethodCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_A_Outbreak]
    ON [dbo].[A_Outbreak]([interpretationCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_A_Outbreak]
    ON [dbo].[A_Outbreak] DISABLE;

