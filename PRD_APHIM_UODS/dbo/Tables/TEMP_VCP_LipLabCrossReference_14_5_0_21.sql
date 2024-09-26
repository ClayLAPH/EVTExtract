CREATE TABLE [dbo].[TEMP_VCP_LipLabCrossReference_14_5_0_21] (
    [ID]                        INT           NOT NULL,
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
    [LABR_TestOrganismCombined] BIT           NULL,
    [LABR_OutbreakManualEntry]  BIT           NOT NULL,
    [ActionType]                VARCHAR (10)  NULL,
    [ActionDate]                DATETIME      NULL,
    [IssueNumber]               INT           NULL
);

