CREATE TABLE [dbo].[E_Container] (
    [formCode_OrTx]             VARCHAR (50) NULL,
    [lotNumberText]             VARCHAR (50) NULL,
    [expirationTime_Beg]        DATETIME     NULL,
    [expirationTime_End]        DATETIME     NULL,
    [stabilityTime_Beg]         DATETIME     NULL,
    [stabilityTime_End]         DATETIME     NULL,
    [capacityQuanity]           FLOAT (53)   NULL,
    [capacityQuantity_Unit]     VARCHAR (50) NULL,
    [capacityQuantity_UnPr]     VARCHAR (50) NULL,
    [heightQuantity]            FLOAT (53)   NULL,
    [heightQuantity_Unit]       VARCHAR (50) NULL,
    [heightQuantity_UnPr]       VARCHAR (50) NULL,
    [diameterQuantity]          REAL         NULL,
    [diameterQuantity_Unit]     VARCHAR (50) NULL,
    [diameterQuantity_UnPr]     VARCHAR (50) NULL,
    [capTypeCode_OrTx]          VARCHAR (50) NULL,
    [separatorTypeCode_OrTx]    VARCHAR (50) NULL,
    [barrierDeltaQuantity]      REAL         NULL,
    [barrierDeltaQuantity_Unit] VARCHAR (50) NULL,
    [barrierDeltaQuantity_UnPr] VARCHAR (50) NULL,
    [bottomDeltaQuantity]       FLOAT (53)   NULL,
    [bottomDeltaQuantity_Unit]  VARCHAR (50) NULL,
    [bottomDeltaQuantity_UnPr]  VARCHAR (50) NULL,
    [capTypeCode_ID]            INT          NULL,
    [formCode_ID]               INT          NULL,
    [separatorTypeCode_ID]      INT          NULL,
    [ID]                        INT          NOT NULL,
    CONSTRAINT [E_Container_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Entity_E_Container_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Container_capTypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([capTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Container_formCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([formCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Container_separatorTypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([separatorTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[E_Container] NOCHECK CONSTRAINT [E_Entity_E_Container_FK1];


GO
ALTER TABLE [dbo].[E_Container] NOCHECK CONSTRAINT [FK_A_E_Container_capTypeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_Container] NOCHECK CONSTRAINT [FK_A_E_Container_formCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_Container] NOCHECK CONSTRAINT [FK_A_E_Container_separatorTypeCode_ID_V_UNIFIEDCODESET];

