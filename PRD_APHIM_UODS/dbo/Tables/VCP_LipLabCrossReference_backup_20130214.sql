CREATE TABLE [dbo].[VCP_LipLabCrossReference_backup_20130214] (
    [ID]                        INT           IDENTITY (1, 1) NOT NULL,
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
    [LABR_TestOrganismCombined] BIT           NULL
);

