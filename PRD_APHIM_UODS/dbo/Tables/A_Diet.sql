CREATE TABLE [dbo].[A_Diet] (
    [quantity]                  REAL         NULL,
    [quantity_Unit]             VARCHAR (50) NULL,
    [quantity_UnPr]             VARCHAR (50) NULL,
    [quantity_Alt]              REAL         NULL,
    [expectedUseTime_Beg]       DATETIME     NULL,
    [expectedUseTime_End]       DATETIME     NULL,
    [energyQuantity]            REAL         NULL,
    [energyQuantity_Unit]       VARCHAR (50) NULL,
    [energyQuantity_UnPr]       VARCHAR (50) NULL,
    [carbohydrateQuantity]      REAL         NULL,
    [carbohydrateQuantity_Unit] VARCHAR (50) NULL,
    [carbohydrateQuantity_UnPr] VARCHAR (50) NULL,
    [quantity_Alt_Unit_ID]      INT          NULL,
    [ID]                        INT          NOT NULL,
    CONSTRAINT [A_Diet_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_Diet_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Diet_quantity_Alt_Unit_ID_V_UNIFIEDCODESET] FOREIGN KEY ([quantity_Alt_Unit_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_Diet] NOCHECK CONSTRAINT [A_Act_A_Diet_FK1];


GO
ALTER TABLE [dbo].[A_Diet] NOCHECK CONSTRAINT [FK_A_A_Diet_quantity_Alt_Unit_ID_V_UNIFIEDCODESET];

