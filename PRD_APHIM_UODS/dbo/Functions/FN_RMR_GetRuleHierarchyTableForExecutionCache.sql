
--------------Execution query cache ------------------------------
/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetRuleHierarchyTableForExecutionCache]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_GetRuleHierarchyTableForExecutionCache]
(
    @diseaseDR int 
)
returns @ruleHierarchyTable Table([RC_RIDiseaseDR] int NOT NULL,[RC_Seq] int NOT NULL,[RC_RIRowID] int NOT NULL,[RC_RDRowID] int NOT NULL,[RC_ParentRDRowID] int NULL
    ,[RC_RuleLevel] int NOT NULL DEFAULT ((0)), [RC_RuleLevelString] varchar(1000) NOT NULL DEFAULT (''),[RC_NextSeqOnFail] int NULL ,[RC_RuleName] nvarchar(1000)
    ,[RC_QueryExpression] nvarchar(max) NULL,[RC_IsQueryReturnRows] bit NOT NULL DEFAULT ((0)),[RC_SkipIfMultipleMatch] bit NOT NULL DEFAULT ((0)),[RC_ParentRuleIDForData] int NULL,[RC_ParentRuleIDForNextRule] int NULL
    ,[RC_IsQueryReturnsPER] bit NOT NULL DEFAULT ((0)),[RC_IsQueryReturnsPR] bit NOT NULL DEFAULT ((0)),    [RC_IsParentSetHasPER] bit NOT NULL DEFAULT ((0)),[RC_IsParentSetHasPR] bit NOT NULL DEFAULT ((0))
    ,[RC_Action_ImportOption] varchar(3) NULL,[RC_Action_DemoImportOption] varchar(3) NULL
    ,[RC_Route_DistrictDR] int NULL,[RC_Route_InvestigatorDR] int NULL, [RC_Route_ProcessStatusDR] int NULL,[RC_Route_ResolutionStatusDR] int NULL, [RC_Route_FinalDispositionDR] int NULL
    ,[RC_Route_ImportedStatusDR] int NULL,[RC_Route_DiseaseDR] int NULL,[RC_Route_IsAsymptomatic] Smallint NULL,[RC_Route_IsPregnant] Smallint NULL)
as
BEGIN

insert into @ruleHierarchyTable ([RC_RIDiseaseDR] ,[RC_Seq] ,[RC_RIRowID],[RC_RDRowID],[RC_ParentRDRowID] ,[RC_RuleLevel],[RC_RuleLevelString],[RC_NextSeqOnFail],[RC_RuleName],[RC_QueryExpression]
    ,[RC_IsQueryReturnRows],[RC_SkipIfMultipleMatch], [RC_ParentRuleIDForData],[RC_ParentRuleIDForNextRule],[RC_IsQueryReturnsPER] ,[RC_IsQueryReturnsPR] , [RC_IsParentSetHasPER],[RC_IsParentSetHasPR]
    ,[RC_Action_ImportOption],[RC_Action_DemoImportOption],[RC_Route_DistrictDR],[RC_Route_InvestigatorDR], [RC_Route_ProcessStatusDR],[RC_Route_ResolutionStatusDR],[RC_Route_FinalDispositionDR],[RC_Route_ImportedStatusDR],[RC_Route_DiseaseDR],[RC_Route_IsAsymptomatic],[RC_Route_IsPregnant])


select RI_DiseaseDR RC_RIDiseaseDR, RH_Sequence RC_Seq,RH_RIRowID RC_RIRowID, RH_RDRowID RC_RDRowID, RH_ParentRDRowID RC_ParentRDRowID, 0 [RC_RuleLevel]
    , '' [RC_RuleLevelString], null [RC_NextSeqOnFail] ,RD_RuleName [RC_RuleName],RD_QueryExpression [RC_QueryExpression]
    , RD_IsQueryReturnRows [RC_IsQueryReturnRows], RD_SkipIfMultipleMatch [RC_SkipIfMultipleMatch], null [RC_ParentRuleIDForData],null [RC_ParentRuleIDForNextRule]
    , dbo.[FN_RMR_GetRuleIsQueryContainTableRef]([RD_TableAliasRefExpression],'SPER',0) [RC_IsQueryReturnsPER] ,dbo.[FN_RMR_GetRuleIsQueryContainTableRef]([RD_TableAliasRefExpression],'SPR',0) [RC_IsQueryReturnsPR] , 0 [RC_IsParentSetHasPER],0 [RC_IsParentSetHasPR]
    ,RD_Action_ImportOption [RC_Action_ImportOption],RD_Action_DemoImportOption [RC_Action_DemoImportOption]
    ,RD_Route_DistrictDR [RC_Route_DistrictDR],RD_Route_InvestigatorDR [RC_Route_InvestigatorDR],   RD_Route_ProcessStatusDR [RC_Route_ProcessStatusDR],RD_Route_ResolutionStatusDR [RC_Route_ResolutionStatusDR]
    ,RD_Route_FinalDispositionDR    [RC_Route_FinalDispositionDR],RD_Route_ImportedStatusDR [RC_Route_ImportedStatusDR], RD_Route_DiseaseDR [RC_Route_DiseaseDR]
    ,RD_Route_IsAsymptomatic [RC_Route_IsAsymptomatic], RD_Route_IsPregnant [RC_Route_IsPregnant]

