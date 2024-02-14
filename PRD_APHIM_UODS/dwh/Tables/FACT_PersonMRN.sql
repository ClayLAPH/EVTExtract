CREATE TABLE [dwh].[FACT_PersonMRN] (
    [PER_MRNRowID]       INT           NOT NULL,
    [PER_ParentRowID]    INT           NOT NULL,
    [PER_MRN]            NVARCHAR (50) NULL,
    [PER_ReportSourceDR] INT           NULL,
    CONSTRAINT [PK_FACT_PersonMRN] PRIMARY KEY CLUSTERED ([PER_MRNRowID] ASC) ON [DWH_DataGroup],
    CONSTRAINT [FK_FACT_PersonMRN_FACT_Person] FOREIGN KEY ([PER_ParentRowID]) REFERENCES [dwh].[FACT_Person] ([PER_RowID]) ON DELETE CASCADE
) ON [DWH_DataGroup];


GO
CREATE NONCLUSTERED INDEX [FACT_PersonMRN_PER_ParentRowID_NonClusteredIndex]
    ON [dwh].[FACT_PersonMRN]([PER_ParentRowID] ASC) WITH (FILLFACTOR = 80)
    ON [DWH_IndexGroup];


GO
CREATE COLUMNSTORE INDEX [FACT_PersonMRN_NonClusteredColumnStoreIndex]
    ON [dwh].[FACT_PersonMRN]([PER_MRNRowID], [PER_ParentRowID], [PER_MRN], [PER_ReportSourceDR])
    ON [DWH_IndexGroup];

