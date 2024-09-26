CREATE TABLE [dbo].[S_UserGroupInAccessibleProcessStatus] (
    [UG_RowID]           INT NOT NULL,
    [UG_ProcessStatusID] INT NOT NULL,
    CONSTRAINT [PK_S_UserGroupInAccessibleProcessStatus] PRIMARY KEY CLUSTERED ([UG_RowID] ASC, [UG_ProcessStatusID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_S_UserGroupInAccessibleProcessStatus_R_Role] FOREIGN KEY ([UG_RowID]) REFERENCES [dbo].[R_Role] ([ID]),
    CONSTRAINT [FK_S_UserGroupInAccessibleProcessStatus_V_UnifiedCodeSet] FOREIGN KEY ([UG_ProcessStatusID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID])
);


GO
ALTER TABLE [dbo].[S_UserGroupInAccessibleProcessStatus] NOCHECK CONSTRAINT [FK_S_UserGroupInAccessibleProcessStatus_R_Role];


GO
ALTER TABLE [dbo].[S_UserGroupInAccessibleProcessStatus] NOCHECK CONSTRAINT [FK_S_UserGroupInAccessibleProcessStatus_V_UnifiedCodeSet];

