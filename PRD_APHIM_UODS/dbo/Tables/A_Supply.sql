CREATE TABLE [dbo].[A_Supply] (
    [quantity]             REAL         NULL,
    [quantity_Unit]        VARCHAR (50) NULL,
    [quantity_UnPr]        VARCHAR (50) NULL,
    [quantity_Alt]         REAL         NULL,
    [expectedUseTime_Beg]  DATETIME     NULL,
    [expectedUseTime_End]  DATETIME     NULL,
    [quantity_Alt_Unit_ID] INT          NULL,
    [ID]                   INT          NOT NULL,
    CONSTRAINT [A_Supply_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_Supply_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Supply_quantity_Alt_Unit_ID_V_UNIFIEDCODESET] FOREIGN KEY ([quantity_Alt_Unit_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_Supply] NOCHECK CONSTRAINT [A_Act_A_Supply_FK1];


GO
ALTER TABLE [dbo].[A_Supply] NOCHECK CONSTRAINT [FK_A_A_Supply_quantity_Alt_Unit_ID_V_UNIFIEDCODESET];

