CREATE TABLE [dbo].[A_PublicHealthCase] (
    [interpretationCode_OrTx]     VARCHAR (50) NULL,
    [detectionMethodCode_OrTx]    VARCHAR (50) NULL,
    [transmissionMethodCode_OrTx] VARCHAR (50) NULL,
    [diseaseImportedCode_OrTx]    VARCHAR (50) NULL,
    [methodCode_OrTx]             VARCHAR (50) NULL,
    [caseOutcomeCode_OrTx]        VARCHAR (50) NULL,
    [caseOutcomeDate]             DATETIME     NULL,
    [dxDate]                      DATETIME     NULL,
    [hospitalizedInd]             BIT          NULL,
    [primaryOccupationCode_OrTx]  VARCHAR (50) NULL,
    [ageReported]                 REAL         NULL,
    [ageReported_Unit]            VARCHAR (50) NULL,
    [ageReported_OrTx]            VARCHAR (50) NULL,
    [ageCategoryCode_OrTx]        VARCHAR (50) NULL,
    [educationLevelCode_OrTx]     VARCHAR (50) NULL,
    [numberAdultsInHouse]         SMALLINT     NULL,
    [numberChildrenInHouse]       SMALLINT     NULL,
    [sxDate]                      DATETIME     NULL,
    [targetSiteCode_OrTx]         VARCHAR (50) NULL,
    [ageCategoryCode_ID]          INT          NULL,
    [caseOutcomeCode_ID]          INT          NULL,
    [detectionMethodCode_ID]      INT          NULL,
    [diseaseImportedCode_ID]      INT          NULL,
    [educationLevelCode_ID]       INT          NULL,
    [interpretationCode_ID]       INT          NULL,
    [methodCode_ID]               INT          NULL,
    [primaryOccupationCode_ID]    INT          NULL,
    [targetSiteCode_ID]           INT          NULL,
    [transmissionMethodCode_ID]   INT          NULL,
    [ServerId]                    INT          NULL,
    [ID]                          INT          NOT NULL,
    [phRecordTypeCode_ID]         INT          NULL,
    CONSTRAINT [A_PublicHealthCase_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [A_Act_A_PublicHealthCase_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PublicHealthCase_ageCategoryCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ageCategoryCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PublicHealthCase_caseOutcomeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([caseOutcomeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PublicHealthCase_detectionMethodCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([detectionMethodCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PublicHealthCase_diseaseImportedCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([diseaseImportedCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PublicHealthCase_educationLevelCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([educationLevelCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PublicHealthCase_interpretationCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([interpretationCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PublicHealthCase_methodCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([methodCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PublicHealthCase_primaryOccupationCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([primaryOccupationCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PublicHealthCase_targetSiteCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([targetSiteCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PublicHealthCase_transmissionMethodCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([transmissionMethodCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_phRecordTypeCode_ID_V_UnifiedCodeSet] FOREIGN KEY ([phRecordTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [A_Act_A_PublicHealthCase_FK1];


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [FK_A_A_PublicHealthCase_ageCategoryCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [FK_A_A_PublicHealthCase_caseOutcomeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [FK_A_A_PublicHealthCase_detectionMethodCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [FK_A_A_PublicHealthCase_diseaseImportedCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [FK_A_A_PublicHealthCase_educationLevelCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [FK_A_A_PublicHealthCase_interpretationCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [FK_A_A_PublicHealthCase_methodCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [FK_A_A_PublicHealthCase_primaryOccupationCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [FK_A_A_PublicHealthCase_targetSiteCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [FK_A_A_PublicHealthCase_transmissionMethodCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PublicHealthCase] NOCHECK CONSTRAINT [FK_A_phRecordTypeCode_ID_V_UnifiedCodeSet];


GO
CREATE STATISTICS [IX_WA_detectionMethodCode_ID]
    ON [dbo].[A_PublicHealthCase]([detectionMethodCode_ID]);


GO
CREATE STATISTICS [IX_WA_ageReported]
    ON [dbo].[A_PublicHealthCase]([ageReported]);


GO
CREATE STATISTICS [IX_WA_dxDate]
    ON [dbo].[A_PublicHealthCase]([dxDate]);