from dbo.RMR_RuleIdentifier RI (nolock) 
inner join dbo.RMR_RuleHierarchy RH (nolock) on RI.RI_RowID = RH.RH_RIRowID 
inner join dbo.RMR_RuleDefinition RD (nolock) on RH.RH_RDRowID = RD.RD_RowID 
where RI_IsActive=1 and RI_DiseaseDR=@diseaseDR
order by RH.RH_Sequence



---CTE to identify the next parent rule for previous data set and next rule to execute on fail. Also identify the parent data set conatin data with person or both person and incident
;With RuleHirachiCTE(RC_Seq, RC_RuleLevel, RC_RuleLevelString, RC_RDRowID, RC_ParentRDRowID ,RC_ParentRuleIDForData,RC_ParentRuleIDForNextRule,RC_IsParentSetHasPER,RC_IsParentSetHasPR,RC_IsQueryReturnsPER,RC_IsQueryReturnsPR)
as
(
    select RC_SEQ, 0 as RC_RuleLevel, cast('0' as varchar(1000)) RC_RuleLevelString
    ,RC_RDRowID, RC_ParentRDRowID
    , null RC_ParentRuleIDForData, (case when RC_IsQueryReturnRows=1 then RC_RDRowID else null end) RC_ParentRuleIDForNextRule -- These fields are used for hirarical data search
    ,0 RC_IsParentSetHasPER, 0 RC_IsParentSetHasPR,RC_IsQueryReturnsPER,RC_IsQueryReturnsPR
    from @ruleHierarchyTable T 
    where T.RC_ParentRDRowID is null
    union ALL
    select RC_SEQ, PRule.RC_RuleLevel+1 as RC_RuleLevel, cast(PRule.RC_RuleLevelString + ',' + cast(PRule.RC_RuleLevel+1 as varchar(10)) as varchar(1000))  RC_RuleLevelString 
    ,RC_RDRowID, RC_ParentRDRowID
    ,PRule.RC_ParentRuleIDForNextRule RC_ParentRuleIDForData, (case when RC_IsQueryReturnRows=1 then RC_RDRowID else PRule.RC_ParentRuleIDForNextRule end) RC_ParentRuleIDForNextRule
    ,(PRule.RC_IsParentSetHasPER | PRule.RC_IsQueryReturnsPER)  RC_IsParentSetHasPER, (PRule.RC_IsParentSetHasPR | PRule.RC_IsQueryReturnsPR ) RC_IsParentSetHasPR,T.RC_IsQueryReturnsPER,T.RC_IsQueryReturnsPR
    from @ruleHierarchyTable T
    cross apply(
    select RC_RuleLevel, RC_RuleLevelString,RC_ParentRuleIDForData,RC_ParentRuleIDForNextRule,RC_IsParentSetHasPER,RC_IsParentSetHasPR,RC_IsQueryReturnsPER,RC_IsQueryReturnsPR  from RuleHirachiCTE cte  where cte.RC_RDRowID=t.RC_ParentRDRowID
    ) PRule
)
update @ruleHierarchyTable set RC_RuleLevel= c0.RC_RuleLevel, RC_RuleLevelString=c0.RC_RuleLevelString, RC_NextSeqOnFail=nx.RC_NextSeqOnFail
, RC_ParentRuleIDForData=c0.RC_ParentRuleIDForData, RC_ParentRuleIDForNextRule=c0.RC_ParentRuleIDForNextRule
, RC_IsParentSetHasPER=C0.RC_IsParentSetHasPER, RC_IsParentSetHasPR=C0.RC_IsParentSetHasPR
from @ruleHierarchyTable T0
inner join RuleHirachiCTE c0 on t0.RC_Seq=c0.RC_Seq and t0.RC_RDRowID=c0.RC_RDRowID
outer apply(
    select top(1) c1.RC_Seq as RC_NextSeqOnFail from RuleHirachiCTE c1 where c1.RC_RuleLevel<=c0.RC_RuleLevel and c1.RC_SEQ>c0.RC_SEQ  order by RC_SEQ
) nx

return 
--select * from @ruleHierarchyTable
END
