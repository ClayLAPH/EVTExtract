CREATE TABLE [dbo].[A_Account] (
    [balanceAmt]                 MONEY        NULL,
    [currencyCode_OrTx]          VARCHAR (50) NULL,
    [interestRateQuantity_Nmr]   REAL         NULL,
    [interestRateQuantity_Dnm]   REAL         NULL,
    [allowedBalanceQuantity_Min] MONEY        NULL,
    [allowedBalanceQuantity_Max] MONEY        NULL,
    [currencyCode_ID]            INT          NULL,
    [ID]                         INT          NOT NULL,
    CONSTRAINT [A_Account_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_Account_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Account_currencyCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([currencyCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_Account] NOCHECK CONSTRAINT [A_Act_A_Account_FK1];


GO
ALTER TABLE [dbo].[A_Account] NOCHECK CONSTRAINT [FK_A_A_Account_currencyCode_ID_V_UNIFIEDCODESET];

