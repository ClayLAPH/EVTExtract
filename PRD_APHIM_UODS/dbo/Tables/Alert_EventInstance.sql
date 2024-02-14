CREATE TABLE [dbo].[Alert_EventInstance] (
    [EI_RowID]                 INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EI_PriorityDR]            INT             NULL,
    [EI_EventDefinitionDR]     INT             NULL,
    [EI_Subject]               NVARCHAR (255)  NULL,
    [EI_Message]               NVARCHAR (MAX)  NULL,
    [EI_DistrictRef]           NVARCHAR (50)   NULL,
    [EI_DistrictGroupsRef]     NVARCHAR (4000) NULL,
    [EI_EventMappingDetailsDR] INT             NULL,
    CONSTRAINT [PK_EventInstance] PRIMARY KEY CLUSTERED ([EI_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Alert_EventInstance_EI_EventDefinitionDR_Alert_EventDefinition_ED_Rowid] FOREIGN KEY ([EI_EventDefinitionDR]) REFERENCES [dbo].[Alert_EventDefinition] ([ED_Rowid]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_EventInstance_EI_EventMappingDetailsDR_Alert_EventMappingDetails_EMD_Rowid] FOREIGN KEY ([EI_EventMappingDetailsDR]) REFERENCES [dbo].[Alert_EventMappingDetails] ([EMD_Rowid]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_EventInstance_EI_PriorityDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([EI_PriorityDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);

