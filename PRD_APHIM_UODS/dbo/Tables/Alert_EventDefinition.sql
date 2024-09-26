CREATE TABLE [dbo].[Alert_EventDefinition] (
    [ED_Rowid]        INT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ED_RecordTypeDR] INT NULL,
    [ED_DefinitionDR] INT NULL,
    CONSTRAINT [PK_Alert_EventDefinition] PRIMARY KEY CLUSTERED ([ED_Rowid] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Alert_EventDefinition_ED_RecordTypeDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([ED_RecordTypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);

