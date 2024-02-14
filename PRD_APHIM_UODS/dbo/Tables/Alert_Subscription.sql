CREATE TABLE [dbo].[Alert_Subscription] (
    [SUB_RowID]                 INT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SUB_UserDR]                INT NULL,
    [SUB_PriorityDR]            INT NULL,
    [SUB_EventDefinitionDR]     INT NULL,
    [SUB_EventMappingDetailsDR] INT NULL,
    CONSTRAINT [PK_Subscription] PRIMARY KEY CLUSTERED ([SUB_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Alert_Subscription_SUB_EventDefinitionDR_Alert_EventDefinition_ED_Rowid] FOREIGN KEY ([SUB_EventDefinitionDR]) REFERENCES [dbo].[Alert_EventDefinition] ([ED_Rowid]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_Subscription_SUB_EventMappingDetailsDR_Alert_EventMappingDetails_EMD_Rowid] FOREIGN KEY ([SUB_EventMappingDetailsDR]) REFERENCES [dbo].[Alert_EventMappingDetails] ([EMD_Rowid]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_Subscription_SUB_PriorityDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([SUB_PriorityDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_Subscription_SUB_UserDR_E_entity_ID] FOREIGN KEY ([SUB_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
CREATE NONCLUSTERED INDEX [IX_Alert_Subscription_EventDef]
    ON [dbo].[Alert_Subscription]([SUB_EventDefinitionDR] ASC)
    INCLUDE([SUB_UserDR], [SUB_PriorityDR]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

