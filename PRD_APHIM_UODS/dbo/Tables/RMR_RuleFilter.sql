CREATE TABLE [dbo].[RMR_RuleFilter] (
    [RF_RowID]                         INT             IDENTITY (1, 1) NOT NULL,
    [RF_ParentRowID]                   INT             NULL,
    [RF_Sequence]                      INT             NOT NULL,
    [RF_RuleRowID]                     INT             NOT NULL,
    [RF_GroupCondition]                NVARCHAR (100)  NULL,
    [RF_GroupIsNot]                    BIT             NULL,
    [RF_IsGroupType]                   BIT             DEFAULT ((0)) NOT NULL,
    [RF_LeftField]                     NVARCHAR (500)  NOT NULL,
    [RF_Operator]                      NVARCHAR (50)   NOT NULL,
    [RF_RightFieldValue]               NVARCHAR (4000) NULL,
    [RF_RightFieldObject]              NVARCHAR (MAX)  NULL,
    [RF_DataType]                      VARCHAR (10)    NULL,
    [RF_IsCached]                      BIT             DEFAULT ((0)) NOT NULL,
    [RF_FilterExpression]              AS              ([dbo].[FN_RMR_GetFilterExpressionForColumn]([RF_RowID])),
    [RF_FilterTableAliasRefExpression] AS              ([dbo].[FN_RMR_GetFilterTableAliasRefExpressionForColumn]([RF_RowID])),
    CONSTRAINT [PK_RuleFilter] PRIMARY KEY CLUSTERED ([RF_RowID] ASC) ON [RMR_DataIndexGroup]
) ON [RMR_DataIndexGroup] TEXTIMAGE_ON [RMR_DataIndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_RuleFilter_RuleRowID]
    ON [dbo].[RMR_RuleFilter]([RF_RuleRowID] ASC) WITH (FILLFACTOR = 80)
    ON [RMR_DataIndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_RMR_RuleFilter_RF_ParentRowID]
    ON [dbo].[RMR_RuleFilter]([RF_ParentRowID] ASC) WITH (FILLFACTOR = 80)
    ON [RMR_DataIndexGroup];

