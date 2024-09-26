CREATE TABLE [dwh].[FACT_PHPersonalRecord_String] (
    [PR_RowID]            INT            NOT NULL,
    [PR_OtherDiseaseName] NVARCHAR (200) NULL,
    [PR_MedRecNum]        NVARCHAR (50)  NULL,
    [PR_ProviderName]     NVARCHAR (255) NULL,
    [PR_NameOfSubmitter]  NVARCHAR (100) NULL,
    [PR_ClusterID]        VARCHAR (8000) NULL,
    [PR_Notes]            NVARCHAR (MAX) NULL,
    CONSTRAINT [FACT_PHPersonalRecord_String_PK] PRIMARY KEY CLUSTERED ([PR_RowID] DESC) ON [DWH_DataGroup],
    CONSTRAINT [FK_FACT_PHPersonalRecord_String_FACT_PHPersonalRecord] FOREIGN KEY ([PR_RowID]) REFERENCES [dwh].[FACT_PHPersonalRecord] ([PR_RowID]) ON DELETE CASCADE
) ON [DWH_DataGroup] TEXTIMAGE_ON [DWH_TextDataGroup];


GO
CREATE COLUMNSTORE INDEX [FACT_PHPersonalRecord_String_NonClusteredColumnStoreIndex]
    ON [dwh].[FACT_PHPersonalRecord_String]([PR_RowID], [PR_OtherDiseaseName], [PR_MedRecNum], [PR_ProviderName], [PR_NameOfSubmitter], [PR_ClusterID])
    ON [DWH_IndexGroup];

