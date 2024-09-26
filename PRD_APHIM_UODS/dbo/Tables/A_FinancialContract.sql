CREATE TABLE [dbo].[A_FinancialContract] (
    [paymentTermsCode_OrTx] VARCHAR (50) NULL,
    [paymentTermsCode_ID]   INT          NULL,
    [ID]                    INT          NOT NULL,
    CONSTRAINT [A_FinancialContract_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_FinancialContract_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_FinancialContract_paymentTermsCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([paymentTermsCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_FinancialContract] NOCHECK CONSTRAINT [A_Act_A_FinancialContract_FK1];


GO
ALTER TABLE [dbo].[A_FinancialContract] NOCHECK CONSTRAINT [FK_A_A_FinancialContract_paymentTermsCode_ID_V_UNIFIEDCODESET];

