CREATE TABLE [dbo].[RMR_FieldTableDef] (
    [FTD_RowID]               INT            NOT NULL,
    [FTD_TableExpression]     NVARCHAR (MAX) NOT NULL,
    [FTD_TableAlias]          VARCHAR (50)   NOT NULL,
    [FTD_DependentTableAlias] VARCHAR (4000) NOT NULL,
    [FTD_IsReturnRows]        BIT            NOT NULL,
    [FTD_IsActive]            BIT            DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_FieldTableDef] PRIMARY KEY CLUSTERED ([FTD_RowID] ASC) ON [RMR_DataIndexGroup]
) ON [RMR_DataIndexGroup] TEXTIMAGE_ON [RMR_DataIndexGroup];


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_QueryFieldTableDef]
    ON [dbo].[RMR_FieldTableDef]([FTD_TableAlias] ASC)
    ON [RMR_DataIndexGroup];

