CREATE TABLE [dbo].[S_PreMergeSplitData] (
    [PMSD_ID]                   INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PMSD_MergeSplitHistory_FK] INT           NULL,
    [PMSD_Type]                 VARCHAR (1)   NULL,
    [PMSD_Property_Name]        VARCHAR (100) NULL,
    [PMSD_Property_Value]       VARCHAR (MAX) NULL,
    [PMSD_EquivalentIntgerID]   AS            (case when [PMSD_Property_Name]='PR_InstanceID' OR [PMSD_Property_Name]='PR_PersonDR' then CONVERT([int],CONVERT([varchar](50),[PMSD_Property_Value]))  end) PERSISTED,
    CONSTRAINT [S_PreMergeSplitData_PK] PRIMARY KEY CLUSTERED ([PMSD_ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [S_PreMergeSplitData_S_MergeSplitHistory_FK] FOREIGN KEY ([PMSD_MergeSplitHistory_FK]) REFERENCES [dbo].[S_MergeSplitHistory] ([MSH_ID])
);


GO
ALTER TABLE [dbo].[S_PreMergeSplitData] NOCHECK CONSTRAINT [S_PreMergeSplitData_S_MergeSplitHistory_FK];


GO
CREATE NONCLUSTERED INDEX [IX_PMSD_MergeSplitDataInteger]
    ON [dbo].[S_PreMergeSplitData]([PMSD_Type] ASC, [PMSD_Property_Name] ASC)
    INCLUDE([PMSD_MergeSplitHistory_FK], [PMSD_EquivalentIntgerID]) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_PMSD_MergeSplitHistoryFK]
    ON [dbo].[S_PreMergeSplitData]([PMSD_MergeSplitHistory_FK] ASC)
    INCLUDE([PMSD_Type], [PMSD_Property_Name]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

