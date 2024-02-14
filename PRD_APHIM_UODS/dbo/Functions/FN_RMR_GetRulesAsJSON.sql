/********************End Relation creation *****************************************************/

/********************End Index, Constraints and Relation creation *****************************************************/

/********************Start Function and Stored Procedure creation *****************************************************/

/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetRulesAsJSON]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_GetRulesAsJSON] 
(
    @diseaseDR as int, @ruleIdentifierRowID as int
)
RETURNS nvarchar(max)
AS
BEGIN
    declare @jString nvarchar(max)
    set @jString = (
        select convert(varchar(10),RuleRowID) as 'id', isnull(convert (varchar(10),ParentRuleRowID),'#') as 'parent'
        , '' as 'text',RuleName as 'data.ruleName',RuleSelectMostRecent as 'data.selectMostRecent',RuleSkipIfMultipleMatch as 'data.skipIfMultipleMatch'
        ,( SELECT JSON_QUERY(RuleJSON,'$')) 'data.ruleJSON', RuleOrderBy 'data.ruleOrderBy'
        , ImportOption as 'data.action.ImportOption', DemoImportOption as 'data.action.DemographicOption'
        , DistrictDR 'data.routing.PR_DistrictDR',   InvestigatorDR     'data.routing.PR_InvestigatorDR'
        ,AutoCloseIncident 'data.routing.AutoCloseIncident', ProcessStatusDR 'data.routing.PR_ProcessStatusDR',ResolutionStatusDR 'data.routing.PR_ResolutionStatusDR'
        , FinalDispositionDR 'data.routing.PR_FinalDispositionDR', ImportedStatusDR 'data.routing.PR_ImportedStatusDR', DiseaseDR 'data.routing.PR_DiseaseDR'
        , IsAsymptomatic 'data.routing.PR_IsAsymptomatic', IsPregnant 'data.routing.PR_IsPregnant'
        , RuleExecutionCounter 'data.statistics.RuleExecutionCounter' ,RulePercentMatch 'data.statistics.RulePercentMatch'
        from 
        (select top (9999) RD.[RD_RowID] RuleRowID,RH.[RH_ParentRDRowID] ParentRuleRowID,  [RH_Sequence] RuleSequence ,[RD_RuleName] RuleName
            , RD_SelectMostRecent RuleSelectMostRecent,RD_SkipIfMultipleMatch RuleSkipIfMultipleMatch, isnull( [RD_JSON],'') RuleJSON, isnull([RD_OrderBy],'') RuleOrderBy
            ,[RD_Action_ImportOption] ImportOption,[RD_Action_DemoImportOption] DemoImportOption,[RD_Route_ProcessStatusDR] ProcessStatusDR
            ,[RD_Route_ResolutionStatusDR] ResolutionStatusDR,[RD_Route_DistrictDR] DistrictDR,[RD_Route_InvestigatorDR] InvestigatorDR
            ,[RD_Route_FinalDispositionDR] FinalDispositionDR, [RD_Route_ImportedStatusDR] ImportedStatusDR, [RD_Route_DiseaseDR] DiseaseDR
            ,[RD_Route_IsAsymptomatic] IsAsymptomatic, [RD_Route_IsPregnant] IsPregnant
            ,[RD_Route_AutoCloseIncident] AutoCloseIncident
            ,isnull(RS.RS_ExecutionCounter ,0) RuleExecutionCounter, cast(isnull(RS.RS_PercentMatch,0.0) as decimal(5,2)) RulePercentMatch
            from [dbo].[RMR_RuleIdentifier] RI (nolock)
            inner join [dbo].[RMR_RuleHierarchy] RH (nolock) on RI.[RI_RowID]=[RH_RIRowID]
            inner join [dbo].[RMR_RuleDefinition] RD (nolock) on RH.[RH_RDRowID]=RD.[RD_RowID]
            left join [dbo].[RMR_RuleStatistics] RS (nolock) on RD.[RD_RowID] = RS.RS_RDRowID
            where RI.[RI_DiseaseDR]=@diseaseDR and RI.RI_RowID=@ruleIdentifierRowID --and RI.[RI_IsActive]=1
            order by RH.[RH_Sequence]
        ) tmp
        for json path,INCLUDE_NULL_VALUES 
    )
    return @jString
END
