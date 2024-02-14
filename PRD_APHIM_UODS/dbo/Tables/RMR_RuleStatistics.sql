CREATE TABLE [dbo].[RMR_RuleStatistics] (
    [RS_RDRowID]          INT    NOT NULL,
    [RS_ExecutionCounter] BIGINT DEFAULT ((0)) NOT NULL,
    [RS_MatchCounter]     BIGINT DEFAULT ((0)) NOT NULL,
    [RS_SkipCounter]      BIGINT DEFAULT ((0)) NOT NULL,
    [RS_PercentMatch]     AS     (((100.0)*[RS_MatchCounter])/[RS_ExecutionCounter]),
    CONSTRAINT [PK_RuleStatistics] PRIMARY KEY CLUSTERED ([RS_RDRowID] ASC) ON [RMR_DataIndexGroup],
    CONSTRAINT [FK_RuleStatistics_RuleDefinition] FOREIGN KEY ([RS_RDRowID]) REFERENCES [dbo].[RMR_RuleDefinition] ([RD_RowID])
) ON [RMR_DataIndexGroup];

