CREATE TABLE [dbo].[S_MergeSplitHistory] (
    [MSH_ID]               INT         IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [MSH_IsForMerge]       BIT         NULL,
    [MSH_Source_Act_ID]    INT         NULL,
    [MSH_Target_Act_ID]    INT         NULL,
    [MSH_Source_Entity_ID] INT         NULL,
    [MSH_Target_Entity_ID] INT         NULL,
    [MSH_Type]             VARCHAR (5) NULL,
    CONSTRAINT [S_MergeSplitHistory_PK] PRIMARY KEY CLUSTERED ([MSH_ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [S_MergeSplitHistory_A_Act_FK1] FOREIGN KEY ([MSH_Source_Act_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [S_MergeSplitHistory_A_Act_FK2] FOREIGN KEY ([MSH_Target_Act_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [S_MergeSplitHistory_E_Entity_FK1] FOREIGN KEY ([MSH_Source_Entity_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [S_MergeSplitHistory_E_Entity_FK2] FOREIGN KEY ([MSH_Target_Entity_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_MergeSplitHistory] NOCHECK CONSTRAINT [S_MergeSplitHistory_A_Act_FK1];


GO
ALTER TABLE [dbo].[S_MergeSplitHistory] NOCHECK CONSTRAINT [S_MergeSplitHistory_A_Act_FK2];


GO
ALTER TABLE [dbo].[S_MergeSplitHistory] NOCHECK CONSTRAINT [S_MergeSplitHistory_E_Entity_FK1];


GO
ALTER TABLE [dbo].[S_MergeSplitHistory] NOCHECK CONSTRAINT [S_MergeSplitHistory_E_Entity_FK2];


GO
CREATE NONCLUSTERED INDEX [IX_S_MergeSplitHistory_IsForMerge]
    ON [dbo].[S_MergeSplitHistory]([MSH_IsForMerge] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_S_MergeSplitHistory_Type]
    ON [dbo].[S_MergeSplitHistory]([MSH_Type] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_S_MergeSplitHistory_SourceActID]
    ON [dbo].[S_MergeSplitHistory]([MSH_Source_Act_ID] ASC, [MSH_Type] ASC) WITH (FILLFACTOR = 70);

