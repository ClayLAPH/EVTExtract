CREATE TABLE [dbo].[RMR_ComparisonOperator] (
    [CO_RowID]             INT             NOT NULL,
    [CO_Name]              VARCHAR (100)   NOT NULL,
    [CO_Value]             VARCHAR (50)    NOT NULL,
    [CO_Expression]        NVARCHAR (1000) NOT NULL,
    [CO_IsActive]          BIT             DEFAULT ((0)) NOT NULL,
    [CO_IsValueAutoQuoted] BIT             DEFAULT ((0)) NOT NULL,
    [CO_DBTableRefAlias]   NVARCHAR (1000) NULL,
    CONSTRAINT [PK_FieldComparisonOperator] PRIMARY KEY CLUSTERED ([CO_RowID] ASC) ON [RMR_DataIndexGroup]
) ON [RMR_DataIndexGroup];


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_FieldComparisonOperator]
    ON [dbo].[RMR_ComparisonOperator]([CO_Name] ASC)
    ON [RMR_DataIndexGroup];

