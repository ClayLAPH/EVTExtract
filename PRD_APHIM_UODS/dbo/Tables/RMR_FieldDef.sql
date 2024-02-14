CREATE TABLE [dbo].[RMR_FieldDef] (
    [FD_RowID]             INT             NOT NULL,
    [FD_FSCodeID]          NVARCHAR (10)   NOT NULL,
    [FD_FieldCode]         NVARCHAR (100)  NOT NULL,
    [FD_FieldComputedCode] AS              (([FD_FSCodeID]+'.')+[FD_FieldCode]) PERSISTED NOT NULL,
    [FD_FieldName]         NVARCHAR (500)  NOT NULL,
    [FD_FieldComputedName] AS              ((([FD_FSCodeID]+'.[')+[FD_FieldName])+']') PERSISTED NOT NULL,
    [FD_ResourceKey]       NVARCHAR (500)  NULL,
    [FD_DataType]          NVARCHAR (10)   NOT NULL,
    [FD_DBExpression]      NVARCHAR (500)  NULL,
    [FD_DBTableRefAlias]   NVARCHAR (4000) NULL,
    [FD_IsActive]          BIT             DEFAULT ((0)) NOT NULL,
    [FD_IsVisible]         BIT             NOT NULL,
    [FD_IsOrderByAllowed]  BIT             NOT NULL,
    [FD_IsDictionaty]      BIT             DEFAULT ((0)) NOT NULL,
    [FD_GroupName]         NVARCHAR (100)  NULL,
    [FD_UIPlaceholder]     NVARCHAR (1000) NULL,
    [FD_UIValidationExpr]  NVARCHAR (4000) NULL,
    [FD_UIControlFactory]  NVARCHAR (1000) NULL,
    [FD_UIGetter]          NVARCHAR (4000) NULL,
    [FD_UISetter]          NVARCHAR (4000) NULL,
    [FD_UIPluginName]      NVARCHAR (4000) NULL,
    [FD_UIPluginConfig]    NVARCHAR (4000) NULL,
    [FD_UIValues]          NVARCHAR (4000) NULL,
    CONSTRAINT [PK_FieldDefilition] PRIMARY KEY CLUSTERED ([FD_RowID] ASC) ON [RMR_DataIndexGroup],
    CONSTRAINT [FK_FieldDefilition_FieldSource] FOREIGN KEY ([FD_FSCodeID]) REFERENCES [dbo].[RMR_FieldSource] ([FS_CodeID])
) ON [RMR_DataIndexGroup];


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_FieldDefilition]
    ON [dbo].[RMR_FieldDef]([FD_FieldComputedCode] ASC)
    ON [RMR_DataIndexGroup];

