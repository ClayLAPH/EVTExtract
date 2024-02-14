CREATE TABLE [dbo].[E_Material] (
    [formCode_OrTx]      VARCHAR (50) NULL,
    [lotNumberText]      VARCHAR (50) NULL,
    [expirationTime_Beg] DATETIME     NULL,
    [expirationTime_End] DATETIME     NULL,
    [stabilityTime_Beg]  DATETIME     NULL,
    [stabilityTime_End]  DATETIME     NULL,
    [formCode_ID]        INT          NULL,
    [ServerId]           INT          NULL,
    [ID]                 INT          NOT NULL,
    CONSTRAINT [E_Material_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Entity_E_Material_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Material_formCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([formCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[E_Material] NOCHECK CONSTRAINT [E_Entity_E_Material_FK1];


GO
ALTER TABLE [dbo].[E_Material] NOCHECK CONSTRAINT [FK_A_E_Material_formCode_ID_V_UNIFIEDCODESET];

