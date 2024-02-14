CREATE TABLE [dbo].[RMR_RuleIdentifier] (
    [RI_RowID]      INT      IDENTITY (1, 1) NOT NULL,
    [RI_IsActive]   BIT      NULL,
    [RI_CreateDate] DATETIME NULL,
    [RI_DiseaseDR]  INT      NOT NULL,
    CONSTRAINT [PK_RuleIdentifier] PRIMARY KEY CLUSTERED ([RI_RowID] ASC) ON [RMR_DataIndexGroup]
) ON [RMR_DataIndexGroup];


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Disease_Active_Unique]
    ON [dbo].[RMR_RuleIdentifier]([RI_IsActive] ASC, [RI_DiseaseDR] ASC) WHERE ([RI_IsActive]=(1))
    ON [RMR_DataIndexGroup];

