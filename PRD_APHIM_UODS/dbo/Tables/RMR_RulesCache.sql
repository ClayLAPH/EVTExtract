CREATE TABLE [dbo].[RMR_RulesCache] (
    [RC_RIDiseaseDR]              INT             NOT NULL,
    [RC_Seq]                      INT             NOT NULL,
    [RC_RIRowID]                  INT             NOT NULL,
    [RC_RDRowID]                  INT             NOT NULL,
    [RC_ParentRDRowID]            INT             NULL,
    [RC_RuleLevel]                INT             DEFAULT ((0)) NOT NULL,
    [RC_RuleLevelString]          VARCHAR (1000)  DEFAULT ('') NOT NULL,
    [RC_NextSeqOnFail]            INT             NULL,
    [RC_RuleName]                 NVARCHAR (1000) NOT NULL,
    [RC_QueryExpression]          NVARCHAR (MAX)  NULL,
    [RC_IsQueryReturnRows]        BIT             DEFAULT ((0)) NOT NULL,
    [RC_SkipIfMultipleMatch]      BIT             DEFAULT ((0)) NOT NULL,
    [RC_ParentRuleIDForData]      INT             NULL,
    [RC_ParentRuleIDForNextRule]  INT             NULL,
    [RC_IsQueryReturnsPER]        BIT             DEFAULT ((0)) NOT NULL,
    [RC_IsQueryReturnsPR]         BIT             DEFAULT ((0)) NOT NULL,
    [RC_IsParentSetHasPER]        BIT             DEFAULT ((0)) NOT NULL,
    [RC_IsParentSetHasPR]         BIT             DEFAULT ((0)) NOT NULL,
    [RC_Action_ImportOption]      VARCHAR (3)     NULL,
    [RC_Action_DemoImportOption]  VARCHAR (3)     NULL,
    [RC_Route_DistrictDR]         INT             NULL,
    [RC_Route_InvestigatorDR]     INT             NULL,
    [RC_Route_ProcessStatusDR]    INT             NULL,
    [RC_Route_ResolutionStatusDR] INT             NULL,
    [RC_Route_FinalDispositionDR] INT             NULL,
    [RC_Route_ImportedStatusDR]   INT             NULL,
    [RC_Route_DiseaseDR]          INT             NULL,
    [RC_Route_IsAsymptomatic]     SMALLINT        NULL,
    [RC_Route_IsPregnant]         SMALLINT        NULL,
    [RC_QueryHasError]            AS              (CONVERT([bit],case when charindex('@@ERROR :',[RC_QueryExpression])>(0) OR len(isnull([RC_QueryExpression],''))=(0) then (1) else (0) end)),
    CONSTRAINT [PK_RMR_RulesCache] PRIMARY KEY CLUSTERED ([RC_RIDiseaseDR] ASC, [RC_Seq] ASC) ON [RMR_DataIndexGroup]
) ON [RMR_DataIndexGroup] TEXTIMAGE_ON [RMR_DataIndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_RMR_Rulescache_RC_RIDiseaseDR]
    ON [dbo].[RMR_RulesCache]([RC_RIDiseaseDR] ASC)
    INCLUDE([RC_Seq], [RC_RIRowID], [RC_RDRowID], [RC_ParentRDRowID], [RC_RuleLevel], [RC_RuleLevelString], [RC_NextSeqOnFail], [RC_QueryExpression], [RC_IsQueryReturnRows], [RC_SkipIfMultipleMatch], [RC_ParentRuleIDForData], [RC_ParentRuleIDForNextRule], [RC_IsQueryReturnsPER], [RC_IsQueryReturnsPR], [RC_IsParentSetHasPER], [RC_IsParentSetHasPR], [RC_Action_ImportOption], [RC_Action_DemoImportOption], [RC_Route_DistrictDR], [RC_Route_InvestigatorDR], [RC_Route_ProcessStatusDR], [RC_Route_ResolutionStatusDR], [RC_Route_FinalDispositionDR], [RC_Route_ImportedStatusDR], [RC_Route_DiseaseDR], [RC_Route_IsAsymptomatic], [RC_Route_IsPregnant], [RC_QueryHasError])
    ON [RMR_DataIndexGroup];

