CREATE TABLE [dbo].[RMR_FieldSource] (
    [FS_CodeID]      NVARCHAR (10)  NOT NULL,
    [FS_Description] NVARCHAR (500) NOT NULL,
    [FS_IsActive]    BIT            DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_FieldSource] PRIMARY KEY CLUSTERED ([FS_CodeID] ASC) ON [RMR_DataIndexGroup]
) ON [RMR_DataIndexGroup];

