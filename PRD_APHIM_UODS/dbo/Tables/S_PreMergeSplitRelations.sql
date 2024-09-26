CREATE TABLE [dbo].[S_PreMergeSplitRelations] (
    [PMSR_ID]                   INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PMSR_MergeSplitHistory_FK] INT           NULL,
    [PMSR_Master_Object_Name]   VARCHAR (50)  NULL,
    [PMSR_Master_Property_Name] VARCHAR (100) NULL,
    [PMSR_Master_PK]            INT           NULL,
    [PMSR_Original_ID]          INT           NULL,
    CONSTRAINT [S_PreMergeSplitRelations_PK] PRIMARY KEY CLUSTERED ([PMSR_ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [S_PreMergeSplitRelations_S_MergeSplitHistory_FK] FOREIGN KEY ([PMSR_MergeSplitHistory_FK]) REFERENCES [dbo].[S_MergeSplitHistory] ([MSH_ID])
);


GO
ALTER TABLE [dbo].[S_PreMergeSplitRelations] NOCHECK CONSTRAINT [S_PreMergeSplitRelations_S_MergeSplitHistory_FK];

