CREATE TABLE [dbo].[S_SecurityAccess] (
    [CanRead]     BIT          NULL,
    [CanWrite]    BIT          NULL,
    [Type]        VARCHAR (50) NULL,
    [isDefault]   BIT          NULL,
    [SubjCode_ID] INT          NULL,
    [ID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Role_ID]     INT          NULL,
    [SortOrder]   INT          NULL,
    CONSTRAINT [S_SecurityAccess_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_S_SecurityAccess_SubjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_S_SecurityAccess_FK2] FOREIGN KEY ([Role_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [S_SecurityAccess_UK1] UNIQUE NONCLUSTERED ([Role_ID] ASC, [SubjCode_ID] ASC) WITH (FILLFACTOR = 70)
);


GO
ALTER TABLE [dbo].[S_SecurityAccess] NOCHECK CONSTRAINT [FK_A_S_SecurityAccess_SubjCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_SecurityAccess] NOCHECK CONSTRAINT [R_Role_S_SecurityAccess_FK2];

