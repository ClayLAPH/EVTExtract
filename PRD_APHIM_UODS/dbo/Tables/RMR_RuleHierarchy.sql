CREATE TABLE [dbo].[RMR_RuleHierarchy] (
    [RH_RIRowID]       INT NOT NULL,
    [RH_RDRowID]       INT NOT NULL,
    [RH_ParentRDRowID] INT NULL,
    [RH_Sequence]      INT NOT NULL,
    CONSTRAINT [PK_RuleHierarchy] PRIMARY KEY CLUSTERED ([RH_RIRowID] ASC, [RH_RDRowID] ASC) ON [RMR_DataIndexGroup],
    CONSTRAINT [FK_RuleHierarchy_RuleDefinition] FOREIGN KEY ([RH_RDRowID]) REFERENCES [dbo].[RMR_RuleDefinition] ([RD_RowID]),
    CONSTRAINT [FK_RuleHierarchy_RuleIdentifier] FOREIGN KEY ([RH_RIRowID]) REFERENCES [dbo].[RMR_RuleIdentifier] ([RI_RowID])
) ON [RMR_DataIndexGroup];

