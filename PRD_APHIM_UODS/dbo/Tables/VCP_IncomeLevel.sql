CREATE TABLE [dbo].[VCP_IncomeLevel] (
    [effectiveDate]    DATETIME     NULL,
    [incomeLevel1From] VARCHAR (50) NULL,
    [incomeLevel1To]   VARCHAR (50) NULL,
    [incomeLevel2From] VARCHAR (50) NULL,
    [incomeLevel2To]   VARCHAR (50) NULL,
    [incomeLevel3From] VARCHAR (50) NULL,
    [incomeLevel3To]   VARCHAR (50) NULL,
    [subjCode_ID]      INT          NULL,
    [ID]               INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    CONSTRAINT [VCP_IncomeLevel_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_VCP_IncomeLevel_subjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([subjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_IncomeLevel] NOCHECK CONSTRAINT [FK_A_VCP_IncomeLevel_subjCode_ID_V_UNIFIEDCODESET];

