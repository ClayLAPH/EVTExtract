CREATE TABLE [dbo].[RMR_RuleRecordStatisticsDetails] (
    [RRSD_RowID]                   BIGINT   IDENTITY (1, 1) NOT NULL,
    [RRSD_RRSRowID]                BIGINT   NOT NULL,
    [RRSD_RDRowID]                 INT      NOT NULL,
    [RRSD_ExecutionStartDate]      DATETIME DEFAULT (getdate()) NOT NULL,
    [RRSD_ExecutionEndDate]        DATETIME DEFAULT (getdate()) NOT NULL,
    [RRSD_ExecutionDurationInMS]   AS       (datediff(millisecond,[RRSD_ExecutionStartDate],[RRSD_ExecutionEndDate])),
    [RRSD_IsMatchFound]            BIT      DEFAULT ((0)) NOT NULL,
    [RRSD_IsMatchSkipped]          BIT      DEFAULT ((0)) NOT NULL,
    [RRSD_IsImportActionApplied]   TINYINT  DEFAULT ((0)) NOT NULL,
    [RRSD_IsRoutingOptionsApplied] TINYINT  DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_RuleRecordStatisticsDetails] PRIMARY KEY CLUSTERED ([RRSD_RowID] ASC) ON [RMR_DataIndexGroup],
    CONSTRAINT [FK_RuleRecordStatisticsDetails_RuleDefinition] FOREIGN KEY ([RRSD_RDRowID]) REFERENCES [dbo].[RMR_RuleDefinition] ([RD_RowID]),
    CONSTRAINT [FK_RuleRecordStatisticsDetails_RuleRecordStatistic] FOREIGN KEY ([RRSD_RRSRowID]) REFERENCES [dbo].[RMR_RuleRecordStatistics] ([RRS_RowID])
) ON [RMR_DataIndexGroup];


GO
CREATE NONCLUSTERED INDEX [RMR_RuleRecordStatisticsDetails_RRSD_RowID_NonClusteredIndex]
    ON [dbo].[RMR_RuleRecordStatisticsDetails]([RRSD_RRSRowID] ASC)
    INCLUDE([RRSD_RDRowID]) WITH (FILLFACTOR = 80)
    ON [RMR_DataIndexGroup];

