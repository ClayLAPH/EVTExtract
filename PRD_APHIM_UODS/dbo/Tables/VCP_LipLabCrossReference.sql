CREATE TABLE [dbo].[VCP_LipLabCrossReference] (
    [ID]                        INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [subjCode_ID]               INT           NULL,
    [LABR_LaboratoryDR]         INT           NULL,
    [LABR_PositiveDiseaseDR]    INT           NULL,
    [LABR_LOINCReferenceCode]   VARCHAR (200) NULL,
    [LABR_LocalReferenceCode]   VARCHAR (200) NULL,
    [LABR_HepatitisTestDR]      INT           NULL,
    [LABR_DoNotImport]          BIT           NULL,
    [LABR_SNOMEDConceptID]      VARCHAR (200) NULL,
    [LABR_SNOMEDLegacyCode]     VARCHAR (200) NULL,
    [LABR_NonPositiveDiseaseDR] INT           NULL,
    [LABR_LocalOrganismCode]    VARCHAR (200) NULL,
    [LABR_TestOrganismCombined] BIT           CONSTRAINT [DF_VCP_LipLabCrossReference_LABR_TestOrganismCombined] DEFAULT ((0)) NULL,
    [LABR_OutbreakManualEntry]  BIT           DEFAULT ((0)) NOT NULL,
    [LABR_ReinfectionInDays]    INT           NULL,
    CONSTRAINT [PK_VCP_LipLabCrossReference] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_VCP_LipLabCrossReference_E_Entity] FOREIGN KEY ([LABR_LaboratoryDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_LipLabCrossReference_V_UnifiedCodeSet] FOREIGN KEY ([subjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_LipLabCrossReference_V_UnifiedCodeSet1] FOREIGN KEY ([LABR_PositiveDiseaseDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_LipLabCrossReference_V_UnifiedCodeSet2] FOREIGN KEY ([LABR_HepatitisTestDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_LipLabCrossReference_V_UnifiedCodeSet3] FOREIGN KEY ([LABR_NonPositiveDiseaseDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_LipLabCrossReference] NOCHECK CONSTRAINT [FK_VCP_LipLabCrossReference_E_Entity];


GO
ALTER TABLE [dbo].[VCP_LipLabCrossReference] NOCHECK CONSTRAINT [FK_VCP_LipLabCrossReference_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[VCP_LipLabCrossReference] NOCHECK CONSTRAINT [FK_VCP_LipLabCrossReference_V_UnifiedCodeSet1];


GO
ALTER TABLE [dbo].[VCP_LipLabCrossReference] NOCHECK CONSTRAINT [FK_VCP_LipLabCrossReference_V_UnifiedCodeSet2];


GO
ALTER TABLE [dbo].[VCP_LipLabCrossReference] NOCHECK CONSTRAINT [FK_VCP_LipLabCrossReference_V_UnifiedCodeSet3];


GO
CREATE NONCLUSTERED INDEX [IX_VCP_LipLabCrossReference]
    ON [dbo].[VCP_LipLabCrossReference]([LABR_LaboratoryDR] ASC, [LABR_PositiveDiseaseDR] ASC, [LABR_LOINCReferenceCode] ASC, [LABR_SNOMEDConceptID] ASC, [LABR_SNOMEDLegacyCode] ASC, [LABR_LocalReferenceCode] ASC) WITH (FILLFACTOR = 70);

