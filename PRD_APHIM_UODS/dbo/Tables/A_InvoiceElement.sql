CREATE TABLE [dbo].[A_InvoiceElement] (
    [modifierCode_OrTx]     VARCHAR (50) NULL,
    [unitQuantity_Nmr]      REAL         NULL,
    [unitQuantity_Nmr_Unit] VARCHAR (50) NULL,
    [unitQuantity_Nmr_UnPr] VARCHAR (50) NULL,
    [unitQuantity_Dnm]      REAL         NULL,
    [unitQuantity_Dnm_Unit] VARCHAR (50) NULL,
    [unitQuantity_Dnm_UnPr] VARCHAR (50) NULL,
    [unitPrice_Nmr]         MONEY        NULL,
    [unitPrice_Nmr_Unit]    VARCHAR (50) NULL,
    [unitPrice_Dnm]         REAL         NULL,
    [unitPrice_Dnm_Unit]    VARCHAR (50) NULL,
    [unitPrice_Dnm_UnPr]    VARCHAR (50) NULL,
    [netAmt]                MONEY        NULL,
    [netAmt_Unit]           VARCHAR (50) NULL,
    [factorNumber]          REAL         NULL,
    [pointsNumber]          REAL         NULL,
    [modifierCode_ID]       INT          NULL,
    [ID]                    INT          NOT NULL,
    CONSTRAINT [A_InvoiceElement_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_InvoiceElement_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_InvoiceElement_modifierCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([modifierCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_InvoiceElement] NOCHECK CONSTRAINT [A_Act_A_InvoiceElement_FK1];


GO
ALTER TABLE [dbo].[A_InvoiceElement] NOCHECK CONSTRAINT [FK_A_A_InvoiceElement_modifierCode_ID_V_UNIFIEDCODESET];

