CREATE TABLE [dwh].[FACT_LabInfo] (
    [DILR_RowID]                  INT             NOT NULL,
    [DILR_PRRowID]                INT             NOT NULL,
    [DILR_ResultStatusDR]         INT             NULL,
    [DILR_SpecCollectedDate]      DATETIME        NULL,
    [DILR_SpecReceivedDate]       DATETIME        NULL,
    [DILR_SpecBodySiteDR]         INT             NULL,
    [DILR_TestCodingSystemDR]     INT             NULL,
    [DILR_OrganismCodingSystemDR] INT             NULL,
    [DILR_ResultDate]             DATETIME        NULL,
    [DILR_AbnormalFlagDR]         INT             NULL,
    [DILR_LIPTestStatusDR]        INT             NULL,
    [DILR_StandardResultValue]    NUMERIC (14, 4) NULL,
    [DILR_StandardResultUnitDR]   INT             NULL,
    [DILR_IsFromHL7]              BIT             DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FACT_LabInfo_PK] PRIMARY KEY CLUSTERED ([DILR_RowID] ASC) ON [DWH_DataGroup],
    CONSTRAINT [FK_FACT_LabInfo_FACT_PHPersonalRecord] FOREIGN KEY ([DILR_PRRowID]) REFERENCES [dwh].[FACT_PHPersonalRecord] ([PR_RowID]) ON DELETE CASCADE
) ON [DWH_DataGroup];


GO
CREATE NONCLUSTERED INDEX [FACT_LabInfo_DILR_PRRowID_NonClusteredIndex]
    ON [dwh].[FACT_LabInfo]([DILR_PRRowID] ASC)
    INCLUDE([DILR_RowID]) WITH (FILLFACTOR = 80)
    ON [DWH_IndexGroup];


GO
CREATE COLUMNSTORE INDEX [FACT_LabInfo_NonClusteredColumnStoreIndex]
    ON [dwh].[FACT_LabInfo]([DILR_RowID], [DILR_PRRowID], [DILR_ResultStatusDR], [DILR_SpecCollectedDate], [DILR_SpecReceivedDate], [DILR_SpecBodySiteDR], [DILR_TestCodingSystemDR], [DILR_OrganismCodingSystemDR], [DILR_ResultDate], [DILR_AbnormalFlagDR], [DILR_LIPTestStatusDR], [DILR_StandardResultValue], [DILR_StandardResultUnitDR], [DILR_IsFromHL7])
    ON [DWH_IndexGroup];

