CREATE TABLE [dwh].[FACT_DrugSusceptibility] (
    [DSR_RowID]         INT            NOT NULL,
    [DSR_DILRRowID]     INT            NOT NULL,
    [DSR_PRRowID]       INT            NOT NULL,
    [DSR_DrugDR]        INT            NULL,
    [DSR_OtherDrugName] NVARCHAR (550) NULL,
    [DSR_Concentration] NVARCHAR (255) NULL,
    [DSR_Method]        NVARCHAR (255) NULL,
    [DSR_ResultDR]      INT            NULL,
    CONSTRAINT [FACT_DrugSusceptibility_PK] PRIMARY KEY CLUSTERED ([DSR_RowID] ASC) ON [DWH_DataGroup],
    CONSTRAINT [FK_FACT_DrugSusceptibility_FACT_LabInfo] FOREIGN KEY ([DSR_DILRRowID]) REFERENCES [dwh].[FACT_LabInfo] ([DILR_RowID]) ON DELETE CASCADE
) ON [DWH_DataGroup];


GO
CREATE NONCLUSTERED INDEX [FACT_DrugSusceptibility_DILR_RowID_NonClusteredIndex]
    ON [dwh].[FACT_DrugSusceptibility]([DSR_DILRRowID] ASC) WITH (FILLFACTOR = 80)
    ON [DWH_IndexGroup];


GO
CREATE COLUMNSTORE INDEX [FACT_DrugSusceptibility_NonClusteredColumnStoreIndex]
    ON [dwh].[FACT_DrugSusceptibility]([DSR_RowID], [DSR_DILRRowID], [DSR_PRRowID], [DSR_DrugDR], [DSR_OtherDrugName], [DSR_Concentration], [DSR_Method], [DSR_ResultDR])
    ON [DWH_IndexGroup];

