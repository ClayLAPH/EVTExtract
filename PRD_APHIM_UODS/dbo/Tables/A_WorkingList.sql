CREATE TABLE [dbo].[A_WorkingList] (
    [ownershipLevelCode_OrTx] VARCHAR (50) NULL,
    [ownershipLevelCode_ID]   INT          NULL,
    [ID]                      INT          NOT NULL,
    CONSTRAINT [A_WorkingList_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_WorkingList_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_WorkingList_ownershipLevelCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ownershipLevelCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_WorkingList] NOCHECK CONSTRAINT [A_Act_A_WorkingList_FK1];


GO
ALTER TABLE [dbo].[A_WorkingList] NOCHECK CONSTRAINT [FK_A_A_WorkingList_ownershipLevelCode_ID_V_UNIFIEDCODESET];

