CREATE TABLE [dbo].[A_FinancialTransaction] (
    [amt]                        MONEY        NULL,
    [amt_Unit]                   VARCHAR (50) NULL,
    [creditExchangeRateQuantity] REAL         NULL,
    [debitExchangeRateQuantity]  REAL         NULL,
    [ID]                         INT          NOT NULL,
    CONSTRAINT [A_FinancialTransaction_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_FinancialTransaction_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_FinancialTransaction] NOCHECK CONSTRAINT [A_Act_A_FinancialTransaction_FK1];

