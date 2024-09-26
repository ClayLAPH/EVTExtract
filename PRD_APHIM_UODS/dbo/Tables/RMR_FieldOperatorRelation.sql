CREATE TABLE [dbo].[RMR_FieldOperatorRelation] (
    [FOR_FDRowID]  INT NOT NULL,
    [FOR_CORowID]  INT NOT NULL,
    [FOR_IsActive] BIT DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_FieldOperatorRelation] PRIMARY KEY CLUSTERED ([FOR_FDRowID] ASC, [FOR_CORowID] ASC) ON [RMR_DataIndexGroup],
    CONSTRAINT [FK_FieldOperatorRelation_ComparisonOperator] FOREIGN KEY ([FOR_CORowID]) REFERENCES [dbo].[RMR_ComparisonOperator] ([CO_RowID]) ON DELETE CASCADE,
    CONSTRAINT [FK_FieldOperatorRelation_FieldDef] FOREIGN KEY ([FOR_FDRowID]) REFERENCES [dbo].[RMR_FieldDef] ([FD_RowID]) ON DELETE CASCADE
) ON [RMR_DataIndexGroup];

